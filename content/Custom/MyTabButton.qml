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
    property color btnColor: config.buttonColor

    property alias source: _icon.icon.source
    property alias text: textLabel.text
    property bool checked: root.digital[control.channel] ? true : false

    implicitHeight: parent.height
    implicitWidth: parent.width

    enabled: root.digital[control.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6
    Material.accent: config.buttonTextColor

    visible: control.channel === 0 ? false : true

    Shape {
        id: back
        property int channel: control.channel
        property bool checked: root.digital[control.channel] ? true : false
        height: parent.height
        width: parent.width
        y: checked ? height / 40 : 0
        anchors.horizontalCenter: parent.horizontalCenter
        Behavior on y {
            NumberAnimation {
                duration: 100
            }
        }
        IconButton {
            id: _icon
            height: parent.height * 0.6
            width: height
            anchors.horizontalCenter: parent.horizontalCenter
            icon.height: height
            icon.width: width
            icon.source: "qrc:/content/icons/up.png"
        }
        Text {
            id: textLabel
            width: parent.width
            height: parent.height * 0.2
            font.pixelSize: height * 0.5
            anchors.top: _icon.bottom
            horizontalAlignment: Text.AlignHCenter
            anchors.bottom: parent.bottom
            color: config.buttonTextColor
            font.family: alibabaPuHuiTi.font.family
        }
        containsMode: Shape.FillContains
        layer.enabled: true
        layer.samples: 16
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: config.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset
            shadowVerticalOffset: back.checked ?shadowHeight / 2 : shadowHeight
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
                focalX: back.width * 0.25
                focalY: back.height * 0.25
                GradientStop {
                    position: 0
                    color: back.checked ? Qt.darker(config.buttonCheckedColor,
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
                    color: back.checked ? Qt.lighter(config.buttonCheckedColor,
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
        text: root.settings.showChannel ? "D" + control.channel + "E"
                                          + control.disEnableChannel : ""
        color: config.buttonTextColor
        font.pixelSize: channelSize
        font.family: alibabaPuHuiTi.font.family
    }
}
