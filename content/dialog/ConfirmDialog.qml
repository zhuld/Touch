import QtQuick
import QtQuick.Controls

import "../Custom/"

Dialog {
    id: confirmDialog
    property alias dialogTitle: title.text
    property alias dialogInfomation: info.text
    property alias dialogIcon: icon.icon.source
    signal okPress

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
        anchors.centerIn: parent
        anchors.margins: height * 0.05
        spacing: height * 0.1
        Text {
            id: title
            width: parent.width
            height: parent.height * 0.12
            font.pixelSize: height
            horizontalAlignment: Text.AlignLeft
            color: config.textColor
            text: qsTr("标题")
            font.family: alibabaPuHuiTi.font.family
        }
        Row {
            width: parent.width
            height: parent.height * 0.4
            IconButton {
                id: icon
                height: parent.height
                width: height
                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                }
                enabled: false
                icon.color: config.textColor
            }
            Text {
                id: info
                color: config.textColor
                height: parent.height
                font.pixelSize: height * 0.4
                anchors.top: parent.top
                verticalAlignment: Text.AlignVCenter
                font.family: alibabaPuHuiTi.font.family
            }
        }
        Row {
            width: parent.width
            height: parent.height * 0.27
            spacing: width * 0.06
            ColorButton {
                id: settingOK
                width: parent.width * 0.47
                height: parent.height
                text: "确定"
                font.pixelSize: height * 0.6
                onClicked: okPress()
                //radius: height * 0.1
            }
            ColorButton {
                id: settingCancel
                width: parent.width * 0.47
                height: parent.height
                text: "取消"
                font.pixelSize: height * 0.6
                onClicked: confirmDialog.close()
                //radius: height * 0.1
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
