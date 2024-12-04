import QtQuick

Item {
    readonly property string logoName: qsTr("XX医院")
    readonly property string titleName: qsTr("门诊大楼指挥中心")
    readonly property string version: qsTr("202411")
    readonly property string background: "qrc:/content/images/shiyi.jpg"
    readonly property string logoImage: "qrc:/content/images/shiyilogo.png"
    readonly property string cipServerIP: "192.168.1.10"
    readonly property int cipPort: 41794
    readonly property int ipId: 8
    readonly property int processDialogChannel: 1

    //页面List
    readonly property var pageList: ListModel {
        ListElement {
            name: qsTr("系统")
            pageUrl: "qrc:/qt/qml/content/Pages/System.qml"
            iconUrl: "qrc:/content/icons/home.png"
            test: false
        }
        ListElement {
            name: qsTr("视频")
            pageUrl: "qrc:/qt/qml/content/Pages/Video.qml"
            iconUrl: "qrc:/content/icons/shipin.png"
            test: false
        }
        ListElement {
            name: qsTr("摄像机")
            pageUrl: "qrc:/qt/qml/content/Pages/Camera.qml"
            iconUrl: "qrc:/content/icons/shexiangtou.png"
            test: false
        }
        ListElement {
            name: qsTr("音量")
            pageUrl: "qrc:/qt/qml/content/Pages/Volume.qml"
            iconUrl: "qrc:/content/icons/music.png"
            test: false
        }
        ListElement {
            name: qsTr("灯光")
            pageUrl: "qrc:/qt/qml/content/Pages/Light.qml"
            iconUrl: "qrc:/content/icons/deng.png"
            test: false
        }
        ListElement {
            name: qsTr("数据")
            pageUrl: "qrc:/qt/qml/content/Pages/DataList.qml"
            iconUrl: "qrc:/content/icons/table.png"
            test: true
        }
        ListElement {
            name: qsTr("测试")
            pageUrl: "qrc:/qt/qml/content/Pages/Test.qml"
            iconUrl: "qrc:/content/icons/test.png"
            test: true
        }
        ListElement {
            name: qsTr("字体")
            pageUrl: "qrc:/qt/qml/content/Pages/FontList.qml"
            iconUrl: "qrc:/content/icons/test.png"
            test: true
        }
    }

    //系统
    readonly property real systemVolumeRatio: 0.2
    readonly property string systemPowerName: qsTr("会议模式")
    readonly property real systemPowerRatio: 0.45
    readonly property var systemPowerList: ListModel {
        ListElement {
            name: qsTr("大屏会议")
            btnchannel: 2
            disBtnChannel: 0
            sizeRatio: 1
            bColor: "forestgreen"
            iconUrl: "qrc:/content/icons/pingmugongxiang.png"
            showDialog: true
        }
        ListElement {
            name: qsTr("普通会议")
            btnchannel: 3
            disBtnChannel: 0
            sizeRatio: 1
            bColor: "forestgreen"
            iconUrl: "qrc:/content/icons/huiyizanzhuyantao.png"
            showDialog: true
        }
        ListElement {
            name: qsTr("结束会议")
            btnchannel: 4
            disBtnChannel: 0
            sizeRatio: 1
            bColor: "tomato"
            iconUrl: "qrc:/content/icons/guanji.png"
            showDialog: true
        }
    }

    readonly property string systemSignalName: qsTr("信号选择")
    readonly property real systemSignalRatio: 0.35
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
            name: qsTr("外网电脑")
            btnchannel: 14
            iconUrl: "qrc:/content/icons/zhuji.png"
        }
        ListElement {
            name: qsTr("无线投屏")
            btnchannel: 15
            iconUrl: "qrc:/content/icons/wuxiantouping.png"
        }
    }

    //视频切换页 输出
    readonly property string videoOutputName: qsTr("输出")
    readonly property real videoOutputRatio: 0.35
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

    //视频切换页 输入
    readonly property string videoInputName: qsTr("输入信号")
    readonly property real videoInputRatio: 0.65
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
            bgColor: "indianred"
            source: "qrc:/content/icons/shexiangji.png"
        }
        ListElement {
            name: qsTr("预留输入1")
            inputChannel: 6
            bgColor: "cadetblue"
            source: "qrc:/content/icons/HDMIjiekou.png"
        }
        ListElement {
            name: qsTr("预留输入2")
            inputChannel: 7
            bgColor: "slateblue"
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
    readonly property string cameraPadName: qsTr("摄像机控制")
    readonly property real cameraPadRatio: 0.5
    readonly property int cameraPadChannel: 20
    readonly property string cameraAutoName: qsTr("摄像跟踪")
    readonly property real cameraAutoRatio: 0.5
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
            name: qsTr("鹅颈话筒")
            vChannel: 5
            mChannel: 51
            minVol: -40
            maxVol: 0
            inputType: true
        }
        ListElement {
            name: qsTr("手持话筒")
            vChannel: 6
            mChannel: 52
            minVol: -40
            maxVol: 0
            inputType: true
        }
        ListElement {
            name: qsTr("电脑音频")
            vChannel: 7
            mChannel: 53
            minVol: -40
            maxVol: 5
            inputType: true
        }

        ListElement {
            name: qsTr("外接音频")
            vChannel: 8
            mChannel: 54
            minVol: -40
            maxVol: 5
            inputType: true
        }

        ListElement {
            name: qsTr("总音量")
            vChannel: 9
            mChannel: 55
            minVol: -40
            maxVol: 5
            inputType: false
        }
    }

    //灯光页 灯光
    readonly property string lightName: qsTr("单独控制")
    readonly property real lightRatio: 0.7
    readonly property var lightList: ListModel {
        ListElement {
            name: qsTr("左吸顶灯")
            btnChannel: 61
        }
        ListElement {
            name: qsTr("右吸顶灯")
            btnChannel: 62
        }
        ListElement {
            name: qsTr("前筒灯")
            btnChannel: 63
        }
        ListElement {
            name: qsTr("四周筒灯")
            btnChannel: 64
        }
        ListElement {
            name: qsTr("灯带")
            btnChannel: 65
        }
        ListElement {
            name: qsTr("其他")
            btnChannel: 66
        }
    }
    readonly property string lightModeName: qsTr("灯光模式")
    readonly property real lightModeRatio: 0.3
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
