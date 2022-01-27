import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import Constants 1.0

ToolBar{
    id: _navBar
    Material.background: Material.color(Material.Grey,Material.Shade900)
    Material.elevation: 4
    z: 2
    contentItem: RowLayout{
        id: _mobileNavBar
        Label{
            id: _logoCont
            text: "Logo"
            font: Constants.fonts.logo
            Layout.alignment: Qt.AlignLeft
            Material.foreground: "#000"
            Layout.leftMargin: 10
        }
        RoundButton{
            id: _uploadBtn
            icon.source: Constants.icons.upload
            icon.color: "#fff"
            padding: 20
            Layout.alignment: Qt.AlignRight
            Material.background: Material.color(Material.Teal,Material.Shade700)
            onClicked: _uploadPopup.open()
        }
        RoundButton{
            id: _menutn
            icon.source: Constants.icons.menu
            icon.color: "#fff"
            padding: 20
            Layout.alignment: Qt.AlignRight
            Material.background: Material.color(Material.Teal,Material.Shade700)
            onClicked: _phoneDrawer.open()
            Layout.rightMargin: 10
        }
    }
}
