import QtQuick
import QtQuick.Effects

Rectangle {
    anchors.fill: parent
    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: Qt.lighter(config.backgroundColor, 1.1)
        }
        GradientStop {
            position: 0.8
            color: Qt.darker(config.backgroundColor, 1.3)
        }
    }
    radius: height / 20
    layer.enabled: true
    // layer.effect: MultiEffect {
    //     brightness: 0.2
    //     saturation: 0.1
    //     blurEnabled: true
    //     blurMax: height / 40
    //     blur: 1.0
    // }
    // layer.effect: MultiEffect {
    //     shadowEnabled: true
    //     shadowColor: buttonShadowColor
    //     shadowHorizontalOffset: height / 60
    //     shadowVerticalOffset: shadowHorizontalOffset
    // }
}
