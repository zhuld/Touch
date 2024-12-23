import QtQuick
import QtQuick.Controls

Button {
    id: control
    property color backColor: config.buttonColor

    icon.width: height * 0.5
    icon.height: height * 0.5
    icon.color: config.buttonTextColor
    hoverEnabled: true
    background: Rectangle {
        id: background
        opacity: enabled ? 1 : 0.3
        color: control.hovered ? backColor : "transparent"
        radius: height * 0.1
        Behavior on color {
            ColorAnimation {
                duration: 500
            }
        }
    }
}
