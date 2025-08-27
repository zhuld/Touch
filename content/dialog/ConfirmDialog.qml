import QtQuick
import QtQuick.Controls

Dialog {
    id: confirmDialog
    property alias dialogTitle: title.text
    property alias dialogInfomation: info.text
    property alias dialogIcon: info.icon.source
    signal confirm

    property int autoClose: 30
    property int during

    anchors.centerIn: Overlay.overlay
    implicitWidth: Global.settings.windowWidth * 0.5
    implicitHeight: Global.settings.windowHeight * 0.5

    closePolicy: Popup.NoAutoClose
    modal: true

    background: Background {}
    enter: Transition {
        NumberAnimation {
            from: 0
            to: 1
            property: "opacity"
            duration: Global.durationDelay * 2
        }
    }
    exit: Transition {
        NumberAnimation {
            from: 1
            to: 0
            property: "opacity"
            duration: Global.durationDelay * 2
        }
    }
    Column {
        anchors.fill: parent
        anchors.margins: height * 0.05
        spacing: height * 0.15
        MyIconLabel {
            id: title
            height: parent.height * 0.12
            color: Global.buttonTextColor
            text: qsTr("标题")
            font.pixelSize: height
        }
        MyIconLabel {
            id: info
            height: parent.height * 0.35
            //width: parent.width
            color: Global.buttonTextColor
            icon.color: Global.buttonTextColor
        }
        Row {
            width: parent.width
            height: parent.height * 0.24
            spacing: width * 0.06
            layoutDirection: Qt.RightToLeft
            ColorButton {
                id: settingOK
                width: parent.width * 0.4
                height: parent.height
                text: "确定"
                onClicked: confirmDialog.confirm()
                btnColor: Global.buttonColor
            }
            ColorButton {
                id: settingCancel
                width: parent.width * 0.4
                height: parent.height
                text: "取消"
                onClicked: confirmDialog.close()
            }
        }
    }
    Timer {
        id: countDownTimer
        interval: 1000
        repeat: true
        triggeredOnStart: false
        onTriggered: {
            confirmDialog.during--
            if (confirmDialog.during === 0) {
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
