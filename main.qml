import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import Constants 1.0
import "qrc:/scripts/interface.js" as Interface


//MAIN WINDOW
ApplicationWindow{
    id: _root
    width: Constants.width
    height: Constants.height
    minimumWidth: 380
    minimumHeight: 500
    visible: true
    title: qsTr("Online Book-Store")
    readonly property bool isSmall: (_root.width < 640)
    readonly property bool isMedium: (_root.width >= 640 && _root.width <= 1007)
    readonly property bool isLarge: (_root.width >= 1007)
    ItemObjects{
        id: _items
    }
    Loader{
        id: _appLoader
        visible: true
        active: visible
        anchors.fill: parent
        source: "LoginPage.qml"
        state: "Auth"
        states: [
            State {
                name: "Auth"
                PropertyChanges {
                    target: _appLoader
                    source: "qrc:/LoginPage.qml"
                }
            },
            State {
                name: "Home"
                PropertyChanges {
                    target: _appLoader
                    source: "qrc:/MainPage.qml"
                }
            }
        ]
    }
}



//ApplicationWindow {
//    id: _root
//    width: Constants.width
//    height: Constants.height
//    minimumWidth: 380
//    minimumHeight: 500
//    visible: true
//    title: qsTr("Online Book-Store")
//    readonly property bool isSmall: (_root.width < 640)
//    readonly property bool isMedium: (_root.width >= 640 && _root.width <= 1007)
//    readonly property bool isLarge: (_root.width >= 1007)
//    property int _currentIndex: 0
//    on_CurrentIndexChanged: Interface.changeListViewState(_currentIndex,_mainPage2)
//    ItemObjects{
//        id: _items
//    }
//    Component{
//        id: _compo
//        Rectangle{
//            anchors.fill: _root
//        }
//    }

//    Page{
//        id: _homePage
//        anchors.fill: parent
//        contentItem: ScrollView {
//            id: _appScroll
//            anchors.fill: parent
//            //anchors.margins: 20
//            clip: true
//            contentWidth: availableWidth
//            contentItem: HomePage{
//                id: _mainPage2
//                model: _items._homeViewDelegates
//                Connections{
//                    target: _mainPage2
//                    function onCategoriesChanged(category){
//                        if (category !== _items._category){
//                            _items._category = category
//                            _items.reloardCategories(category)
//                        }
//                    }
//                }
//                PhoneNavDrawer{
//                    id: _phoneDrawer
//                    edge: "LeftEdge"
//                    y: 100
//                    width: _mainPage2.width * 0.66
//                    height: _mainPage2.height - 70
//                    visible: (!_root.isLarge)
//                }
//                header: NavBar{
//                    id: _navBar2
//                    width: _appScroll.width
//                    height: 100
//                }
//            }
//        }
//    }
//}
