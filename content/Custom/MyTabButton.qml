import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

Button {
    id: control
    property int channel

    width: parent.width
    height: parent.height
    anchors.margins: width * 0.2
    icon.width: height * 0.4
    icon.height: height * 0.4
    icon.color: config.buttonTextColor
    font.pixelSize: height * 0.2
    font.family: alibabaPuHuiTi.font.family

    Material.accent: config.buttonTextColor
    Material.foreground: config.buttonTextColor

    display: AbstractButton.TextUnderIcon

    checked: root.digital[control.channel] ? true : false
    background: Rectangle {
        id: back
        anchors.fill: parent
        opacity: enabled ? 1 : 0.3
        radius: width / 4
        Shape {
            anchors.fill: parent
            ShapePath {
                strokeWidth: 0
                strokeColor: "transparent"
                PathRectangle {
                    x: 0
                    y: 0
                    radius: back.radius
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
                        position: 1
                        color: checked ? Qt.lighter(config.buttonCheckedColor,
                                                    1.3) : Qt.lighter(
                                             config.buttonColor, 1.4)
                        Behavior on color {
                            ColorAnimation {
                                duration: 100
                            }
                        }
                    }
                    GradientStop {
                        position: 0
                        color: checked ? Qt.darker(config.buttonCheckedColor,
                                                   1.1) : Qt.darker(
                                             config.buttonColor, 1.1)
                        Behavior on color {
                            ColorAnimation {
                                duration: 100
                            }
                        }
                    }
                }
            }
        }
        Behavior on color {
            ColorAnimation {
                duration: 100
            }
        }
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: config.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset / 2
            shadowVerticalOffset: checked ? height / 40 : height / 20
            Behavior on shadowHorizontalOffset {
                NumberAnimation {
                    duration: 100
                }
            }
        }
    }
    onPressedChanged: {
        if (pressed) {
            CrestronCIP.push(control.channel)
        } else {
            CrestronCIP.release(control.channel)
        }
    }
    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel ? "D" + control.channel : ""
        color: config.buttonTextColor
        font.pixelSize: channelSize
        font.family: alibabaPuHuiTi.font.family
    }
}
