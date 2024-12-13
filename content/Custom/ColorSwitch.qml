import QtQuick
import QtQuick.Controls

Switch {
    id: control
    implicitHeight: parent.height
    implicitWidth: parent.width

    indicator: Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: "transparent"
        Rectangle {
            width: parent.width * 0.7
            height: parent.height / 2
            radius: height / 2
            color: checked ? config.buttonCheckedColor : config.buttonColor
            border.color: config.buttonTextColor
            anchors.centerIn: parent
            Behavior on color {
                ColorAnimation {
                    duration: 300
                }
            }
        }

        Rectangle {
            x: parent.parent.checked ? parent.width - parent.height * 0.9 : parent.height * 0.1
            width: height
            height: parent.height * 0.8
            y: parent.height * 0.1
            radius: height / 2
            color: config.buttonTextColor
            border.color: config.buttonColor
            Behavior on color {
                ColorAnimation {
                    duration: 300
                }
            }

            Text {
                anchors.centerIn: parent
                text: checked ? "✓" : ""
                color: config.buttonCheckedColor
                font.pixelSize: parent.height * 0.8
                font.family: alibabaPuHuiTi.font.family
            }
            Behavior on x {
                NumberAnimation {
                    duration: 300
                }
            }
        }
    }
}
