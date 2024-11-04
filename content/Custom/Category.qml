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
                color: Qt.alpha(catagoryColor, 0.3)
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
            GradientStop {
                position: 0.114
                color: Qt.alpha(catagoryColor, 0.5)
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
            GradientStop {
                position: 0.11
                color: catagoryColor
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
        }
        radius: height * 0.03
    }

    MultiEffect {
        source: rectangle
        anchors.fill: rectangle
        shadowEnabled: true
        shadowColor: buttonShadowColor
        shadowHorizontalOffset: rectangle.height / 200
        shadowVerticalOffset: shadowHorizontalOffset
    }
}
