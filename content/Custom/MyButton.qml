import QtQuick
import QtQuick.Controls
import QtQuick.Effects

//import "qrc:/qt/qml/content/ws.js" as WS
import "qrc:/qt/qml/content/crestroncip.js" as CrestronCIP

Button {
    id: control
    property int channel
    property alias radius: rect.radius
    property color textColor: buttonTextColor

    checked: root.digital[control.channel] ? root.digital[control.channel] : false

    text: qsTr("Button")

    icon.width: height * 0.5
    icon.height: height * 0.5
    icon.color: buttonTextColor
    font.pixelSize: height * 0.35
    contentItem: IconLabel {
        anchors.fill: parent
        text: control.text
        font: control.font
        icon: control.icon
        color: textColor
        display: AbstractButton.TextBesideIcon
        spacing: width * 0.05
    }

    background: Rectangle {
        id: rect
        anchors.fill: parent
        color: root.digital[control.channel] ? buttonCheckedColor : buttonColor
        radius: height * 0.1
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
