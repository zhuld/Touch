import QtQuick
import QtQuick.Controls
import "../Custom/"

Dialog {
    id: confirmDialog
    property alias dialogTitle: title.text
    property alias dialogInfomation: info.text
    property alias dialogIcon: icon.source
    signal okPress

    anchors.centerIn: Overlay.overlay
    width: root.width * 0.5
    height: root.height * 0.5

    modal: true
    Overlay.modal: Rectangle {
        color: "#A0000000"
    }

    background: Background {}

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

    Column {
        anchors.fill: parent
        anchors.centerIn: parent
        anchors.margins: height * 0.05
        spacing: height * 0.25
        Text {
            id: title
            width: parent.width
            height: parent.height * 0.1
            font.pixelSize: height
            horizontalAlignment: Text.AlignLeft
            color: textColor
            text: qsTr("标题")
            font.family: alibabaPuHuiTi.font.family
        }

        Row {
            width: parent.width
            height: parent.height * 0.15
            Image {
                id: icon
                height: parent.height
                width: height
            }
            Text {
                id: info
                color: textColor
                height: parent.height
                font.pixelSize: height * 0.8
                anchors.top: parent.top
                font.family: alibabaPuHuiTi.font.family
            }
            spacing: width * 0.05
        }
        Row {
            width: parent.width
            height: parent.height * 0.25
            spacing: width * 0.06
            ColorButton {
                id: settingOK
                width: parent.width * 0.47
                height: parent.height
                text: "确定"
                font.pixelSize: height * 0.6
                onClicked: {
                    okPress()
                    confirmDialog.close()
                }
            }
            ColorButton {
                id: settingCancel
                width: parent.width * 0.47
                height: parent.height
                text: "取消"
                font.pixelSize: height * 0.6
                onClicked: confirmDialog.close()
            }
        }
    }
}
