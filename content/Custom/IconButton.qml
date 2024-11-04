import QtQuick
import QtQuick.Controls

Button {
    id: control
    property int channel
    property alias radius: background.radius
    property alias tipText: tip.text
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
                duration: 300
            }
        }
    }

    Text {
        id: tip
        visible: control.hovered
        height: control.height * 0.4
        color: textColor
        font.pixelSize: height
        anchors.top: control.bottom
        anchors.horizontalCenter: control.horizontalCenter
        font.family: alibabaPuHuiTi.font.family
    }
}
