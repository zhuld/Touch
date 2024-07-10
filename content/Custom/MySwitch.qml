import QtQuick
import QtQuick.Controls

import "qrc:/qt/qml/content/ws.js" as WS

Item {
    id: control
    property int channel
    property bool checked

    implicitWidth: height*2
    implicitHeight: parent.height

    Rectangle {
        id:rect
        anchors.fill: parent
        radius: height*0.5
        color: control.checked ? buttonCheckedColor:buttonColor
        border.color: backgroundColor

        Rectangle {
            x: control.checked ? parent.width - parent.height : parent.height - height
            width: parent.height*0.8
            height: width
            radius: height*0.5
            color: buttonTextColor
            anchors.verticalCenter: parent.verticalCenter
            Text {
                anchors.centerIn: parent
                text: "✓"
                color: buttonCheckedColor
                font.pixelSize: parent.height*0.8
                opacity: checked ? 1:0
                Behavior on opacity {
                    NumberAnimation{
                        duration: 300
                    }
                }
            }
            Behavior on x {
                NumberAnimation{
                    easing.type: Easing.InOutCubic;
                    duration: 300}
            }
        }
        Behavior on color {
            ColorAnimation{
                duration: 300}
        }
    }
    checked: root.digital[control.channel]?root.digital[control.channel]:0
    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel? "D"+control.channel : ""
        color: buttonTextColor
        font.pixelSize: height*0.5
        anchors.right: parent.right
    }
    MouseArea{
        anchors.fill: parent
        onPressed: WS.push(control.channel)
        onReleased: WS.release(control.channel)
    }
}
