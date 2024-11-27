import QtQuick
import QtQuick.Effects

Rectangle {
    anchors.fill: parent
    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: Qt.alpha(backgroundColor, 0.9)
        }
        GradientStop {
            position: 0.8
            color: Qt.darker(backgroundColor, 1.5)
        }
    }
    radius: width * 0.02
    layer.enabled: true
    layer.effect: MultiEffect {
        brightness: 0.2
        saturation: 0.1
        blurEnabled: true
        blurMax: height / 40
        blur: 1.0
    }
}
