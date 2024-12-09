import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

TabButton {
    id: control
    property int channel

    width: parent.width
    height: parent.height
    icon.width: height * 0.4
    icon.height: height * 0.4
    icon.color: buttonTextColor
    font.pixelSize: height * 0.2
    font.family: alibabaPuHuiTi.font.family

    Material.accent: buttonTextColor

    anchors.margins: width * 0.2

    display: AbstractButton.TextUnderIcon

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
                        color: down | checked ? Qt.lighter(buttonCheckedColor,
                                                           1.3) : Qt.lighter(
                                                    buttonColor, 1.4)
                        Behavior on color {
                            ColorAnimation {
                                duration: 100
                            }
                        }
                    }
                    GradientStop {
                        position: 0
                        color: down | checked ? Qt.darker(buttonCheckedColor,
                                                          1.1) : Qt.darker(
                                                    buttonColor, 1.1)
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
            shadowColor: buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset / 2
            shadowVerticalOffset: checked ? height / 40 : height / 20
            Behavior on shadowHorizontalOffset {
                NumberAnimation {
                    duration: 100
                }
            }
        }
    }
    onCheckedChanged: {
        if (checked) {
            CrestronCIP.push(control.channel)
        } else {
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
}
