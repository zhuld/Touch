import QtQuick

QtObject {
    readonly property string logoName: qsTr("上海市第一人民医院")
    readonly property string titleName: qsTr("门诊大楼指挥中心")
    readonly property string version: qsTr("202501")
    readonly property string background: "qrc:/content/images/shiyi.jpg"
    readonly property string logoImage: "qrc:/content/images/shiyilogo.png"
    readonly property int processDialogChannel: 1

    //页面List
    readonly property var pageList: ListModel {

        ListElement {
            name: qsTr("系统")
            pageUrl: "qrc:/qt/qml/content/Pages/Shiyi/System.qml"
            iconUrl: "qrc:/content/icons/home.png"
            test: false
            pageChannel: 11
        }
        ListElement {
            name: qsTr("视频")
            pageUrl: "qrc:/qt/qml/content/Pages/Shiyi/Video.qml"
            iconUrl: "qrc:/content/icons/shipin.png"
            test: false
            pageChannel: 12
        }
        ListElement {
            name: qsTr("摄像机")
            pageUrl: "qrc:/qt/qml/content/Pages/Shiyi/Camera.qml"
            iconUrl: "qrc:/content/icons/shexiangtou.png"
            test: false
            pageChannel: 13
        }
        ListElement {
            name: qsTr("音量")
            pageUrl: "qrc:/qt/qml/content/Pages/Shiyi/Volume.qml"
            iconUrl: "qrc:/content/icons/music.png"
            test: false
            pageChannel: 14
        }
        ListElement {
            name: qsTr("灯光")
            pageUrl: "qrc:/qt/qml/content/Pages/Shiyi/Light.qml"
            iconUrl: "qrc:/content/icons/deng.png"
            test: false
            pageChannel: 15
        }
        ListElement {
            name: qsTr("数据")
            pageUrl: "qrc:/qt/qml/content/Pages/DataList.qml"
            iconUrl: "qrc:/content/icons/table.png"
            test: true
            pageChannel: 16
        }
        ListElement {
            name: qsTr("测试")
            pageUrl: "qrc:/qt/qml/content/Pages/Test.qml"
            iconUrl: "qrc:/content/icons/test.png"
            test: true
            pageChannel: 17
        }
    }
}
