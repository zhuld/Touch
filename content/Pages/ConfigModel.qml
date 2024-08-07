import QtQuick
Item{
    readonly property string logoName: "上海市第一人民医院门诊楼指挥中心"
    readonly property string titleName: "集中控制系统"
    readonly property string version: "202406"
    readonly property string background: "qrc:/qt/qml/content/images/shiyi.jpg"

    readonly property var pageList: ListModel {
        ListElement { name: qsTr("系统");  pageUrl:"qrc:/qt/qml/content/Pages/System.ui.qml" ; iconUrl:"qrc:/qt/qml/content/icons/xitong.png"}
        ListElement { name: qsTr("视频");  pageUrl:"qrc:/qt/qml/content/Pages/Video.ui.qml";iconUrl:"qrc:/qt/qml/content/icons/shipin.png"}
        ListElement { name: qsTr("摄像机");  pageUrl:"qrc:/qt/qml/content/Pages/Camera.ui.qml";iconUrl:"qrc:/qt/qml/content/icons/shexiangtou.png"}
        ListElement { name: qsTr("音量");  pageUrl:"qrc:/qt/qml/content/Pages/Volume.ui.qml";iconUrl:"qrc:/qt/qml/content/icons/music.png"}
        ListElement { name: qsTr("灯光");  pageUrl:"qrc:/qt/qml/content/Pages/Light.ui.qml";iconUrl:"qrc:/qt/qml/content/icons/deng.png"}
    }
}
