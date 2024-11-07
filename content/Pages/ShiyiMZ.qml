import QtQuick

Item {
    readonly property string logoName: "上海市第一人民医院"
    readonly property string titleName: "门诊大楼指挥中心"
    readonly property string version: "202411"
    readonly property string background: "qrc:/content/images/shiyi.jpg"
    readonly property string logoImage: "qrc:/content/images/shiyilogo.png"

    readonly property var pageList: ListModel {
        ListElement {
            name: qsTr("系统")
            pageUrl: "qrc:/qt/qml/content/Pages/System.qml"
            iconUrl: "qrc:/content/icons/home.png"
        }
        ListElement {
            name: qsTr("视频")
            pageUrl: "qrc:/qt/qml/content/Pages/Video.qml"
            iconUrl: "qrc:/content/icons/shipin.png"
        }
        ListElement {
            name: qsTr("摄像机")
            pageUrl: "qrc:/qt/qml/content/Pages/Camera.qml"
            iconUrl: "qrc:/content/icons/shexiangtou.png"
        }
        ListElement {
            name: qsTr("音量")
            pageUrl: "qrc:/qt/qml/content/Pages/Volume.qml"
            iconUrl: "qrc:/content/icons/music.png"
        }
        ListElement {
            name: qsTr("灯光")
            pageUrl: "qrc:/qt/qml/content/Pages/Light.qml"
            iconUrl: "qrc:/content/icons/deng.png"
        }
        ListElement {
            name: qsTr("数据")
            pageUrl: "qrc:/qt/qml/content/Pages/DataList.qml"
            iconUrl: "qrc:/content/icons/table.png"
        }
        // ListElement {
        //     name: qsTr("测试")
        //     pageUrl: "qrc:/qt/qml/content/Pages/Test.qml"
        //     iconUrl: "qrc:/content/icons/table.png"
        // }
    }
}
