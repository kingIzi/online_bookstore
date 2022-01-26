import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import Constants 1.0
import "qrc:/scripts/interface.js" as Interface


ListView {
    id: _homeFlick
    width: parent.width
    state: "Home"
    signal categoriesChanged(string categories)
    ScrollBar.vertical: vbar
    ScrollBar {
        id: vbar
        active: true
        orientation: Qt.Vertical
        size: _homeFlick.height / _homeFlick.contentHeight
        //position: _mainPage2.currentItem
        z: 5
        policy: ScrollBar.AlwaysOn
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
    states: [
        State {
            name: "Home"
            PropertyChanges {
                target: _homeFlick
                model: _items._homeViewDelegates
            }
        },
        State {
            name: "Favorites"
            PropertyChanges {
                target: _homeFlick
                model: _items._favoritesViewsDelegates
            }
        },
        State {
            name: "Categories"
            PropertyChanges {
                target: _homeFlick
                model: _items._categoriesViewsDelegates
            }
        }
    ]
    footer: Rectangle{
        width: parent.width
        implicitHeight: _copyRightRow.implicitHeight * 1.1
        color: Material.color(Material.Grey,Material.Shade900)
        RowLayout{
            id: _copyRightRow
            anchors.fill: parent
            anchors.leftMargin: 10
            Image{
                id: _copyrightImg
                source: Constants.icons.copyRight
                Layout.alignment: Qt.AlignVCenter
                fillMode: Image.PreserveAspectFit
                ColorOverlay{
                    anchors.fill: _copyrightImg
                    source: _copyrightImg
                    color: Material.color(Material.Grey)
                    transform: rotation
                    antialiasing: true
                }
            }
            Label{
                text: "All Rights Reserved. All book publications are school property. Copying and publishing books is prohibited."
                font: (_root.isLarge) ? Constants.fonts.h4 : Constants.fonts.p
                Layout.fillWidth: true
                wrapMode: "WordWrap"
                color: Material.color(Material.Grey)
                Layout.alignment: Qt.AlignVCenter
            }
        }
    }
    spacing: 40
    headerPositioning: ListView.PullBackHeader
    delegate: Loader{
        id: _viewsLoader
        sourceComponent: modelData
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 10
        anchors.rightMargin: 10
    }
}
