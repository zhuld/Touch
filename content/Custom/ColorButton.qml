pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import QtQuick.Templates as T

T.Button {
    id: controlColorButton
    property color btnColor: Global.backgroundColor
    property color btnCheckColor: Global.buttonCheckedColor
    property color textColor: pressed ? Global.backgroundColor : Global.buttonTextColor
    property color iconColor: pressed ? Global.backgroundColor : Global.buttonTextColor
    property string source

    property real radius: height / 5

    implicitHeight: parent.height
    implicitWidth: parent.width

    opacity: enabled ? 1 : 0.6

    contentItem: MyIconLabel {
        anchors.fill: back
        icon.source: controlColorButton.source
        icon.color: controlColorButton.iconColor
        color: controlColorButton.textColor
        text: controlColorButton.text
    }
    background: Shape {
        id: back
        height: parent.height
        width: parent.width
        y: controlColorButton.pressed ? height / 40 : 0
        anchors.horizontalCenter: parent.horizontalCenter
        Behavior on y {
            NumberAnimation {
                duration: Global.durationDelay
            }
        }
        containsMode: Shape.FillContains
        layer.enabled: true
        layer.samples: 16
        layer.effect: MultiEffect {
            shadowEnabled: !Qt.colorEqual(controlColorButton.btnColor,
                                          "transparent")
            shadowColor: Global.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset
            shadowVerticalOffset: controlColorButton.pressed ? Global.shadowHeight
                                                               / 4 : Global.shadowHeight / 2
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
                radius: controlColorButton.radius
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
                    color: controlColorButton.pressed ? Qt.darker(
                                                            controlColorButton.btnCheckColor,
                                                            1.4) : Qt.darker(
                                                            controlColorButton.btnColor,
                                                            1.4)
                    Behavior on color {
                        ColorAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
                GradientStop {
                    position: 1
                    color: controlColorButton.pressed ? Qt.lighter(
                                                            controlColorButton.btnCheckColor,
                                                            1.2) : Qt.lighter(
                                                            controlColorButton.btnColor,
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
}
