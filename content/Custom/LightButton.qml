import QtQuick
import QtQuick.Shapes

import "qrc:/qt/qml/content/ws.js" as WS

Item {
    id: control
    property int channel
    property alias text: label.text
    property color lightColor: "khaki"
    property bool checked

    Rectangle{
        anchors.fill: parent
        anchors.margins: height*0.01
        gradient: Gradient {
            GradientStop {
                position: 1.0; color: control.checked? buttonCheckedColor :buttonColor
                Behavior on color{
                    ColorAnimation {
                        duration: 300
                    }
                }
            }
            GradientStop {
                position: 0.4; color: control.checked? lightColor :buttonColor
                Behavior on color{
                    ColorAnimation {
                        duration: 300
                    }
                }
            }
            GradientStop {
                position: 0.0; color: control.checked? lightColor :buttonColor
                Behavior on color{
                    ColorAnimation {
                        duration: 300
                    }
                }
            }
        }
        radius: width*0.1
        Text {
            id: label
            width: parent.width
            height: parent.height*0.2
            font.pixelSize: height*0.5
            anchors.bottom: parent.bottom
            color:buttonTextColor
            horizontalAlignment: Text.AlignHCenter
        }
    }
    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel? "D"+control.channel : ""
        color: buttonTextColor
        font.pixelSize: height*0.1
        anchors.left: parent.left
    }
    MouseArea{
        anchors.fill: parent
        onPressed: WS.push(control.channel)
        onReleased: WS.release(control.channel)
    }
    checked: root.digital[control.channel]?root.digital[control.channel]:0
}
