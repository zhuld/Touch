import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

Item {
    id: control
    property color btnColor: config.buttonColor
    property alias source: _icon.icon.source
    property alias iconColor: _icon.icon.color
    property alias text: _icon.text
    property alias radius: pathRect.radius
    property alias pressed: mouseArea.pressed

    implicitHeight: parent.height
    implicitWidth: parent.width
    Shape {
        id: back
        height: parent.height
        width: parent.width
        y: mouseArea.pressed ? height / 40 : 0
        anchors.horizontalCenter: parent.horizontalCenter
        Behavior on y {
            NumberAnimation {
                duration: 100
            }
        }
        IconLabel {
            id: _icon
            height: parent.height
            width: parent.width
        }
        containsMode: Shape.FillContains
        layer.enabled: true
        layer.samples: 16
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: config.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset
            shadowVerticalOffset: mouseArea.pressed ? shadowHeight / 2 : shadowHeight
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
                radius: back.height / 5
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
                    color: mouseArea.pressed ? Qt.darker(
                                                   config.buttonCheckedColor,
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
                    color: mouseArea.pressed ? Qt.lighter(
                                                   config.buttonCheckedColor,
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
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }
}
