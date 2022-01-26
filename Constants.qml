pragma Singleton
import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Window 2.15


QtObject {
    readonly property int width: Screen.width
    readonly property int height: Screen.height - 1

    //all fonts
    readonly property FontLoader primaryFont: FontLoader { source: "qrc:/fonts/Lora-VariableFont_wght.ttf" }
    readonly property FontLoader secondaryFont: FontLoader { source: "qrc:/fonts/Lora-Italic-VariableFont_wght.ttf" }

    property alias fontDirectory: directoryFontLoader.fontDirectory
    property alias relativeFontDirectory: directoryFontLoader.relativeFontDirectory

    /* Edit this comment to add your custom font */
    readonly property QtObject fonts: QtObject{
        readonly property font logo: Qt.font({
                                              family: secondaryFont.name,
                                              pixelSize: 48,
                                              letterSpacing: 8,
                                                 bold: true,
                                                 capitalization: Font.AllUppercase
                                          })
        readonly property font h1: Qt.font({
                                              family: secondaryFont.name,
                                              pixelSize: 64,
                                              letterSpacing: 2,
                                          })
        readonly property font h2: Qt.font({
                                              family: secondaryFont.name,
                                              pixelSize: 48,
                                              letterSpacing: 2,
                                          })
        readonly property font h3: Qt.font({
                                              family: primaryFont.name,
                                              pixelSize: 32,
                                              letterSpacing: 2,
                                          })
        readonly property font h4: Qt.font({
                                              family: primaryFont.name,
                                              pixelSize: 16,
                                              letterSpacing: 2
                                          })
        readonly property font p: Qt.font({
                                              family: primaryFont.name,
                                              pixelSize: Qt.application.font.pixelSize,
                                              letterSpacing: 2,
                                          })        
    }


    //paths to all svg icons from https://fonts.google.com/icons
    readonly property QtObject icons: QtObject{
        //google Icons 24dp
        readonly property url menu: "qrc:/icons/menu_black_36dp.svg"
        readonly property url copyRight: "qrc:/icons/copyright_black_36dp.svg"
        readonly property url upload: "qrc:/icons/file_upload_black_36dp.svg"
        readonly property url chevronRight: "qrc:/icons/chevron_right_black_48dp.svg"
        readonly property url chevronLeft: "qrc:/icons/chevron_left_black_48dp.svg"
    }

    readonly property QtObject images: QtObject{
        readonly property url logo: "qrc:/resources/images/Logo.png"
        readonly property url heroImg: "qrc:/resources/images/Hero image.png"
        readonly property url binatorLogo: "qrc:/resources/images/binator logo.svg"
        readonly property url buyMeLogo: "qrc:/resources/images/buyme logo.svg"
        readonly property url loremLogo: "qrc:/resources/images/loogipsum logo.svg"
        readonly property url squareLogo: "qrc:/resources/images/square logo.svg"
        readonly property url umbrellaLogo: "qrc:/resources/images/umbrella logo.svg"
        readonly property url sectionImg: "qrc:/resources/images/Section Image.png"
        readonly property url sectionImg2: "qrc:/resources/images/Section Image 2.png"
        readonly property url sectionImg3: "qrc:/resources/images/Section Image 3.png"
        readonly property url blogImg1: "qrc:/resources/images/good-faces-DSj40n6beGk-unsplash.jpg"
        readonly property url blogImg2: "qrc:/resources/images/lagos-techie-IgUR1iX0mqM-unsplash.jpg"
        readonly property url blogImg3: "qrc:/resources/images/felipe-gregate-Ph2KD5qr7VQ-unsplash.jpg"
        readonly property url socialMediaIcon1: "qrc:/resources/images/Social media icon.png"
        readonly property url socialMediaIcon2: "qrc:/resources/images/Social media icon (1).png"
        readonly property url socialMediaIcon3: "qrc:/resources/images/Social media icon (2).png"
        readonly property url registrationImg: "qrc:/resources/images/clip-message-sent 1.png"
    }

    property DirectoryFontFolder directoryFontLoader: DirectoryFontFolder {
        id: directoryFontLoader
    }
}
