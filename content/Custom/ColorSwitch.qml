import QtQuick
import QtQuick.Controls

Switch {
    id: control
    implicitHeight: parent.height
    implicitWidth: parent.width

    indicator: Item {
        anchors.fill: parent
        Rectangle {
            width: parent.width * 0.7
            height: parent.height / 2
            radius: height / 2
            color: checked ? Global.buttonCheckedColor : Global.backgroundColor
            border.color: Global.buttonTextColor
            anchors.centerIn: parent
            Behavior on color {
                ColorAnimation {
                    duration: 300
                }
            }
        }

        Rectangle {
            x: checked ? parent.width - parent.height * 0.9 : parent.height * 0.1
            height: parent.height * 0.8
            width: height
            anchors.verticalCenter: parent.verticalCenter
            radius: height / 2
            color: Global.buttonColor
            border.color: Global.buttonTextColor
            Behavior on color {
                ColorAnimation {
                    duration: 300
                }
            }
            Text {
                anchors.centerIn: parent
                text: checked ? "✓" : ""
                color: Global.buttonCheckedColor
                font.pixelSize: parent.height * 0.8
                font.family: Global.alibabaPuHuiTi.font.family
            }
            Behavior on x {
                NumberAnimation {
                    duration: 300
                }
            }
        }
    }
}
