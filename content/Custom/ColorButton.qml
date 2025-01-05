import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

Item {
    id: control
    property color btnColor: Global.backgroundColor
    property color btnCheckColor: Global.buttonCheckedColor
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
        MyIconLabel {
            id: _icon
            height: parent.height
            width: parent.width
            color: mouseArea.pressed ? Global.backgroundColor : Global.buttonTextColor
        }
        containsMode: Shape.FillContains
        layer.enabled: true
        layer.samples: 16
        layer.effect: MultiEffect {
            shadowEnabled: !Qt.colorEqual(control.btnColor, "transparent")
            shadowColor: Global.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset
            shadowVerticalOffset: mouseArea.pressed ? shadowHeight / 4 : shadowHeight / 2
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
                focalX: 0
                focalY: 0
                GradientStop {
                    position: 0
                    color: mouseArea.pressed ? Qt.darker(btnCheckColor,
                                                         1.4) : Qt.darker(
                                                   btnColor, 1.4)
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
                GradientStop {
                    position: 1
                    color: mouseArea.pressed ? Qt.lighter(btnCheckColor,
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
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }
}
