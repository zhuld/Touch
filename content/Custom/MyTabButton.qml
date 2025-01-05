import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

import "../Dialog"
import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

Item {
    id: control
    property int channel
    property int disEnableChannel: 0
    property color btnColor: Global.backgroundColor

    property alias source: _icon.icon.source
    property alias text: _icon.text
    property bool checked: Global.digital[control.channel] ? true : false

    implicitHeight: parent.height
    implicitWidth: parent.width

    enabled: Global.digital[control.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6
    Shape {
        id: back
        property int channel: control.channel
        property bool checked: Global.digital[control.channel] ? true : false
        height: parent.height
        width: parent.width
        y: control.checked ? height / 40 : 0
        Behavior on y {
            NumberAnimation {
                duration: 100
            }
        }
        MyIconLabel {
            id: _icon
            height: parent.height * 0.8
            width: parent.width * 0.8
            anchors.centerIn: parent
            font.pixelSize: height / 4
            display: AbstractButton.TextUnderIcon
            color: control.checked ? Global.backgroundColor : Global.buttonTextColor
            icon.color: control.checked ? Global.backgroundColor : Global.buttonTextColor
        }
        containsMode: Shape.FillContains
        layer.enabled: true
        layer.samples: 16
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: Global.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset
            shadowVerticalOffset: control.enabled ? (back.checked ? shadowHeight / 2 : shadowHeight) : shadowHeight / 4
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
                    color: back.checked ? Qt.darker(Global.buttonCheckedColor,
                                                    1.4) : Qt.darker(btnColor,
                                                                     1.4)
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
                GradientStop {
                    position: 1
                    color: back.checked ? Qt.lighter(Global.buttonCheckedColor,
                                                     1.2) : Qt.lighter(
                                              btnColor, 1.2)
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onPressedChanged: {
                if (pressed) {
                    CrestronCIP.push(control.channel)
                } else {
                    CrestronCIP.release(control.channel)
                }
            }
        }
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
}
