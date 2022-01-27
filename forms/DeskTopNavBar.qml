import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import Constants 1.0
import "models"

ToolBar{
    id: _navBar
    Material.background: Material.color(Material.Grey,Material.Shade900)
    Material.elevation: 4
    z: 2
    contentItem: RowLayout{
        id: _navBarRow
        readonly property ComboBox _currentNavItem: _navLinks.itemAtIndex(_currentIndex)
        Label{
            id: _logoCont
            text: "Logo"
            font: Constants.fonts.logo
            Layout.alignment: Qt.AlignLeft
            Material.foreground: "#000"
            Layout.leftMargin: 10
        }
        Item{
            id: _rect
            readonly property int _Max: 448
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumWidth: _Max
            ListView{
                id: _navLinks
                width: _rect._Max
                height: _navBar.height
                interactive: false
                clip: true
                Layout.fillWidth: true
                orientation: ListView.Horizontal
                spacing: 10
                currentIndex: _currentIndex
                anchors.verticalCenter: parent.verticalCenter
                model: NavBarListModel{
                    id: _navBarListModel
                }
                delegate: ComboBox{
                    id: _navItem
                    Item{
                        id: _hideDownArrow
                    }
                    width: ((_navLinks.width / 3))
                    displayText: navItem
                    font: Constants.fonts.h4
                    Material.foreground: (_currentIndex === index) ? Material.color(Material.Teal,Material.Shade700) : Material.Grey
                    anchors.verticalCenter: parent.verticalCenter
                    editable: false
                    flat: true
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: "PointingHandCursor"
                        onClicked: {
                            if (index !== (_navLinks.count - 1)){
                                _currentIndex = index
                            }
                            else{
                                _navItem.popup.open()
                            }
                        }
                    }
                    textRole: "key"
                    Material.accent: Material.color(Material.Teal,Material.Shade700)
                    popup: Popup {
                        y: _navItem.height - 1
                        width: 300
                        implicitHeight: contentItem.implicitHeight
                        contentItem: ListView {
                            clip: true
                            implicitHeight: contentHeight
                            model: _navItem.popup.visible ? _navItem.delegateModel : null
                            currentIndex: _navItem.highlightedIndex
                        }
                    }
                    CategoriesModel{
                        id: _categoriesListModel
                    }
                    model: (_navItem.displayText === "Categories") ? _categoriesListModel : []
                    delegate: ItemDelegate{
                        id: category
                        width: parent.width
                        text: key
                        font: _navItem.font
                        Material.accent: Material.color(Material.Teal)
                        Material.foreground: (_navItem.currentIndex === index) ? Material.color(Material.Teal) : "#fff"
                        onClicked: {
                            _navItem.currentIndex = index
                            _currentIndex = _navBarListModel.count - 1
                            _mainPage2.categoriesChanged(category.text)
                        }
                    }
                    states: [
                        State {
                            when: (_navItem.displayText !== "Categories")
                            PropertyChanges {
                                target: _navItem
                                indicator: _hideDownArrow
                            }
                            PropertyChanges {
                                target: _navItem
                                width: 104
                            }
                        }
                    ]
                }
            }
        }
        Item{
            id: _navActions
            Layout.fillWidth: true
            Layout.fillHeight: true
            RowLayout{
                id: _actionsRow
                anchors.fill: parent
                spacing: 20
                TextField{
                    id: _search
                    Layout.fillWidth: true
                    placeholderText: "Type to search for your favorite books..."
                    font: Constants.fonts.h4
                    Material.accent: Material.color(Material.Teal)
                    Material.foreground: "#fff"
                }
                Button{
                    id: _upload
                    icon.source: "qrc:/icons/file_upload_black_36dp.svg"
                    text: "Upload Syllabus"
                    font: Constants.fonts.h4
                    Layout.alignment: Qt.AlignRight
                    Material.foreground: "#fff"
                    icon.color: "#fff"
                    Material.background: Material.color(Material.Teal,Material.Shade700)
                    Layout.rightMargin: 10
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: "PointingHandCursor"
                        onClicked: _uploadPopup.open()
                    }
                }
            }
        }
    }
}
