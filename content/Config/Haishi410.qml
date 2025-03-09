import QtQuick

QtObject {
    readonly property string logoName: qsTr("海事大学")
    readonly property string titleName: qsTr("410沉浸式教室")
    readonly property string version: qsTr("202411")
    readonly property string background: "qrc:/content/images/haishi.jpg"
    readonly property string logoImage: "qrc:/content/images/shiyilogo.png"
    readonly property int processDialogChannel: 1

    //页面List
    readonly property var pageList: ListModel {
        ListElement {
            name: qsTr("远程")
            pageUrl: "qrc:/qt/qml/content/Pages/Haishi/Remote.qml"
            iconUrl: "qrc:/content/icons/shipinhuiyi.png"
            test: false
            pageChannel: 16
        }
        ListElement {
            name: qsTr("单画面")
            pageUrl: "qrc:/qt/qml/content/Pages/Haishi/SingleScreen.qml"
            iconUrl: "qrc:/content/icons/danhuamian.png"
            test: false
            pageChannel: 12
        }
        ListElement {
            name: qsTr("VR")
            pageUrl: "qrc:/qt/qml/content/Pages/Haishi/VR.qml"
            iconUrl: "qrc:/content/icons/vr.png"
            test: false
            pageChannel: 13
        }
        ListElement {
            name: qsTr("LED屏")
            pageUrl: "qrc:/qt/qml/content/Pages/Haishi/LED.qml"
            iconUrl: "qrc:/content/icons/led.png"
            test: false
            pageChannel: 14
        }
        ListElement {
            name: qsTr("摄像机")
            pageUrl: "qrc:/qt/qml/content/Pages/Haishi/Camera.qml"
            iconUrl: "qrc:/content/icons/camera.png"
            test: false
            pageChannel: 15
        }
        // ListElement {
        //     name: qsTr("数据")
        //     pageUrl: "qrc:/qt/qml/content/Pages/DataList.qml"
        //     iconUrl: "qrc:/content/icons/table.png"
        //     test: true
        //     pageChannel: 17
        // }
        ListElement {
            name: qsTr("测试")
            pageUrl: "qrc:/qt/qml/content/Pages/Test.qml"
            iconUrl: "qrc:/content/icons/test.png"
            test: true
            pageChannel: 18
        }
    }
    readonly property var initValue: ListModel {
        ListElement {
            name: "analog"
            channel: 1
            value: 19661
        }
    }
    readonly property bool tabOnBottom: false
}
