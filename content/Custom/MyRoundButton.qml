import QtQuick
import QtQuick.Controls
import QtQuick.Effects

import "qrc:/qt/qml/content/crestroncip.js" as CrestronCIP

RoundButton {
    id: control
    property int channel
    text: qsTr("Button")

    icon.width: height * 0.5
    icon.height: height * 0.5
    icon.color: buttonTextColor

    contentItem: IconLabel {
        anchors.fill: parent
        anchors.centerIn: parent
        icon: control.icon
        opacity: enabled ? 1.0 : 0.3
        color: buttonTextColor
    }
    background: Rectangle {
        id: rect
        anchors.fill: parent
        opacity: enabled ? 1 : 0.3
        color: root.digital[control.channel] ? buttonCheckedColor : buttonColor
        radius: width / 2
        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
    }

    MultiEffect {
        source: rect
        anchors.fill: rect
        shadowEnabled: true
        shadowColor: Qt.alpha(rect.color, 0.8)
        shadowHorizontalOffset: rect.height / 40
        shadowVerticalOffset: shadowHorizontalOffset
    }
    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel ? "D" + control.channel : ""
        color: buttonTextColor
        font.pixelSize: height * 0.3
    }
    onPressed: cipClient.sendData(CrestronCIP.push(control.channel))
    onReleased: cipClient.sendData(CrestronCIP.release(control.channel))
    onHoveredChanged: if (pressed) {
                          cipClient.sendData(CrestronCIP.release(
                                                 control.channel))
                      }
}
