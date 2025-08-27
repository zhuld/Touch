pragma Singleton

import QtQuick
import QtCore

QtObject {

    property list<bool> digital: []
    property list<bool> digitalToggle: []
    property list<int> analog: []

    //configList
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

    readonly property color buttonColor: settings.darkTheme ? "#0DC6DB" : "skyblue"
    readonly property color buttonCheckedColor: "darkorange"
    readonly property color backgroundColor: settings.darkTheme ? "#283953" : "lavender"
    readonly property color buttonTextColor: settings.darkTheme ? "lavender" : "#252525"
    readonly property color buttonShadowColor: settings.darkTheme ? "#C0262626" : "#C0262626"
    readonly property color buttonTextRedColor: "red"

    readonly property int durationDelay: 100

    readonly property real channelSize: 40
    readonly property real shadowHeight: 8

    readonly property FontLoader lcdFont: FontLoader {
        source: "qrc:/content/fonts/TP-LCD.TTF"
    }
    readonly property FontLoader alibabaPuHuiTi: FontLoader {
        source: "qrc:/content/fonts/AlibabaPuHuiTi-3-55-Regular.ttf"
    }
    readonly property FontLoader sourceCodePro: FontLoader {
        source: "qrc:/content/fonts/SourceCodePro-Regular.ttf"
    }

    property var settings: Settings {
        property int configSetting: 0
        property string ipAddress: "192.168.1.10"
        property int ipPort: 41794
        property int ipId: 3
        property bool fullscreen: Qt.platform.os === "windows" ? false : true
        property string settingPassword: "123"
        // property bool demoMode: false
        property bool showChannel: false
        property bool darkTheme: false
        property int windowWidth: 1600
        property int windowHeight: 1000
    }
}
