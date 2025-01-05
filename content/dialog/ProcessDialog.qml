import QtQuick
import QtQuick.Controls
import QtQuick.Effects

import "../Custom/"

Dialog {
    id: processDialog
    property int channel
    property alias dialogTitle: title.text
    property alias dialogInfomation: info.text

    property int autoClose: 60
    property int during

    anchors.centerIn: Overlay.overlay
    width: root.width * 0.5
    height: root.height * 0.5

    closePolicy: Popup.NoAutoClose
    modal: true
    Overlay.modal: Rectangle {
        color: "#80000000"
    }

    background: Background {}

    enter: Transition {
        NumberAnimation {
            from: 0
            to: 1
            property: "opacity"
            duration: 100
        }
    }
    exit: Transition {
        NumberAnimation {
            from: 1
            to: 0
            property: "opacity"
            duration: 100
        }
    }
    Column {
        anchors.fill: parent
        anchors.margins: height * 0.05
        spacing: height * 0.1
        MyIconLabel {
            id: title
            height: parent.height * 0.12
            color: Global.buttonTextColor
            text: qsTr("标题")
            font.pixelSize: height
        }
        BusyIndicator {
            id: busy
            height: parent.height * 0.56
            width: parent.width
            Material.accent: Global.buttonColor
            layer.enabled: true
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: Global.buttonShadowColor
                shadowHorizontalOffset: shadowHeight
                shadowVerticalOffset: shadowHorizontalOffset
            }
        }
        Timer {
            id: countDownTimer
            interval: 1000
            repeat: true
            triggeredOnStart: false
            onTriggered: {
                during--
                if (during === 0) {
                    processDialog.close()
                }
            }
        }
        MyIconLabel {
            id: info
            height: parent.height * 0.12
            width: parent.width
            color: Global.buttonTextColor
            text: qsTr("信息")
            font.pixelSize: height
        }
        Text {
            id: channel
            anchors.right: parent.right
            text: Global.settings.showChannel ? "D" + processDialog.channel : ""
            color: Global.buttonTextColor
            font.pixelSize: channelSize
            font.family: Global.alibabaPuHuiTi.font.family
        }
    }
    onOpened: {
        during = autoClose
        countDownTimer.start()
    }

    onClosed: {
        let tmpD = Global.digital
        tmpD[processDialog.channel] = false
        Global.digital = tmpD
        countDownTimer.stop()
    }
    visible: Global.digital[processDialog.channel] ? true : false
}
