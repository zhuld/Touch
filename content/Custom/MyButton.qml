import QtQuick
import QtQuick.Controls
import QtQuick.Effects

import "../dialog"
import "qrc:/qt/qml/content/js/crestroncip.js" as CrestronCIP

Button {
    id: control
    property int channel
    property int disEnableChannel: 0
    property alias radius: back.radius
    property bool confirm: false
    property color btnColor: buttonColor

    implicitHeight: parent.height
    implicitWidth: parent.width

    checked: root.digital[control.channel] ? true : false
    enabled: root.digital[control.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6

    icon.width: height * 0.5
    icon.height: height * 0.5
    icon.color: buttonTextColor
    font.pixelSize: height * 0.35
    font.family: alibabaPuHuiTi.font.family
    spacing: width * 0.05

    Material.accent: buttonTextColor

    background: Rectangle {
        id: back
        anchors.fill: parent
        color: checked ? buttonCheckedColor : btnColor
        radius: height * 0.1
        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
    }

    MultiEffect {
        source: back
        anchors.fill: back
        shadowEnabled: true
        shadowColor: buttonShadowColor
        shadowHorizontalOffset: back.height / 40
        shadowVerticalOffset: shadowHorizontalOffset
    }

    ConfirmDialog {
        id: confirmdialog
        dialogIcon: "qrc:/content/icons/warn.png"
        dialogInfomation: "确定" + text + "？"
        dialogTitle: "提示"
        onOkPress: {
            CrestronCIP.push(control.channel)
            CrestronCIP.release(control.channel)
        }
    }

    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel ? "D" + control.channel : ""
        color: buttonTextColor
        font.pixelSize: height * 0.3
        font.family: alibabaPuHuiTi.font.family
    }

    Text {
        id: disEnableChannel
        height: parent.height
        text: root.settings.showChannel ? "E" + control.disEnableChannel : ""
        color: buttonTextColor
        font.pixelSize: height * 0.3
        anchors.right: parent.right
        font.family: alibabaPuHuiTi.font.family
    }
    onPressed: {
        if (!confirm) {
            CrestronCIP.push(control.channel)
        } else {
            confirmdialog.open()
        }
    }
    onReleased: {
        if (!confirm) {
            CrestronCIP.release(control.channel)
        }
    }
    onHoveredChanged: if (pressed) {
                          CrestronCIP.release(control.channel)
                      }

    Component.onCompleted: {

    }
}
