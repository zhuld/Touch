pragma Singleton

import QtQuick
import QtCore

QtObject {

    property var digital: []
    property var digitalToggle: []
    property var analog: []

    //config
    property QtObject config

    readonly property list<QtObject> configList: [
        ConfigSet {},
        ShiyiMZ {},
        Haishi410 {},
        MediaPlayer {}
    ]

    readonly property ListModel configListModel: ListModel {}

    Component.onCompleted: {
        for (var i = 0; i < configList.length; i++) {
            configListModel.append({
                                       "key": configList[i].logoName + "-" + configList[i].titleName
                                   })
        }
    }
    property ListModel tabList: ListModel {} //tab页面

    readonly property color buttonColor: settings.darkTheme ? "dodgerblue" : "skyblue"
    readonly property color buttonCheckedColor: "darkorange"
    readonly property color backgroundColor: settings.darkTheme ? "#16417C" : "lavender"
    readonly property color buttonTextColor: settings.darkTheme ? "lavender" : "#252525"
    readonly property color buttonShadowColor: settings.darkTheme ? "#E0262626" : "#E0262626"
    readonly property color buttonTextRedColor: "red"

    readonly property int durationDelay: 150

    readonly property real channelSize: 40
    readonly property real shadowHeight: 10

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
        property int configSetting: 0
        property string ipAddress: "192.168.1.10"
        property int ipPort: 41794
        property int ipId: 3
        property bool fullscreen: Qt.platform.os === "windows" ? false : true
        property string settingPassword: "123"
        property bool demoMode: false
        property bool showChannel: false
        property bool darkTheme: false
        property int windowWidth: 1600
        property int windowHeight: 1000
    }
}
