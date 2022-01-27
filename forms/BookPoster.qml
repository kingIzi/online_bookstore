import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import Constants 1.0

ItemDelegate{
    id: _bookPosterCont
    implicitHeight: _col.implicitHeight * 1.2 //needed because of the ColumnLayout margins
    property bool _isFavorite: false
    on_IsFavoriteChanged: {
        if (_isFavorite) {  _booksContainer.savePoster(index) }
        else if (!_isFavorite) { _booksContainer.unSavePoster(index) }
    }
    Binding{
        target: _bookPosterCont.background
        property: "border.width"
        value: 1
    }
    Binding{
        target: _bookPosterCont.background
        property: "radius"
        value: 10
    }
    Binding{
        target: _bookPosterCont.background
        property: "border.color"
        value: Material.color(Material.Teal,Material.Shade700)
    }
    Component.onCompleted: {
        const data = _fetched.get(index)
        const favorites = _items._favoritesListModel
        for (let y = 0; y < favorites.count; y++){
            if (data === favorites.get(y)) { _isFavorite = !_isFavorite }
        }
    }
    contentItem: ColumnLayout{
        id: _col
        width: parent.width
        anchors.fill: parent
        anchors.margins: 10
        Item{
            id: _imgCont
            readonly property real _minimum: 170
            Layout.fillWidth: true
            Layout.maximumHeight: _minimum
            Layout.minimumHeight: _minimum
            Image{
                id: _bookImg
                source: _posterImg
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: mask
                }
                Rectangle {
                    id: mask
                    width: _bookImg.width
                    height: _bookImg.height
                    radius: 20
                    visible: false
                }
            }
        }
        Label{
            id: _title
            text: _bookTitle
            font: (_root.isLarge) ? Constants.fonts.h3 : Constants.fonts.h4
            Material.foreground: "#fff"
            wrapMode: "WordWrap"
            Layout.fillWidth: true
            maximumLineCount: 3
        }
        Flow{
            id: _authorFlow
            Layout.fillWidth: true
            spacing: 4
            Label{
                id: _authorLabel
                text: "Author:"
                font: (_root.isLarge) ? Constants.fonts.h4 : Constants.fonts.p
                wrapMode: "WordWrap"
                Layout.fillWidth: true
            }
            Label{
                id: _author
                text: _bookAuthor
                font: (_root.isLarge) ? Constants.fonts.h4 : Constants.fonts.p
                Material.foreground: "#fff"
                wrapMode: "WordWrap"
                Layout.fillWidth: true
            }
        }
        Flow{
            id: _subjectFlow
            Layout.fillWidth: true
            spacing: 4
            Label{
                id: _subjectLabel
                text: "Subject:"
                font: (_root.isLarge) ? Constants.fonts.h4 : Constants.fonts.p
                wrapMode: "WordWrap"
                Layout.fillWidth: true
            }
            Label{
                id: _subj
                text: _subject
                font: (_root.isLarge) ? Constants.fonts.h4 : Constants.fonts.p
                Material.foreground: "#fff"
                wrapMode: "WordWrap"
                Layout.fillWidth: true
            }
        }
        Flow{
            id: _categorylow
            Layout.fillWidth: true
            Label{
                id: _categoryLabel
                text: "Category:"
                font: (_root.isLarge) ? Constants.fonts.h4 : Constants.fonts.p
                wrapMode: "WordWrap"
                Layout.fillWidth: true
            }
            Label{
                id: _categoryText
                text: _category
                font: (_root.isLarge) ? Constants.fonts.h4 : Constants.fonts.p
                Material.foreground: "#fff"
                wrapMode: "WordWrap"
                Layout.fillWidth: true
            }
        }
        ToolSeparator{
            orientation: "Horizontal"
            Layout.fillWidth: true
        }
        RowLayout{
            id: _bookPosterRow
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter
            RoundButton{
                icon.source: "qrc:/icons/auto_stories_black_36dp.svg"
                Material.foreground: "#fff"
                Material.background: Material.color(Material.Teal,Material.Shade700)
                padding: 20
            }
            RoundButton{
                id: _favoriteBtn
                icon.source: "qrc:/icons/favorite_black_36dp.svg"
                Material.background: Material.color(Material.Teal,Material.Shade700)
                padding: 20
                onClicked: _isFavorite = !_isFavorite
                states: [
                    State {
                        when: (!_isFavorite)
                        PropertyChanges {
                            target: _favoriteBtn
                            Material.foreground: "#fff"
                        }
                    },
                    State {
                        when: (_isFavorite)
                        PropertyChanges {
                            target: _favoriteBtn
                            Material.foreground: Material.color(Material.Red,Material.Shade700)
                        }
                    }
                ]
            }
            RoundButton{
                icon.source: "qrc:/icons/format_list_bulleted_black_36dp.svg"
                Material.foreground: "#fff"
                Material.background: Material.color(Material.Teal,Material.Shade700)
                padding: 20
            }
        }
    }
}
