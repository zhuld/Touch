import QtQuick

Item {
    readonly property string logoName: "XX医院"
    readonly property string titleName: "门诊大楼指挥中心"
    readonly property string version: "202411"
    readonly property string background: "qrc:/content/images/shiyi.jpg"
    readonly property string logoImage: "qrc:/content/images/shiyilogo.png"
    readonly property int processDialogChannel: 1

    //页面List
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
        ListElement {
            name: qsTr("测试")
            pageUrl: "qrc:/qt/qml/content/Pages/Test.qml"
            iconUrl: "qrc:/content/icons/test.png"
        }
    }

    //系统
    readonly property string systemPowerName: "会议模式"
    readonly property var systemPowerList: ListModel {
        ListElement {
            name: "大屏会议"
            btnchannel: 2
            disBtnChannel: 0
            sizeRatio: 1
            bColor: "forestgreen"
            iconUrl: "qrc:/content/icons/pingmugongxiang.png"
            showDialog: true
        }
        ListElement {
            name: "普通会议"
            btnchannel: 3
            disBtnChannel: 0
            sizeRatio: 1
            bColor: "forestgreen"
            iconUrl: "qrc:/content/icons/huiyizanzhuyantao.png"
            showDialog: true
        }
        ListElement {
            name: "会议结束"
            btnchannel: 4
            disBtnChannel: 0
            sizeRatio: 1
            bColor: "tomato"
            iconUrl: "qrc:/content/icons/guanji.png"
            showDialog: true
        }
    }

    readonly property string systemSignalName: "信号选择"
    readonly property var systemSignalList: ListModel {
        id: buttonModel
        ListElement {
            name: qsTr("院内视频会议")
            btnchannel: 11
            iconUrl: "qrc:/content/icons/shipinhuiyi.png"
        }
        ListElement {
            name: qsTr("远程视频会议")
            btnchannel: 12
            iconUrl: "qrc:/content/icons/shipinhuiyi.png"
        }
        ListElement {
            name: qsTr("内网电脑")
            btnchannel: 13
            iconUrl: "qrc:/content/icons/zhuji.png"
        }
        ListElement {
            name: qsTr("无线投屏")
            btnchannel: 14
            iconUrl: "qrc:/content/icons/wuxiantouping.png"
        }
    }
    // 系统页，总音量调节
    readonly property string systemVolumeName: "总音量"
    readonly property int systemVolumeChannel: 9
    readonly property int systemVolumeMuteChannel: 55
    readonly property int systemVolumeMiniVolume: -40
    readonly property int systemVolumeMaxVolume: 5
    readonly property bool systemVolumeInput: false

    //视频切换页 输出
    readonly property string videoOutputName: "输出"
    readonly property var videoOutputList: ListModel {
        ListElement {
            name: qsTr("大屏")
            outputChannel: 1
        }
        ListElement {
            name: qsTr("院内会议辅流")
            outputChannel: 2
            disable: "3"
        }
        ListElement {
            name: qsTr("远程会议辅流")
            outputChannel: 3
            disable: "1"
        }
        ListElement {
            name: qsTr("预留输出")
            outputChannel: 4
        }
    }

    //视频切换页 输出
    readonly property string videoInputName: "输入信号"
    readonly property var videoInputList: ListModel {
        ListElement {
            name: qsTr("外网电脑")
            inputChannel: 1
            bgColor: "deepskyblue"
            source: "qrc:/content/icons/zhuji.png"
        }
        ListElement {
            name: qsTr("内网电脑")
            inputChannel: 2
            bgColor: "darkorange"
            source: "qrc:/content/icons/zhuji.png"
        }
        ListElement {
            name: qsTr("视频会议")
            inputChannel: 3
            bgColor: "forestgreen"
            source: "qrc:/content/icons/shipinhuiyi.png"
        }
        ListElement {
            name: qsTr("无线投屏")
            inputChannel: 4
            bgColor: "violet"
            source: "qrc:/content/icons/wuxiantouping.png"
        }
        ListElement {
            name: qsTr("摄像机")
            inputChannel: 5
            bgColor: "orangered"
            source: "qrc:/content/icons/shexiangji.png"
        }
        ListElement {
            name: qsTr("预留输入1")
            inputChannel: 6
            bgColor: "dimgray"
            source: "qrc:/content/icons/HDMIjiekou.png"
        }
        ListElement {
            name: qsTr("预留输入2")
            inputChannel: 7
            bgColor: "khaki"
            source: "qrc:/content/icons/HDMIjiekou.png"
        }
        ListElement {
            name: qsTr("预留输入3")
            inputChannel: 8
            bgColor: "royalblue"
            source: "qrc:/content/icons/HDMIjiekou.png"
        }
    }

    // 摄像机页，dpad
    readonly property string cameraPadName: "摄像机控制"
    readonly property int cameraPadChannel: 20
    readonly property string cameraAutoName: "摄像机控制"
    readonly property int cameraAutoChannel: 40
    readonly property var cameraAutoList: ListModel {
        ListElement {
            cameraRotation: 135
            btnchannel: 39
            label: "9"
            used: true
        }
        ListElement {
            used: false
        }
        ListElement {
            cameraRotation: 45
            btnchannel: 38
            label: "8"
            used: true
        }
        ListElement {
            cameraRotation: 120
            btnchannel: 37
            label: "7"
            used: true
        }
        ListElement {
            used: false
        }
        ListElement {
            cameraRotation: 60
            btnchannel: 36
            label: "6"
            used: true
        }
        ListElement {
            cameraRotation: 111
            btnchannel: 35
            label: "5"
            used: true
        }
        ListElement {
            used: false
        }
        ListElement {
            cameraRotation: 69
            btnchannel: 34
            label: "4"
            used: true
        }
        ListElement {
            cameraRotation: 105
            btnchannel: 33
            label: "3"
            used: true
        }
        ListElement {
            used: false
        }
        ListElement {
            cameraRotation: 75
            btnchannel: 32
            label: "2"
            used: true
        }
        ListElement {
            used: false
        }
        ListElement {
            cameraRotation: 90
            btnchannel: 31
            label: "1"
            used: true
        }
    }

    // 音量页
    readonly property var volumeList: ListModel {
        ListElement {
            name: "鹅颈话筒"
            vChannel: 5
            mChannel: 51
            miniVol: -40
            maxVol: 0
            inputType: true
        }
        ListElement {
            name: "手持话筒"
            vChannel: 6
            mChannel: 52
            miniVol: -40
            maxVol: 0
            inputType: true
        }
        ListElement {
            name: "电脑音频"
            vChannel: 7
            mChannel: 53
            miniVol: -40
            maxVol: 5
            inputType: true
        }

        ListElement {
            name: "外接音频"
            vChannel: 8
            mChannel: 54
            miniVol: -40
            maxVol: 5
            inputType: true
        }

        ListElement {
            name: "总音量"
            vChannel: 9
            mChannel: 55
            miniVol: -40
            maxVol: 5
            inputType: false
        }
    }

    //灯光页 灯光
    readonly property string lightName: "单独控制"
    readonly property string lightModeName: "灯光模式"
    readonly property var lightList: ListModel {
        ListElement {
            name: "左吸顶灯"
            btnChannel: 61
        }
        ListElement {
            name: "右吸顶灯"
            btnChannel: 62
        }
        ListElement {
            name: "前筒灯"
            btnChannel: 63
        }
        ListElement {
            name: "四周筒灯"
            btnChannel: 64
        }
        ListElement {
            name: "灯带"
            btnChannel: 65
        }
        ListElement {
            name: "其他"
            btnChannel: 66
        }
    }
    readonly property var lightModeList: ListModel {
        ListElement {
            name: qsTr("全开")
            btnchannel: 67
            iconUrl: "qrc:/content/icons/quankai.png"
        }
        ListElement {
            name: qsTr("全关")
            btnchannel: 68
            iconUrl: "qrc:/content/icons/quanguan.png"
        }
        ListElement {
            name: qsTr("会议")
            btnchannel: 69
            iconUrl: "qrc:/content/icons/huiyizanzhuyantao.png"
        }
        ListElement {
            name: qsTr("节电")
            btnchannel: 70
            iconUrl: "qrc:/content/icons/jieneng.png"
        }
    }
}
