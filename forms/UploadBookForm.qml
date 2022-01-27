import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import Constants 1.0
import "models"

Popup{
    id: _uploadForm
    Material.elevation: 4
    Binding{
        target: _uploadForm.background
        property: "radius"
        value: 10
    }

    contentItem: ColumnLayout{
        Label{
            id: _uploadText
            text: "Upload New Book"
            font: (_root.isLarge) ? Constants.fonts.h2 : Constants.fonts.h3
            Material.foreground:  Material.color(Material.Grey,Material.Shade100)
            Layout.alignment: Qt.AlignHCenter
        }
        Item{
            id: _uploadFormCont
            Layout.fillWidth: true
            Layout.preferredHeight: _uploadFormsGrid.implicitHeight
            GridLayout{
                id: _uploadFormsGrid
                anchors.fill: parent
                columns: 2
                rows: 5
                rowSpacing: 5
                Label{
                    id: _titleText
                    text: "Title: "
                    font: Constants.fonts.h4
                    Material.foreground:  Material.color(Material.Grey)
                }
                TextField{
                    id: _titleInput
                    font: Constants.fonts.h4
                    Material.foreground:  Material.color(Material.Grey,Material.Shade100)
                    Layout.fillWidth: true
                    placeholderText: "Enter book title"
                    Material.accent: Material.Teal
                }
                Label{
                    id: _authorText
                    text: "Author: "
                    font: Constants.fonts.h4
                    Material.foreground:  Material.color(Material.Grey)
                }
                TextField{
                    id: _authorInput
                    font: Constants.fonts.h4
                    Material.foreground:  Material.color(Material.Grey,Material.Shade100)
                    Layout.fillWidth: true
                    placeholderText: "Enter Book Author"
                    Material.accent: Material.Teal
                }
                Label{
                    id: _categoriesText
                    text: "Category: "
                    font: Constants.fonts.h4
                    Material.foreground:  Material.color(Material.Grey)
                }
                ComboBox{
                    id: _categoriesBox
                    Layout.fillWidth: true
                    font: Constants.fonts.h4
                    Material.foreground:  Material.color(Material.Grey,Material.Shade100)
                    Material.accent: Material.Teal
                    displayText: currentValue
                    textRole: "key"
                    model: CategoriesModel{
                        id: _categoriesListModel
                    }
                    delegate: ItemDelegate{
                        width: parent.width
                        text: key
                        font: _categoriesBox.font
                        Material.accent: Material.color(Material.Teal)
                        Material.foreground: (_categoriesBox.currentIndex === index) ? Material.color(Material.Teal) : Material.color(Material.Grey,Material.Shade100)
                        onClicked: {
                            _categoriesBox.currentIndex = index
                        }
                    }
                }
                Label{
                    id: _subjectsText
                    text: "Subject: "
                    font: Constants.fonts.h4
                    Material.foreground:  Material.color(Material.Grey)
                }
                ComboBox{
                    id: _subjectsBox
                    Layout.fillWidth: true
                    font: Constants.fonts.h4
                    Material.foreground:  Material.color(Material.Grey,Material.Shade100)
                    Material.accent: Material.Teal
                    displayText: currentValue
                    textRole: "subject"
                    model: SubjectsListModel{
                        id: _subjectsListMoldel
                    }
                    delegate: ItemDelegate{
                        width: parent.width
                        text: subject
                        font: _subjectsBox.font
                        Material.accent: Material.color(Material.Teal)
                        Material.foreground: (_subjectsBox.currentIndex === index) ? Material.color(Material.Teal) : Material.color(Material.Grey,Material.Shade100)
                        onClicked: {
                            _subjectsBox.currentIndex = index
                        }
                    }
                }
            }
        }
        Item{
            id: _uploadImgCont
            Layout.fillHeight: true
            Layout.fillWidth: true
            Component{
                id: _noFilesSelected
                ColumnLayout{
                    id: _uploadFileCol
                    Image {
                        id: _uploadPosterIcon
                        source: Constants.icons.upload
                        fillMode: Image.PreserveAspectCrop
                        Layout.alignment: Qt.AlignHCenter
                        ColorOverlay{
                            anchors.fill: _uploadPosterIcon
                            source: _uploadPosterIcon
                            color: "#fff"
                            transform: rotation
                        }
                    }
                    Rectangle{
                        id: _posterImageCont
                        Layout.fillWidth: true
                        Layout.preferredHeight: _posterImgRow.implicitHeight
                        color: "transparent"
                        border.width: 1
                        border.color: Material.color(Material.Grey,Material.Shade100)
                        RowLayout{
                            id: _posterImgRow
                            anchors.fill: parent
                            Label{
                                id: _posterLabel
                                text: "Select Book Poster"
                                font: Constants.fonts.h4
                                Material.foreground:  Material.color(Material.Grey)
                                Layout.fillWidth: true
                                padding: 20
                            }
                            Button{
                                id: _uploadImgBtn
                                text: "Browse"
                                font: Constants.fonts.h4
                                Layout.alignment: Qt.AlignRight
                                Material.foreground: "#fff"
                                Material.background: Material.color(Material.Teal,Material.Shade700)
                                Layout.rightMargin: 10
                                MouseArea{
                                    anchors.fill: parent
                                    cursorShape: "PointingHandCursor"
                                }
                            }
                        }
                    }
                    Rectangle{
                        id: _bookUploadCont
                        Layout.fillWidth: true
                        Layout.preferredHeight: _posterImgRow.implicitHeight
                        color: "transparent"
                        border.width: 1
                        border.color: Material.color(Material.Grey,Material.Shade100)
                        RowLayout{
                            id: _bookImgRow
                            anchors.fill: parent
                            Label{
                                id: _bookLabel
                                text: "Select File"
                                font: Constants.fonts.h4
                                Material.foreground:  Material.color(Material.Grey)
                                Layout.fillWidth: true
                                padding: 20
                            }
                            Button{
                                id: _uploadBookBtn
                                text: "Browse"
                                font: Constants.fonts.h4
                                Layout.alignment: Qt.AlignRight
                                Material.foreground: "#fff"
                                Material.background: Material.color(Material.Teal,Material.Shade700)
                                Layout.rightMargin: 10
                                MouseArea{
                                    anchors.fill: parent
                                    cursorShape: "PointingHandCursor"
                                }
                            }
                        }
                    }
                }
            }
            Loader{
                id: _uploadLoader
                visible: true
                active: visible
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                sourceComponent: _noFilesSelected
            }
        }
        Item {
            id: _uploadActionsCont
            Layout.preferredHeight: _uploadRow.implicitHeight
            Layout.fillWidth: true
            RowLayout{
                id: _uploadRow
                anchors.fill: parent
                ToolButton{
                    id: _cancelBtn
                    text: "Preview"
                    font: Constants.fonts.h4
                    Material.foreground:  Material.color(Material.Grey,Material.Shade100)
                    Layout.fillWidth: true
                    padding: 10
                    background: Rectangle{
                        color: "transparent"
                        border.width: 2
                        border.color: Material.color(Material.Teal,Material.Shade700)
                    }
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: "PointingHandCursor"
                    }
                }
                ToolButton{
                    id: _submitBtn
                    text: "Submit"
                    font: Constants.fonts.h4
                    Material.foreground: Material.color(Material.Grey,Material.Shade100)
                    Layout.fillWidth: true
                    padding: 10
                    background: Rectangle{
                        color: Material.color(Material.Teal,Material.Shade700)
                        border.width: 0
                    }
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: "PointingHandCursor"
                    }
                }
            }
        }
    }
}
