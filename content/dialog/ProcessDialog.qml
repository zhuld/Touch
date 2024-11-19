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

    Rectangle {
        anchors.fill: parent
        anchors.margins: height * 0.05
        color: "transparent"
        Text {
            id: title
            width: parent.width
            height: parent.height * 0.12
            font.pixelSize: height
            horizontalAlignment: Text.AlignLeft
            color: textColor
            font.family: alibabaPuHuiTi.font.family
            IconButton {
                id: close
                height: parent.height
                width: height
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                icon.source: "qrc:/content/icons/close.png"
                onClicked: {
                    processDialog.close()
                }
                visible: during < 10
            }
        }
        BusyIndicator {
            id: busy
            height: parent.height / 2
            width: height
            Material.accent: catagoryColor
            anchors.centerIn: parent
            layer.enabled: true
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: buttonShadowColor
                shadowHorizontalOffset: height / 40
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

        Text {
            id: info
            height: parent.height * 0.12
            font.pixelSize: height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            color: textColor
            font.family: alibabaPuHuiTi.font.family
        }
        Text {
            id: channel
            height: parent.height * 0.12
            anchors.right: parent.right
            text: root.settings.showChannel ? "D" + processDialog.channel : ""
            color: buttonTextColor
            font.pixelSize: height
            font.family: alibabaPuHuiTi.font.family
        }
    }
    onOpened: {
        during = autoClose
        countDownTimer.start()
    }

    onClosed: {
        let tmpD = root.digital
        tmpD[processDialog.channel] = false
        root.digital = tmpD
        countDownTimer.stop()
    }
    // Component.onCompleted: {
    visible: root.digital[channel] ? true : false
    // }
}
