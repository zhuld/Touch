import QtQuick
import QtQuick.Controls

import "qrc:/qt/qml/content/ws.js" as WS

RoundButton {
    id:control
    property int channel
    text: qsTr("Button")

    icon.width: height*0.5
    icon.height: height*0.5
    icon.color:  buttonTextColor

    contentItem: IconLabel {
        anchors.fill: parent
        anchors.centerIn: parent
        icon: control.icon
        opacity: enabled ? 1.0 : 0.3
        color: buttonTextColor
    }
    background: Rectangle {
        id:background
        anchors.fill: parent
        opacity: enabled ? 1 : 0.3
        color: root.digital[control.channel]?  buttonCheckedColor:buttonColor
        radius: width/2
        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
        border.width: height*0.02
        border.color: buttonCheckedColor
    }
    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel? "D"+control.channel : ""
        color: buttonTextColor
        font.pixelSize: height*0.3
    }
    MouseArea{
        anchors.fill: parent
        onPressed: WS.push(control.channel)
        onReleased: WS.release(control.channel)
    }
}
