import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import Constants 1.0
import "models"
import "qrc:/scripts/interface.js" as Interface

RowLayout {
    id: _loginRow
    width: parent.width
    anchors.fill: parent
    Connections{
        target: _requests
        function onSignUpSuccessful(){
            console.log("Sign up successful")
            Interface.setState(_appLoader,"Home")
        }
        function onSignInSuccessful(){
            console.log("Sign up successful")
            Interface.setState(_appLoader,"Home")
        }
    }

    Item{
        Layout.fillWidth: true
        Layout.fillHeight: true
        Flickable{
            width: parent.width
            height: parent.height
            anchors.fill: parent
            contentHeight: _col.implicitHeight + _phoneNavFooter.implicitHeight
            ColumnLayout{
                id: _col
                spacing: 20
                anchors.fill: parent
                Label{
                    id: _logoCont
                    text: "Logo"
                    font: Constants.fonts.logo
                    Layout.alignment: Qt.AlignLeft
                    Material.foreground: "#000"
                    padding: 10
                }
                Label{
                    id: _signInLabel
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras tincidunt orci eget turpis"
                    font: Constants.fonts.h3
                    Material.foreground: Material.color(Material.Grey,Material.Shade100)
                    Layout.fillWidth: true
                    wrapMode: "WordWrap"
                    padding: 10
                }
                Label{
                    id: _welcomeLabel
                    text: "Welcome back! Please login to your account."
                    font: Constants.fonts.h4
                    Layout.fillWidth: true
                    Material.foreground: Material.color(Material.Grey)
                    wrapMode: "WordWrap"
                    padding: 10
                }
                Item{
                    Layout.fillWidth: true
                    implicitHeight: _inputCol.implicitHeight
                    ColumnLayout{
                        id: _inputCol
                        anchors.fill: parent
                        spacing: 0
                        TextField{
                            id: _usernameInput
                            font: Constants.fonts.h4
                            Material.foreground: Material.color(Material.Grey,Material.Shade100)
                            placeholderText: "Enter Username"
                            Layout.fillWidth: true
                            Layout.margins: 10
                            Material.accent: Material.color(Material.Teal)
                            leftPadding: (text.length === 0) ? 32 : 0
                            Image{
                                id: personImg
                                visible: (_usernameInput.text.length === 0)
                                source: Constants.icons.person
                                fillMode: Image.PreserveAspectFit
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                ColorOverlay{
                                    anchors.fill: personImg
                                    source :personImg
                                    color:"#fff"
                                    transform:rotation
                                }
                            }
                            Image{
                                id: closeImg
                                source: Constants.icons.close
                                visible: (_usernameInput.text.length > 0)
                                fillMode: Image.PreserveAspectFit
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                ColorOverlay{
                                    anchors.fill: closeImg
                                    source: closeImg
                                    color: "#fff"
                                    transform: rotation
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: _usernameInput.text = ""
                                }
                            }
                        }
                        TextField{
                            id: _passwordInput
                            font: Constants.fonts.h4
                            placeholderText: "Password"
                            Layout.fillWidth: true
                            Layout.margins: 10
                            echoMode: (!visibilityImg.isVisible) ? "Password" : "Normal"
                            Material.foreground: Material.color(Material.Grey,Material.Shade100)
                            Material.accent: Material.color(Material.Teal)
                            leftPadding: (text.length === 0) ? 32 : 0
                            rightPadding: 32
                            Image{
                                id: lockImg
                                visible: (_passwordInput.text.length === 0)
                                source: Constants.icons.lock
                                fillMode: Image.PreserveAspectFit
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                ColorOverlay{
                                    anchors.fill: lockImg
                                    source :lockImg
                                    color:"#fff"
                                    transform:rotation
                                }
                            }
                            Image{
                                id: visibilityImg
                                property bool isVisible: false
                                source: (!isVisible) ? Constants.icons.visibilityOff : Constants.icons.visibility
                                fillMode: Image.PreserveAspectFit
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                ColorOverlay{
                                    anchors.fill: visibilityImg
                                    source: visibilityImg
                                    color: "#fff"
                                    transform: rotation
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: visibilityImg.isVisible = !visibilityImg.isVisible
                                }
                            }
                        }
                        Item{
                            Layout.fillWidth: true
                            implicitHeight: _rememberMeCol.implicitHeight
                            RowLayout{
                                id: _rememberMeCol
                                anchors.fill: parent
                                CheckBox{
                                    text: "Remember Me"
                                    font: Constants.fonts.p
                                    Material.foreground:  Material.color(Material.Grey,Material.Shade100)
                                    Material.accent: Material.color(Material.Teal,Material.Shade700)
                                    Layout.alignment: Qt.AlignLeft
                                }
                                Label{
                                    id: _fogotPasswordLabel
                                    text: "Forgot Password"
                                    font: Constants.fonts.p
                                    Material.foreground:  Material.color(Material.Grey,Material.Shade100)
                                    Layout.alignment: Qt.AlignRight
                                }
                            }
                        }
                    }
                }
                Item{
                    id: _phoneNavFooter
                    Layout.fillWidth: true
                    implicitHeight: 100
                    Layout.alignment: Qt.AlignBottom
                    RowLayout{
                        id: _phoneNavooterRow
                        anchors.fill: parent
                        anchors.margins: 10
                        ToolButton{
                            id: _loginBtn
                            text: "Log in"
                            font: Constants.fonts.h3
                            Material.foreground:  Material.color(Material.Grey,Material.Shade100)
                            padding: 18
                            Layout.fillWidth: true
                            background: Rectangle{
                                color: "transparent"
                                border.width: 2
                                border.color: Material.color(Material.Teal,Material.Shade700)
                            }
                            MouseArea{
                                anchors.fill: parent
                                cursorShape: "PointingHandCursor"
                                onClicked: _requests.signInWithEmailPassword(_usernameInput.text,_passwordInput.text)
                            }
                        }
                        ToolButton{
                            id: _getStartedBtn
                            text: "Sign Up"
                            font: Constants.fonts.h3
                            Material.foreground: Material.color(Material.Grey,Material.Shade100)
                            padding: 18
                            Layout.fillWidth: true
                            background: Rectangle{
                                color: Material.color(Material.Teal,Material.Shade700)
                                border.width: 0
                            }
                            MouseArea{
                                anchors.fill: parent
                                cursorShape: "PointingHandCursor"
                                onClicked: _requests.signUpWithEmailPassword(_usernameInput.text,_passwordInput.text)
                            }
                        }
                    }
                }
                Flow{
                    Layout.fillWidth: true
                    spacing: 40
                    Layout.margins: 10
                    Label{
                        text: "Or Continue With"
                        font: Constants.fonts.p
                        Material.foreground:  Material.color(Material.Grey,Material.Shade100)
                        Layout.alignment: Qt.AlignRight
                    }
                    Label{
                        text: "Facebook"
                        font: Constants.fonts.p
                        Material.foreground:  Material.color(Material.LightBlue)
                        Layout.alignment: Qt.AlignRight
                    }
                    Label{
                        text: "Google"
                        font: Constants.fonts.p
                        Material.foreground:  Material.color(Material.LightBlue)
                        Layout.alignment: Qt.AlignRight
                    }
                }
            }
        }
    }
    ToolSeparator{
        Layout.fillHeight: true
    }
    Item{
        id: _loginSplash
        Layout.fillWidth: true
        Layout.fillHeight: true
        visible: (_root.isLarge)
        ColumnLayout{
            anchors.fill: parent
            spacing: 80
            TabBar{
                id: _navItemsTab
                Layout.fillWidth: true
                Material.accent: Material.color(Material.Teal)
                background: Rectangle{
                    color: "transparent"
                }
                Layout.alignment: Qt.AlignTop
                Repeater{
                    model: NavBarListModel{
                        id: _navBarListModel
                    }
                    delegate: TabButton{
                        id: _navItem
                        text: modelData
                        Material.foreground:  Material.color(Material.Grey,Material.Shade100)
                        Material.accent: Material.color(Material.Teal)
                        font: Constants.fonts.h4
                        padding: 20
                    }
                }
            }
            Item{
                Layout.fillHeight: true
                Layout.fillWidth: true
                Image {
                    id: _loginImg
                    source: "qrc:/images/Section Image 2.png"
                    fillMode: Image.PreserveAspectFit
                    asynchronous: true
                    anchors{
                        top: parent.top
                        left: parent.left
                        right: parent.right
                    }
                }
            }
        }
    }
}
