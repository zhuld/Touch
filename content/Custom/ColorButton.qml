import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

Button {
    id: control
    //property alias radius: back.radius
    property color backColor: buttonColor
    property real initY
    property bool inited: false

    implicitHeight: parent.height * 0.9
    implicitWidth: parent.width
    background: Rectangle {
        id: back
        anchors.fill: parent
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
                                                    backColor, 1.4)
                        Behavior on color {
                            ColorAnimation {
                                duration: 100
                            }
                        }
                    }
                    GradientStop {
                        position: 0
                        color: down | checked ? Qt.darker(buttonCheckedColor,
                                                          1.2) : Qt.darker(
                                                    backColor, 1.1)
                        Behavior on color {
                            ColorAnimation {
                                duration: 100
                            }
                        }
                    }
                }
            }
        }

        radius: height / 4
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset / 2
            shadowVerticalOffset: checked || pressed ? height / 60 : height / 30
            Behavior on shadowHorizontalOffset {
                NumberAnimation {
                    duration: 100
                }
            }
        }
    }

    contentItem: Text {
        anchors.fill: parent
        text: control.text
        font.pixelSize: control.height * 0.4
        color: buttonTextColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: alibabaPuHuiTi.font.family
    }
    onPressedChanged: {
        if (!inited) {
            initY = y
            inited = true
        }
        if (pressed) {
            y = initY + height / 40
        } else {
            y = initY
        }
    }
    Behavior on y {
        NumberAnimation {
            duration: 100
        }
    }
}
