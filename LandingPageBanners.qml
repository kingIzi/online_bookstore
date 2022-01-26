import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import Constants 1.0
import "models"

Item{
    id: _bannerRect
    //width: _appScroll.width
    width: _root.width
    height: (_root.isLarge) ? 559 : 449
    implicitHeight: height
    implicitWidth: width
    clip: true
    SwipeView{
        id: _bannerSwipe
        anchors.fill: parent
        Repeater{
            model: LandingPageListModel{}
            delegate: Item{
                id: _bannerItem
                Image{
                    id: _bannerImg
                    anchors.fill: parent
                    source: sourceUrl
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                }
                ColumnLayout{
                    id: _bannerCol
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 80
                    Label{
                        id: _bigText
                        text: bigText
                        font: (_root.isLarge) ? Constants.fonts.h1 : Constants.fonts.h2
                        horizontalAlignment: "AlignHCenter"
                        Material.foreground: "#fff"
                        Layout.fillWidth: true
                        wrapMode: "WordWrap"
                    }
                    Label{
                        id: _descText
                        text: descText
                        font: (_root.isLarge) ? Constants.fonts.h2 : Constants.fonts.h3
                        horizontalAlignment: "AlignHCenter"
                        Material.foreground: "#fff"
                        Layout.fillWidth: true
                        wrapMode: "WordWrap"
                    }
                }
            }
        }
    }
    RoundButton {
        id: _bannerLeftIcon
        icon.source: "qrc:/icons/chevron_left_black_48dp.svg"
        icon.color: "#fff"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        padding: 20
        visible: (_root.isLarge)
        enabled: ((_bannerSwipe.currentIndex > 0))
        onClicked:  {
            if (enabled){
                _bannerSwipe.currentIndex--
            }
        }
        anchors.leftMargin: 20
        Material.background: Material.color(Material.Teal,Material.Shade700)
    }
    RoundButton {
        id: _bannerRightIcon
        icon.source: "qrc:/icons/chevron_right_black_48dp.svg"
        icon.color: "#fff"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        padding: 20
        visible: (_root.isLarge)
        enabled: ((_bannerSwipe.currentIndex !== (_bannerSwipe.count - 1)))
        onClicked: {
            if (enabled){
                _bannerSwipe.currentIndex++
            }
        }
        Material.background: Material.color(Material.Teal,Material.Shade700)
        anchors.rightMargin: 20
    }
    PageIndicator {
        id: indicator
        count: _bannerSwipe.count
        currentIndex: _bannerSwipe.currentIndex
        anchors.bottom: _bannerSwipe.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        delegate: Rectangle{
            width: 40
            height: 10
            color: (_bannerSwipe.currentIndex === index) ? Material.color(Material.Grey,Material.Shade900) : Material.color(Material.Grey)
        }
    }
}
