import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import Qt5Compat.GraphicalEffects
import QtQuick.Layouts 1.15
import Constants 1.0
import "models"
import "qrc:/scripts/interface.js" as Interface


Loader{
    id: _navBarLoader
    width: _appScroll.width
    height: 100
    z: 2
    visible: true
    active: visible
    source: (_root.isLarge) ? "qrc:/DeskTopNavBar.qml" : "qrc:/MobileNavBar.qml"
}
