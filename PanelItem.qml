import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import Constants 1.0


Item {
    default property var contentItem: null
    property string title: "panel"
    id: _panelRoot
    Layout.fillWidth: true
    height: 30
    Layout.fillHeight: current
    property bool current: false
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        Rectangle {
            id: bar
            Layout.fillWidth: true
            height: 30
            color:  _panelRoot.current ? "#81BEF7" : "#CEECF5"
            Label {
                anchors.fill: parent
                anchors.margins: 10
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                text: _panelRoot.title
                font: Constants.fonts.h4
            }
            Label {
                anchors{
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                    margins: 10
                }
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                text: "^"
                rotation: _panelRoot.current ? "180" : 0
                font: Constants.fonts.h3
            }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: _panelRoot.current = !_panelRoot.current;
            }
        }
        Rectangle {
            id: container
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignBottom
            implicitHeight: _panelRoot.height - bar.height
            clip: true
            Behavior on implicitHeight {
                PropertyAnimation { duration: 100 }
            }
        }
        Component.onCompleted: {
            if(_panelRoot.contentItem !== null)
                _panelRoot.contentItem.parent = container;
        }
    }
}
