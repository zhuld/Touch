import QtQuick
import QtQuick.Shapes
import QtQuick.Controls

Item {
    id: control
    property int channel
    property color btnColor: buttonCheckedColor
    property color textColor: buttonTextColor
    property bool checked
    property alias text: label.text
    property color lightColor: control.checked? "khaki" : "transparent"

    implicitWidth: parent.width
    implicitHeight: width

    Rectangle{
        width: parent.width
        height: parent.height*0.8
        color: "transparent"
        radius: width*0.1
    }

    Shape{
        id: light
        width: parent.width
        height: parent.height
        ShapePath {
            strokeColor: "transparent"
            fillGradient: RadialGradient {
                centerX: light.width/2; centerY: 0
                centerRadius: light.height
                focalX: centerX; focalY: centerY
                GradientStop { position: 0; color: control.lightColor }
                GradientStop { position: 0.8; color: "transparent" }
            }
            startX: light.width*0.45; startY: 0
            PathLine { x: light.width*0.55; y: 0 }
            PathLine { x: light.width; y: light.height*0.8 }
            PathLine { x: light.width; y: light.height }
            PathLine { x: 0; y: light.height }
            PathLine { x: 0; y: light.height*0.8 }
            PathLine { x: light.width*0.45; y: 0 }
        }
    }
    Behavior on lightColor {
        ColorAnimation{
            duration: 500
        }
    }
    Text {
        id: label
        text: qsTr("灯光")
        width: parent.width
        height: parent.height*0.2
        font.pixelSize: height*0.6
        color:textColor
        anchors.bottom: switchbtn.top
        horizontalAlignment: Text.AlignHCenter
    }
    MySwitch{
        id:switchbtn
        height: parent.height*0.2
        channel: control.channel
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: control.bottom
    }

    checked: root.digital[control.channel]?root.digital[control.channel]:0

    Text {
        id: channel
        height: switchbtn.height
        text: root.settings.showChannel? "D"+control.channel : ""
        color: textColor
        font.pixelSize: height
    }
}
