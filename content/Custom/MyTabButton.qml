import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes
import QtQuick.Templates as T

import "../Dialog"
import "../Js/crestroncip.js" as CrestronCIP

T.TabButton {
    id: controlMyTabButton
    property int channel
    property int disEnableChannel: 0
    property color btnColor: Global.backgroundColor

    property string source
    property color textColor: checked ? Global.backgroundColor : Global.buttonTextColor
    property color iconColor: checked ? Global.backgroundColor : Global.buttonTextColor
    checked: Global.digital[controlMyTabButton.channel] ? true : false

    implicitHeight: parent.height
    implicitWidth: parent.width

    enabled: Global.digital[controlMyTabButton.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6

    onPressedChanged: {
        if (pressed) {
            CrestronCIP.push(controlMyTabButton.channel)
        } else {
            CrestronCIP.release(controlMyTabButton.channel)
        }
    }
    contentItem: MyIconLabel {
        font.pixelSize: height * 0.2
        anchors.fill: back
        spacing: 0
        display: AbstractButton.TextUnderIcon
        color: controlMyTabButton.textColor
        icon.color: controlMyTabButton.iconColor
        icon.source: controlMyTabButton.source
        text: controlMyTabButton.text
    }
    background: Shape {
        id: back
        height: controlMyTabButton.height
        width: controlMyTabButton.width
        y: controlMyTabButton.checked ? height / 40 : 0
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
            shadowVerticalOffset: controlMyTabButton.enabled ? (controlMyTabButton.checked ? shadowHeight / 2 : shadowHeight) : shadowHeight / 4
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
                radius: back.width / 5
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
                    color: controlMyTabButton.checked ? Qt.darker(
                                                            Global.buttonCheckedColor,
                                                            1.4) : Qt.darker(
                                                            controlMyTabButton.btnColor,
                                                            1.4)
                    Behavior on color {
                        ColorAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
                GradientStop {
                    position: 1
                    color: controlMyTabButton.checked ? Qt.lighter(
                                                            Global.buttonCheckedColor,
                                                            1.2) : Qt.lighter(
                                                            controlMyTabButton.btnColor,
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
    Text {
        id: channel
        height: controlMyTabButton.height
        text: Global.settings.showChannel ? "D" + controlMyTabButton.channel + "E"
                                            + controlMyTabButton.disEnableChannel : ""
        color: Global.buttonTextColor
        font.pixelSize: channelSize
        font.family: Global.alibabaPuHuiTi.font.family
    }
}
