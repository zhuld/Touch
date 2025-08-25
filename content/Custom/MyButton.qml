pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import QtQuick.Templates as T

import "../Js/crestroncip.js" as CrestronCIP

T.Button {
    id: controlMyButton
    property int channel
    property int disEnableChannel: 0
    property bool confirm: false
    property color btnColor: Global.buttonColor
    property color btnCheckColor: Global.buttonCheckedColor

    property real radius: controlMyButton.height / 5
    property string source
    property color textColor: checked ? Global.backgroundColor : Global.buttonTextColor
    property color iconColor: checked ? Global.backgroundColor : Global.buttonTextColor

    checked: Global.digital[controlMyButton.channel] ? true : false

    implicitHeight: parent.height
    implicitWidth: parent.width

    enabled: Global.digital[controlMyButton.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6
    Behavior on opacity {
        OpacityAnimator {
            duration: Global.durationDelay
        }
    }

    //Material.accent: Global.buttonTextColor
    onPressedChanged: {
        if (pressed) {
            if (!confirm) {
                CrestronCIP.push(controlMyButton.channel)
            } else {
                confirmDialog.open()
            }
        } else {
            if (!confirm) {
                CrestronCIP.release(controlMyButton.channel)
            }
        }
    }
    contentItem: MyIconLabel {
        anchors.fill: back
        color: controlMyButton.textColor
        icon.color: controlMyButton.iconColor
        icon.source: controlMyButton.source
        text: controlMyButton.text
    }
    background: Shape {
        id: back
        height: parent.height
        width: parent.width
        y: controlMyButton.checked ? height / 40 : 0
        Behavior on y {
            NumberAnimation {
                duration: Global.durationDelay
            }
        }
        containsMode: Shape.FillContains
        layer.enabled: true
        layer.samples: 16
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: Global.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset
            shadowVerticalOffset: controlMyButton.enabled ? (controlMyButton.checked ? Global.shadowHeight / 2 : Global.shadowHeight) : Global.shadowHeight / 4
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
                id: pathRect
                x: 0
                y: 0
                radius: controlMyButton.radius
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
                    color: controlMyButton.checked ? Qt.darker(
                                                         controlMyButton.btnCheckColor,
                                                         1.4) : Qt.darker(
                                                         controlMyButton.btnColor,
                                                         1.4)
                    Behavior on color {
                        ColorAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
                GradientStop {
                    position: 1
                    color: controlMyButton.checked ? Qt.lighter(
                                                         controlMyButton.btnCheckColor,
                                                         1.2) : Qt.lighter(
                                                         controlMyButton.btnColor,
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
    ConfirmDialog {
        id: confirmDialog
        dialogIcon: controlMyButton.source
        dialogInfomation: "确定" + controlMyButton.text + "？"
        dialogTitle: "提示"
        Timer {
            id: releaseTimer
            interval: 100
            repeat: false
            triggeredOnStart: false
            onTriggered: {
                confirmDialog.close()
                CrestronCIP.release(controlMyButton.channel)
            }
        }
        onConfirm: {
            CrestronCIP.push(controlMyButton.channel)
            releaseTimer.start()
        }
    }
    Text {
        id: channel
        height: parent.height
        text: Global.settings.showChannel ? "D" + controlMyButton.channel + "E"
                                            + controlMyButton.disEnableChannel : ""
        color: Global.buttonTextColor
        font.pixelSize: Global.channelSize
        font.family: Global.alibabaPuHuiTi.font.family
    }
}
