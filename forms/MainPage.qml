import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import Constants 1.0
import "models"
import "qrc:/scripts/interface.js" as Interface

Page{
    id: _homePage
    readonly property alias _appScroll: _appScroll2
    anchors.fill: parent
    property int _currentIndex: 0
    on_CurrentIndexChanged: Interface.changeListViewState(_currentIndex,_mainPage2)
    contentItem: ScrollView {
        id: _appScroll2
        anchors.fill: parent
        clip: true
        contentWidth: availableWidth
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        contentItem: ViewsList{
            id: _mainPage2
            model: _items._homeViewDelegates
            Connections{
                target: _mainPage2
                function onCategoriesChanged(category){
                    if (category !== _items._category){
                        _items._category = category
                        _items.reloardCategories(category)
                    }
                }
            }
            UploadBookForm{
                id: _uploadPopup
                width: (_root.isLarge) ? 500 : 350
                height: 600
                anchors.centerIn: parent
            }

            PhoneNavDrawer{
                id: _phoneDrawer
                edge: "LeftEdge"
                y: 100
                width: _mainPage2.width * 0.66
                height: _mainPage2.height - 70
                visible: (!_root.isLarge)
            }
            header: NavBar{
                id: _navBar2
            }
        }
    }
}
