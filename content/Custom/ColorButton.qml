import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Button {
    id: control
    property real btnRadius: 0
    property color backColor: buttonColor

    implicitHeight: parent.height
    implicitWidth: parent.width
    text: qsTr("Button")

    background: Rectangle {
        id: back
        anchors.fill: parent
        border.color: buttonCheckedColor
        border.width: control.height * 0.02
        color: control.down | control.checked ? buttonCheckedColor : backColor
        radius: btnRadius
        Behavior on color {
            ColorAnimation {
                duration: 300
            }
        }
    }
    MultiEffect {
        source: back
        anchors.fill: back
        shadowEnabled: true
        shadowColor: buttonShadowColor
        shadowHorizontalOffset: back.height / 40
        shadowVerticalOffset: shadowHorizontalOffset
    }
    contentItem: Text {
        anchors.fill: parent
        text: control.text
        font.pixelSize: control.height * 0.4
        color: buttonTextColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: alibabaPuHuiTi.font.family
    }
}
