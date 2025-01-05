pragma Singleton

import QtQuick
import QtCore

QtObject {

    property var digital: []
    property var analog: []

    //property var text: [] // not support yet
    readonly property color buttonColor: settings.darkTheme ? "dodgerblue" : "skyblue"
    readonly property color buttonCheckedColor: "darkorange"
    readonly property color backgroundColor: settings.darkTheme ? "#16417C" : "lavender"
    readonly property color buttonTextColor: settings.darkTheme ? "lavender" : "#252525"
    readonly property color buttonShadowColor: settings.darkTheme ? "#E0262626" : "#E0262626"
    readonly property color buttonTextRedColor: "red"

    readonly property var lcdFont: FontLoader {
        source: "qrc:/content/fonts/TP-LCD.TTF"
    }
    readonly property var alibabaPuHuiTi: FontLoader {
        source: "qrc:/content/fonts/AlibabaPuHuiTi-3-55-Regular.ttf"
    }
    readonly property var sourceCodePro: FontLoader {
        source: "qrc:/content/fonts/SourceCodePro-Regular.ttf"
    }

    property var settings: Settings {
        property string ipAddress
        property int ipPort
        property int ipId
        property bool fullscreen: Qt.platform.os === "windows" ? false : true
        property string settingPassword: "123"
        property bool demoMode: false
        property bool showChannel: false
        property bool darkTheme: false
        property int windowWidth: 1200
        property int windowHeight: 800
        property bool tabOnBottom: false
    }
}
