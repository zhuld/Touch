import QtQuick

Rectangle {
    id: control
    property color bgColor: buttonColor
    property real  widthRatio: 0.5
    height: parent.height
    width: (parent.width+parent.spacing)*widthRatio-parent.spacing

        gradient: Gradient {
            GradientStop { position: 1.0; color: Qt.lighter(bgColor,1.5) }
            GradientStop { position: 0.0; color: Qt.darker(bgColor,1.6) }
        }
    radius: height*0.02
}
