import QtQuick

Rectangle{
    anchors.fill: parent
    gradient: Gradient {
        GradientStop { position: 0.0; color: Qt.lighter(backgroundColor,1.5) }
        GradientStop { position: 1.0; color: Qt.darker(backgroundColor,1.6) }
    }
}
