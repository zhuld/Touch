import QtQuick
import QtQuick.Controls

import "../Custom/"

Dialog {
    id: confirmDialog
    property alias dialogTitle: title.text
    property alias dialogInfomation: info.text
    property alias dialogIcon: info.icon.source
    signal confirm

    property int autoClose: 30
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
        MyIconLabel {
            id: info
            height: parent.height * 0.38
            width: parent.width
            color: Global.buttonTextColor
            icon.color: Global.buttonTextColor
        }
        Row {
            width: parent.width
            height: parent.height * 0.3
            spacing: width * 0.06
            ColorButton {
                id: settingOK
                width: parent.width * 0.47
                height: parent.height
                text: "确定"
                onPressedChanged: {
                    if (!pressed) {
                        confirm()
                    }
                }
            }
            ColorButton {
                id: settingCancel
                width: parent.width * 0.47
                height: parent.height
                text: "取消"
                onPressedChanged: {
                    if (!pressed) {
                        confirmDialog.close()
                    }
                }
            }
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
                confirmDialog.close()
            }
        }
    }
    onOpened: {
        during = autoClose
        countDownTimer.start()
    }
    onClosed: {
        countDownTimer.stop()
    }
}
