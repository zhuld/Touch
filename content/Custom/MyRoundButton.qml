import QtQuick
import QtQuick.Controls
import QtQuick.Effects

import "qrc:/qt/qml/content/crestroncip.js" as CrestronCIP

RoundButton {
    id: control
    property int channel
    property color backColor: buttonColor

    icon.width: height * 0.5
    icon.height: height * 0.5
    icon.color: buttonTextColor
    font.family: alibabaPuHuiTi.font.family

    background: Rectangle {
        id: rect
        anchors.fill: parent
        opacity: enabled ? 1 : 0.3
        color: root.digital[control.channel] ? buttonCheckedColor : backColor
        radius: width / 2
        Behavior on color {
            ColorAnimation {
                duration: 400
            }
        }
    }

    MultiEffect {
        source: rect
        anchors.fill: rect
        shadowEnabled: true
        shadowColor: buttonShadowColor
        shadowHorizontalOffset: rect.height / 40
        shadowVerticalOffset: shadowHorizontalOffset
    }
    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel ? "D" + control.channel : ""
        color: buttonTextColor
        font.pixelSize: height * 0.3
        font.family: alibabaPuHuiTi.font.family
    }
    onPressed: CrestronCIP.push(control.channel)
    onReleased: CrestronCIP.release(control.channel)
    onHoveredChanged: if (pressed) {
                          CrestronCIP.release(control.channel)
                      }
}
