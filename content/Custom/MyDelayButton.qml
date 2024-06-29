import QtQuick
import QtQuick.Controls

import "qrc:/qt/qml/content/ws.js" as WS

DelayButton {
    id:control

    property int channel
    property color btnColor: buttonColor

    delay: 2000

    text: qsTr("DelayBtn")

    icon.width: height*0.5
    icon.height: height*0.5
    icon.color:  buttonTextColor
    font.pixelSize: height*0.4
    contentItem: IconLabel {
        text: control.text
        font: control.font
        icon: control.icon
        opacity: enabled ? 1.0 : 0.3
        color: buttonTextColor
        display: AbstractButton.TextBesideIcon
        spacing: width*0.1
    }
    background: Rectangle {
        anchors.fill: parent
        opacity: enabled ? 1 : 0.3
        color: root.digital[control.channel]? btnColor:Qt.darker(btnColor,1.6)
        radius: height*0.1
        Rectangle {
            id:progressBar
            height: parent.height
            width: parent.width*control.progress
            opacity: enabled ? 1 : 0.3
            color: btnColor
            radius: parent.radius
        }
    }
    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel? "D"+control.channel : ""
        color: buttonTextColor
        font.pixelSize: height*0.3
    }

    onPressed: WS.push(control.channel)
    onReleased: WS.release(control.channel)
    onActivated: progress = 0
}
