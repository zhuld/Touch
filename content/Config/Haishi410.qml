import QtQuick

Item {
    readonly property string logoName: qsTr("海事大学")
    readonly property string titleName: qsTr("沉浸式教室")
    readonly property string version: qsTr("202412")
    readonly property string background: "qrc:/content/images/haishi.jpg"
    readonly property string logoImage: "qrc:/content/images/shiyilogo.png"
    readonly property string cipServerIP: "192.168.1.10"
    readonly property int cipPort: 41794
    readonly property int ipId: 8
    readonly property int processDialogChannel: 1
    readonly property bool tabOnBottom: true

    property color buttonColor: settings.darkTheme ? "#16417C" : "skyblue"
    property color buttonCheckedColor: settings.darkTheme ? "darkorange" : "darkorange"
    property color catagoryColor: settings.darkTheme ? "#1A5A94" : "silver"
    property color backgroundColor: settings.darkTheme ? "midnightblue" : "lightblue"
    property color buttonTextColor: settings.darkTheme ? "floralwhite" : "#252525"
    property color textColor: settings.darkTheme ? "lightskyblue" : "#252525" //文字颜色
    property color buttonShadowColor: settings.darkTheme ? "#E0262626" : "#E0262626"

    property color buttonRedColor: settings.darkTheme ? "darkred" : "lightpink"
    property color buttonGreenColor: settings.darkTheme ? "darkgreen" : "lightgreen"
    property color buttonTextRedColor: "red"

    property color volumeBlueColor: settings.darkTheme ? "whitesmoke" : "#0B1A38"
    property color volumeRedColor: "red"
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
            name: qsTr("LED大屏")
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
        ListElement {
            name: qsTr("数据")
            pageUrl: "qrc:/qt/qml/content/Pages/DataList.qml"
            iconUrl: "qrc:/content/icons/table.png"
            test: true
            pageChannel: 17
        }
        ListElement {
            name: qsTr("测试")
            pageUrl: "qrc:/qt/qml/content/Pages/Test.qml"
            iconUrl: "qrc:/content/icons/test.png"
            test: true
            pageChannel: 18
        }
    }
}
