import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes
import QtQuick.Templates as T

import "../Dialog"
import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

T.TabButton {
    id: control
    property int channel
    property int disEnableChannel: 0
    property color btnColor: Global.backgroundColor

    property string source
    property color textColor: checked ? Global.backgroundColor : Global.buttonTextColor
    property color iconColor: checked ? Global.backgroundColor : Global.buttonTextColor
    checked: Global.digital[control.channel] ? true : false

    implicitHeight: parent.height
    implicitWidth: parent.width

    enabled: Global.digital[control.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6

    onPressedChanged: {
        if (pressed) {
            CrestronCIP.push(control.channel)
        } else {
            CrestronCIP.release(control.channel)
        }
    }
    contentItem: MyIconLabel {
        font.pixelSize: height * 0.2
        display: AbstractButton.TextUnderIcon
        color: control.textColor
        icon.color: control.iconColor
        icon.source: control.source
        text: control.text
    }
    background: Shape {
        id: back
        height: control.height
        width: control.width
        y: control.checked ? height / 40 : 0
        Behavior on y {
            NumberAnimation {
                duration: 100
            }
        }
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
                    duration: 100
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
                    color: control.checked ? Qt.darker(
                                                 Global.buttonCheckedColor,
                                                 1.4) : Qt.darker(btnColor, 1.4)
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
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
                            duration: 100
                        }
                    }
                }
            }
        }
    }
    Text {
        id: channel
        height: control.height
        text: Global.settings.showChannel ? "D" + control.channel + "E"
                                            + control.disEnableChannel : ""
        color: Global.buttonTextColor
        font.pixelSize: channelSize
        font.family: Global.alibabaPuHuiTi.font.family
    }
}
