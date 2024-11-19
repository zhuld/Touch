import QtQuick
import QtQuick.Controls

Button {
    id: control
    property int channel
    property alias radius: background.radius
    property color backColor: buttonColor

    icon.width: height * 0.5
    icon.height: height * 0.5
    icon.color: buttonTextColor

    background: Rectangle {
        id: background
        anchors.fill: parent
        opacity: enabled ? 1 : 0.3
        color: control.hovered ? backColor : "transparent"
        radius: height * 0.1
        Behavior on color {
            ColorAnimation {
                duration: 100
            }
        }
    }
}
