import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import "qrc:/scripts/interface.js" as Interface


QtObject {
    id: _objects
    property string _category: ""
    property int _categoryBooks: 0
    function reloardCategories(category){
        _categoryBooks = (category.length % 2 === 0) ? (category.length / 2) : 2
    }
    readonly property ListModel _favoritesListModel: ListModel{

    }
    property list<Component> _homeViewDelegates: [
        Component{
            LandingPageBanners{}
        },
        Component{
            CourseGrid{
                id: _coursesArrivals
                nowShowing: "New Arrivals"
            }
        },
        Component{
            CourseGrid{
                id: _coursesPopular
                nowShowing: "Most Popular"
            }
        }
    ]
    readonly property list<Component> _favoritesViewsDelegates: [
        Component{
            Item{
                width: _root.width
                implicitHeight: _booksColumn.implicitHeight
                ColumnLayout{
                    id: _booksColumn
                    anchors.fill: parent
                    Rectangle{
                        Layout.fillWidth: true
                        Layout.preferredHeight: 400
                        color: "#fff"
                        visible: (_items._favoritesListModel.count === 0)
                        Text {
                            id: name
                            font: (_root.isLarge) ? Constants.fonts.h1 : Constants.fonts.h2
                            anchors.centerIn: parent
                            text: "Nothing Saved"
                            horizontalAlignment: Text.AlignHCenter
                            width: parent.width
                            wrapMode: Text.WordWrap
                        }
                    }
                    CourseGrid{
                        id: _courses
                        nowShowing: ""
                        _fetched: _items._favoritesListModel
                        Layout.fillWidth: true
                    }
                }
            }
        }
    ]
    property list<Component> _categoriesViewsDelegates: [
        Component{
            Label{
                id: _categoryLabel
                text: _category
                font: (_root.isLarge) ? Constants.fonts.h1 : Constants.fonts.h2
                Material.foreground: "#fff"
                horizontalAlignment: "AlignHCenter"
                wrapMode: "WordWrap"
                width: _root.width
            }
        },
        Component{
            Item{
                width: _root.width
                implicitHeight: _booksColumn.implicitHeight
                ColumnLayout{
                    id: _booksColumn
                    anchors.fill: parent
                    Repeater{
                        model: _categoryBooks
                        delegate: CourseGrid{
                            id: _courses
                            nowShowing: "Course #" + index
                            Layout.fillWidth: true
                        }
                    }
                }
            }
        }
    ]
}
