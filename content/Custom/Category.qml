import QtQuick
import QtQuick.Effects

Item {
    id: control
    property real widthRatio: 0.5
    height: parent.height
    width: (parent.width + parent.spacing) * widthRatio - parent.spacing
    Rectangle {
        id: rectangle
        height: parent.height
        width: parent.width
        gradient: Gradient {
            GradientStop {
                position: 1.0
                color: Qt.alpha(catagoryColor, 0.2)
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            GradientStop {
                position: 0.114
                color: Qt.alpha(catagoryColor, 0.6)
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            GradientStop {
                position: 0.11
                color: catagoryColor
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
        }
        radius: height * 0.03
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: buttonShadowColor
            shadowHorizontalOffset: height / 100
            shadowVerticalOffset: shadowHorizontalOffset / 2
        }
    }
}
