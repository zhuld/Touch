import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes
import QtQuick.Templates as T

T.Button {
    id: control
    property color btnColor: Global.backgroundColor
    property color textColor: control.pressed ? Global.backgroundColor : Global.buttonTextColor
    property color iconColor: control.pressed ? Global.backgroundColor : Global.buttonTextColor
    property string source

    property real radius: control.height / 5

    implicitHeight: parent.height
    implicitWidth: parent.width

    contentItem: MyIconLabel {
        anchors.fill: back
        icon.source: source
        icon.color: control.iconColor
        color: control.textColor
        text: control.text
    }
    background: Shape {
        id: back
        height: parent.height
        width: parent.width
        y: control.pressed ? height / 40 : 0
        anchors.horizontalCenter: parent.horizontalCenter
        Behavior on y {
            NumberAnimation {
                duration: 100
            }
        }
        containsMode: Shape.FillContains
        layer.enabled: true
        layer.samples: 16
        layer.effect: MultiEffect {
            shadowEnabled: !Qt.colorEqual(control.btnColor, "transparent")
            shadowColor: Global.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset
            shadowVerticalOffset: control.pressed ? shadowHeight / 4 : shadowHeight / 2
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
                id: pathRect
                x: 0
                y: 0
                radius: control.radius
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
                    color: control.pressed ? Qt.darker(
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
                    color: control.pressed ? Qt.lighter(
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
}
