import QtQuick
import QtQuick.Controls
import "../Custom/"

Dialog {
    id: msgDialog
    anchors.centerIn: parent
    property alias dialogTitle: title.text
    property alias dialogInfomation: info.text
    property alias dialogIcon: info.icon
    signal okPress
    width: parent.width * 0.5
    height: parent.height * 0.35

    modal: true
    Overlay.modal: Rectangle {
        color: "#A0000000"
    }

    enter: Transition {
        NumberAnimation {
            from: 0
            to: 1
            property: "opacity"
            duration: 200
        }
    }
    exit: Transition {
        NumberAnimation {
            from: 1
            to: 0
            property: "opacity"
            duration: 200
        }
    }

    background: Background {}

    Column {
        anchors.fill: parent
        anchors.margins: height * 0.05
        spacing: height * 0.15
        Text {
            id: title
            width: parent.width
            height: parent.height * 0.15
            font.pixelSize: height
            horizontalAlignment: Text.AlignLeft
            color: textColor
            text: qsTr("标题")
        }
        IconLabel {
            id: info
            width: parent.width
            height: parent.height * 0.2
            font.pixelSize: height
            text: qsTr("信息")
            icon.source: "qrc:/content/icons/hdmi.png"
            icon.color: textColor
            color: textColor
            icon.height: height
            icon.width: height
            spacing: width * 0.05
        }
        Row {
            width: parent.width
            height: parent.height * 0.35
            spacing: 0
            ColorButton {
                id: settingOK
                width: parent.width * 0.5
                height: parent.height
                text: "确定"
                font.pixelSize: height * 0.5
                onClicked: {
                    okPress()
                    msgDialog.close()
                }
            }
            ColorButton {
                id: settingCancel
                width: parent.width * 0.5
                height: parent.height
                text: "取消"
                font.pixelSize: height * 0.5
                onClicked: msgDialog.close()
            }
        }
    }
}
