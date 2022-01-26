import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import Constants 1.0

Page {
    id: _loginPage
    width: _root.width
    height: _root.height
    implicitWidth: width
    implicitHeight: height
    Component{
        id: _loginDesktopForm
        LoginForm{}
    }
    contentItem: Loader{
        anchors.fill: parent
        visible: true
        active: visible
        sourceComponent: _loginDesktopForm
    }
}
