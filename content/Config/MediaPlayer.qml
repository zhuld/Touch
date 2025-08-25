import QtQuick

QtObject {
    readonly property string logoName: qsTr("测试")
    readonly property string titleName: qsTr("媒体播放器控制")
    readonly property string version: qsTr("202507")
    readonly property string background: "qrc:/content/images/mediaplayer.jpg"
    readonly property int processDialogChannel: 1
    readonly property string protocol: "CrestronCIP"

    //页面List
    readonly property var pageList: ListModel {
        ListElement {
            name: qsTr("视频")
            pageUrl: "qrc:/qt/qml/content/Pages/Mediaplayer/Movie.qml"
            iconUrl: "qrc:/content/icons/shipin.png"
            test: false
            pageChannel: 11
            disableChannel: 0
        }
        ListElement {
            name: qsTr("背景音乐")
            pageUrl: "qrc:/qt/qml/content/Pages/Mediaplayer/Sound.qml"
            iconUrl: "qrc:/content/icons/music.png"
            test: false
            pageChannel: 12
        }
        ListElement {
            name: qsTr("PPT")
            pageUrl: "qrc:/qt/qml/content/Pages/Mediaplayer/PPT.qml"
            iconUrl: "qrc:/content/icons/ppt.png"
            test: false
            pageChannel: 13
        }
        ListElement {
            name: qsTr("Flash")
            pageUrl: "qrc:/qt/qml/content/Pages/Mediaplayer/Flash.qml"
            iconUrl: "qrc:/content/icons/Flash.png"
            test: false
            pageChannel: 14
        }
        ListElement {
            name: qsTr("图片")
            pageUrl: "qrc:/qt/qml/content/Pages/Mediaplayer/Picture.qml"
            iconUrl: "qrc:/content/icons/tupianji.png"
            test: false
            pageChannel: 15
        }
        ListElement {
            name: qsTr("摄像头")
            pageUrl: "qrc:/qt/qml/content/Pages/Mediaplayer/MedaiCamera.qml"
            iconUrl: "qrc:/content/icons/camera.png"
            test: false
            pageChannel: 16
        }
        ListElement {
            name: qsTr("网页")
            pageUrl: "qrc:/qt/qml/content/Pages/Mediaplayer/Web.qml"
            iconUrl: "qrc:/content/icons/web.png"
            test: false
            pageChannel: 17
        }
        ListElement {
            name: qsTr("系统")
            pageUrl: "qrc:/qt/qml/content/Pages/Mediaplayer/MediaSystem.qml"
            iconUrl: "qrc:/content/icons/xitong.png"
            test: false
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
    readonly property bool tabOnBottom: true
}
