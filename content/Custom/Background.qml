import QtQuick
import QtQuick.Effects

Rectangle {
    anchors.fill: parent
    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: Qt.lighter(config.backgroundColor, 1.3)
        }
        GradientStop {
            position: 0.8
            color: Qt.darker(config.backgroundColor, 1.3)
        }
    }
    radius: height / 20
}
