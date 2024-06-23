import QtQuick
import QtQuick.Controls

import "qrc:/qt/qml/content/ws.js" as WS

Item {
    id: control
    property int channel
    property color btnColor: buttonCheckedColor

    property color switchColor: buttonTextColor

    property bool checked

    implicitWidth: height*2
    implicitHeight: parent.height

    Rectangle {
        id:rect
        anchors.fill: parent
        radius: height*0.5
        color: control.checked ? Qt.lighter(btnColor,1.2):Qt.darker(btnColor,1.6)
        border.color: backgroundColor
        Text {
            width: parent.width*0.7
            height: parent.height
            horizontalAlignment: control.checked ? Text.AlignLeft : Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: control.checked ? "开":"关"
            font.pixelSize: parent.height*0.6
            color: switchColor
        }
        Rectangle {
            x: control.checked ? parent.width - parent.height : parent.height - height
            width: parent.height*0.8
            height: width
            radius: height*0.5
            color: control.down ? Qt.lighter(switchColor,1.4):switchColor
            anchors.verticalCenter: parent.verticalCenter
            //border.color: control.checked ? (control.down ? "#17a81a" : "#21be2b") : "#999999"
            Behavior on x {
                NumberAnimation{
                    easing.type: Easing.InOutCubic;
                    duration: 500}
            }
        }
        Behavior on color {
            ColorAnimation{
                duration: 500}
        }
    }
    checked: root.digital[control.channel]?root.digital[control.channel]:0
    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel? "D"+control.channel : ""
        color: textColor
        font.pixelSize: height*0.3
        z:1
    }
    MouseArea{
        anchors.fill: parent
        onPressed: WS.push(control.channel)
        onReleased: WS.release(control.channel)
    }
}
