import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes
import QtQuick.Templates as T

import "../"
import "../Dialog"
import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

T.Button {
    id: control
    property int channel
    property int disEnableChannel: 0
    property bool confirm: false
    property color btnColor: Global.buttonColor

    property string source
    property color textColor: Global.buttonTextColor
    property color iconColor: checked ? Global.backgroundColor : Global.buttonTextColor

    checked: Global.digital[control.channel] ? true : false

    implicitHeight: parent.height
    implicitWidth: parent.width

    enabled: Global.digital[control.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6
    Behavior on opacity {
        OpacityAnimator {
            duration: Global.durationDelay
        }
    }
    Material.accent: Global.buttonTextColor

    onPressedChanged: {
        if (pressed) {
            if (!confirm) {
                CrestronCIP.push(control.channel)
            } else {
                confirmDialog.open()
            }
        } else {
            if (!confirm) {
                CrestronCIP.release(control.channel)
            }
        }
    }
    background: Shape {
        id: back
        height: control.height * 0.7
        width: height
        y: control.checked ? height / 40 : 0
        Behavior on y {
            NumberAnimation {
                duration: Global.durationDelay
            }
        }
        anchors.horizontalCenter: parent.horizontalCenter
        containsMode: Shape.FillContains
        layer.enabled: true
        layer.samples: 16
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: Global.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset
            shadowVerticalOffset: control.enabled ? (control.checked ? shadowHeight / 2 : shadowHeight) : shadowHeight / 4
            Behavior on shadowHorizontalOffset {
                NumberAnimation {
                    duration: Global.durationDelay
                }
            }
        }
        ShapePath {
            strokeWidth: 0
            strokeColor: "transparent"
            PathRectangle {
                x: 0
                y: 0
                radius: back.width / 2
                width: back.width
                height: back.height
            }
            fillGradient: RadialGradient {
                centerX: back.width * 0.5
                centerY: back.height * 0.5
                centerRadius: back.width
                focalX: 0
                focalY: 0
                GradientStop {
                    position: 0
                    color: control.checked ? Qt.darker(
                                                 Global.buttonCheckedColor,
                                                 1.4) : Qt.darker(btnColor, 1.4)
                    Behavior on color {
                        ColorAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
                GradientStop {
                    position: 1
                    color: control.checked ? Qt.lighter(
                                                 Global.buttonCheckedColor,
                                                 1.2) : Qt.lighter(btnColor,
                                                                   1.2)
                    Behavior on color {
                        ColorAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
            }
        }
    }
    contentItem: MyIconLabel {
        anchors.fill: back
        icon.color: control.iconColor
        icon.source: control.source
    }
    MyIconLabel {
        id: textLabel
        width: parent.width
        height: parent.height * 0.18
        font.pixelSize: height
        anchors.bottom: parent.bottom
        color: control.textColor
        text: control.text
    }
    Text {
        id: channel
        height: parent.height
        text: Global.settings.showChannel ? "D" + control.channel + "E"
                                            + control.disEnableChannel : ""
        color: Global.buttonTextColor
        font.pixelSize: channelSize
        font.family: Global.alibabaPuHuiTi.font.family
    }
    ConfirmDialog {
        id: confirmDialog
        dialogIcon: control.source
        dialogInfomation: "确定" + control.text + "？"
        dialogTitle: "提示"
        Timer {
            id: releaseTimer
            interval: 100
            repeat: false
            triggeredOnStart: false
            onTriggered: {
                confirmDialog.close()
                CrestronCIP.release(control.channel)
            }
        }
        onConfirm: {
            CrestronCIP.push(control.channel)
            releaseTimer.start()
        }
    }
}
