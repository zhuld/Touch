import QtQuick
import QtQuick.Effects
import QtQuick.Shapes

Item {
    id: control
    property real widthRatio: 1
    property alias lable: _lable.text
    height: parent.height - parent.width * 0.02
    width: (parent.width * 0.98 + parent.spacing) * widthRatio - parent.spacing
    Shape {
        id: back
        anchors.fill: parent
        containsMode: Shape.FillContains
        layer.enabled: true
        layer.samples: 16
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: config.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset
            shadowVerticalOffset: control.checked ? shadowHeight / 2 : shadowHeight
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
                radius: back.height / 20
                width: back.width
                height: back.height
            }
            fillGradient: LinearGradient {
                y1: 0
                y2: pathRect.height
                x1: pathRect.width / 2
                x2: pathRect.width / 2
                GradientStop {
                    position: 1.0
                    color: Qt.alpha(config.catagoryColor, 0.5)
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
                GradientStop {
                    position: 0.102
                    color: Qt.alpha(config.catagoryColor, 0.7)
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
                GradientStop {
                    position: 0.1
                    color: config.catagoryColor
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
        id: _lable
        text: qsTr("Label")
        height: parent.height * 0.1
        width: parent.width
        font.pixelSize: height * 0.5
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: config.textColor
        font.family: alibabaPuHuiTi.font.family
    }
}
