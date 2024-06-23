import QtQuick
import QtQuick.Controls

import "qrc:/qt/qml/content/ws.js" as WS

Button {
    id:control
    property int channel
    property color btnColor: buttonCheckedColor
    property color textColor: buttonTextColor
    property alias radius: background.radius

    text: qsTr("Button")

    icon.width: height*0.5
    icon.height: height*0.5
    icon.color:  buttonTextColor
    font.pixelSize: height*0.35
    contentItem: IconLabel {
        text: control.text
        font: control.font
        icon: control.icon
        opacity: enabled ? 1.0 : 0.3
        color: textColor
        display: AbstractButton.TextBesideIcon
        spacing: width*0.05
    }
    background: Rectangle {
        id:background
        anchors.fill: parent
        opacity: enabled ? 1 : 0.3
        color: root.digital[control.channel]? Qt.lighter(btnColor,1.4):btnColor
        radius: height*0.1
        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
    }

    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel? "D"+control.channel : ""
        color: textColor
        font.pixelSize: height*0.3
    }
    MouseArea{
        anchors.fill: parent
        onPressed: WS.push(control.channel)
        onReleased: WS.release(control.channel)
    }
}
