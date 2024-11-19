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
        radius: height * 0.1
        gradient: Gradient {
            GradientStop {
                position: 0.2
                color: down | checked ? Qt.darker(buttonCheckedColor,
                                                  1.3) : btnColor
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            GradientStop {
                position: 1
                color: down | checked ? buttonCheckedColor : Qt.darker(
                                            btnColor, 1.4)
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
        }
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: buttonShadowColor
            shadowHorizontalOffset: control.checked ? height / 60 : height / 20
            shadowVerticalOffset: shadowHorizontalOffset
            Behavior on shadowHorizontalOffset {
                NumberAnimation {
                    duration: 100
                }
            }
        }
    }

    ConfirmDialog {
        id: confirmdialog
        dialogIcon: icon.source
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
    onPressedChanged: {
        if (pressed) {
            if (!confirm) {
                CrestronCIP.push(control.channel)
            } else {
                confirmdialog.open()
            }
        } else {
            if (!confirm) {
                CrestronCIP.release(control.channel)
            }
        }
    }
}
