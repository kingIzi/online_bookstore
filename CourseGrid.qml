import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import Constants 1.0
import "models"
import "qrc:/scripts/interface.js" as Interface

Item{
    id: _booksContainer
    width: _root.width
    implicitHeight: _booksColumn.implicitHeight
    property string nowShowing: "Most Popular"
    signal savePoster(int index)
    signal unSavePoster(int index)
    property ListModel _fetched: BooksListModel{}
    Connections{
        target: _booksContainer
        function onSavePoster(index){
            _items._favoritesListModel.append(_fetched.get(index))
        }
        function onUnSavePoster(index){
            _items._favoritesListModel.remove(index)
        }
    }
    ColumnLayout{
        id: _booksColumn
        anchors.fill: parent
        spacing: 20
        Frame{
            id: _headerFrame
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            Binding{
                target: _headerFrame.background
                property: "border.width"
                value: (nowShowing.length > 0) ? 1 : 0
            }
            contentItem: RowLayout{
                id: _booksRow
                Label{
                    id: _popular
                    text: (nowShowing.length > 0) ? nowShowing : "Favorites"
                    font: (_root.isLarge) ? Constants.fonts.h3 : Constants.fonts.h4
                    Material.foreground: "#fff"
                    Layout.fillWidth: true
                    wrapMode: "WordWrap"
                    Layout.alignment: Qt.AlignLeft
                }
            }
        }
        Item{
            id: _booksCont
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: _booksGrid.implicitHeight
            GridLayout{
                id: _booksGrid
                anchors.fill: parent
                columns: (_root.isLarge) ? 3 : ((_root.isMedium) ? 2 : 1)
                rowSpacing: 20
                columnSpacing: rowSpacing
                Repeater{
                    id: _booksRept
                    model: _fetched
                    delegate: BookPoster{
                        id: _bookPoster
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}
