import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import Constants 1.0
import "models"
import "qrc:/scripts/interface.js" as Interface


Drawer{
    id: _phoneDrawer2
//    Overlay.modal: Rectangle {
//        color: "darkgrey"
//    }
    Material.theme: Material.Dark
    contentItem: ColumnLayout{
        id: _phoneDrawerCol
        width: parent.width
        Pane{
            id: _phoneNavTop
            Layout.fillWidth: true
            Layout.preferredHeight: _detailsCol.implicitHeight * 1.2
            Layout.alignment: Qt.AlignTop
            Material.background: Material.color(Material.Teal,Material.Shade700)
            contentItem: ColumnLayout{
                id: _detailsCol
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 10
                Item{
                    id: _imgCont
                    readonly property real _minimum: 170
                    Layout.preferredWidth: 80
                    Layout.preferredHeight: 80
                    Image{
                        id: _bookImg
                        source: "https://randomuser.me/api/portraits/men/25.jpg"
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
                            radius: (80 / 2)
                            visible: false
                        }
                    }
                }
                Label{
                    id: _usernameText
                    text: "scott.izidore@gmail.com"
                    font: Constants.fonts.h4
                    Layout.fillWidth: true
                    Material.foreground: Material.color(Material.Grey,Material.Shade100)
                    wrapMode: "WordWrap"
                }
                Label{
                    id: _faculty
                    text: "Software Engineering"
                    font: Constants.fonts.h4
                    Layout.fillWidth: true
                    Material.foreground: Material.color(Material.Grey)
                    wrapMode: "WordWrap"
                }
            }
        }
        ListModel{
            id: _navBarListModel
            ListElement{
                navItem: "Home"
            }
            ListElement{
                navItem: "Favorites"
            }
            ListElement{
                navItem: "Categories"
            }
        }
        CategoriesModel{
            id: _categoriesListModel
        }
        Component{
            id: _phoneCategories
            ListView{
                id: _phoneDrawerNavItems2
                Layout.margins: 10
                spacing: 10
                interactive: false
                header: RowLayout{
                    width: _phoneDrawerNavItems2.width
                    RoundButton{
                        id: _rightArrow
                        icon.source: Constants.icons.chevronLeft
                        icon.color: Material.color(Material.Grey,Material.Shade100)
                        padding: 20
                        Layout.alignment: Qt.AlignLeft
                        Material.background: "transparent"
                        onClicked: _phoneNavStack.pop()
                    }
                    Label{
                        text: "back"
                        font: Constants.fonts.h4
                        Layout.fillWidth: true
                        Material.foreground: Material.color(Material.Grey,Material.Shade100)
                        wrapMode: "WordWrap"
                    }
                }
                model: _categoriesListModel
                delegate: ItemDelegate{
                    id: _phoneDel
                    text: key
                    font: Constants.fonts.h3
                    Material.foreground: (_phoneDrawerNavItems2.currentIndex === index) ? Material.color(Material.Teal,Material.Shade700) : Material.color(Material.Grey)
                    width: _phoneDrawerNavItems2.width
                    onClicked: {
                        _phoneDrawerNavItems2.currentIndex = index
                        _currentIndex = _navBarListModel.count - 1
                        _mainPage2.categoriesChanged(_phoneDel.text)
                        _phoneDrawer.close()
                    }
                }
            }
        }
        StackView{
            id: _phoneNavStack
            Layout.fillWidth: true
            Layout.fillHeight: true
            initialItem: ListView{
                id: _phoneDrawerNavItems
                Layout.margins: 10
                spacing: 10
                currentIndex: _currentIndex
                interactive: false
                model: ["Home","Favorites","Categories"]
                delegate: ItemDelegate{
                    id: _phoneDel
                    text: modelData
                    font: Constants.fonts.h3
                    width: _phoneDrawerNavItems.width
                    onClicked: {
                        if (modelData === "Categories"){
                            _phoneNavStack.push(_phoneCategories)
                        }
                        else{
                            _currentIndex = index
                            _phoneDrawer.close()
                        }
                    }
                    contentItem: RowLayout{
                        Label{
                            text: _phoneDel.text
                            font: Constants.fonts.h3
                            Layout.fillWidth: true
                            Material.foreground: (_currentIndex === index) ? Material.color(Material.Teal,Material.Shade700) : Material.color(Material.Grey)
                            wrapMode: "WordWrap"
                            Layout.alignment: Qt.AlignLeft
                        }
                        RoundButton{
                            id: _rightArrow
                            icon.source: Constants.icons.chevronRight
                            icon.color: (_currentIndex === index) ? Material.color(Material.Teal,Material.Shade700) : Material.color(Material.Grey)
                            padding: 20
                            Layout.alignment: Qt.AlignRight
                            Material.background: "transparent"
                            visible: _phoneDel.text === "Categories"
                        }
                    }
                }
            }
        }
    }
}
