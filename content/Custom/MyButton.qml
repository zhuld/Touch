import QtQuick
import QtQuick.Controls
import QtQuick.Effects

import "../dialog"
import "qrc:/qt/qml/content/crestroncip.js" as CrestronCIP

Button {
    id: control
    property int channel
    property alias radius: back.radius
    property bool confirm: false

    implicitHeight: parent.height
    implicitWidth: parent.width

    checked: root.digital[control.channel] ? root.digital[control.channel] : false
    icon.width: height * 0.5
    icon.height: height * 0.5
    icon.color: buttonTextColor
    font.pixelSize: height * 0.35
    font.family: alibabaPuHuiTi.font.family

    Material.accent: buttonTextColor

    background: Rectangle {
        id: back
        anchors.fill: parent
        color: root.digital[control.channel] ? buttonCheckedColor : buttonColor
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
}
