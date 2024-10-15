import QtQuick
import QtQuick.Controls
import QtQuick.Effects

//import "qrc:/qt/qml/content/ws.js" as WS
import "qrc:/qt/qml/content/crestroncip.js" as CrestronCIP

Item {
    id: control
    property int channel
    property bool checked

    implicitWidth: height * 2
    implicitHeight: parent.height

    Rectangle {
        id: backRect
        anchors.fill: parent
        color: "transparent"
        Rectangle {
            width: parent.width * 0.7
            height: parent.height / 2
            radius: height / 2
            color: control.checked ? buttonCheckedColor : buttonColor
            border.color: buttonTextColor
            anchors.centerIn: parent
            Behavior on color {
                ColorAnimation {
                    duration: 300
                }
            }
        }
        Rectangle {
            id: rect
            x: control.checked ? parent.width - parent.height : parent.height - height
            width: parent.height * 0.8
            height: width
            radius: height * 0.5
            color: buttonTextColor
            anchors.verticalCenter: parent.verticalCenter
            Text {
                anchors.centerIn: parent
                text: "✓"
                color: buttonCheckedColor
                font.pixelSize: parent.height * 0.8
                opacity: checked ? 1 : 0
                Behavior on opacity {
                    NumberAnimation {
                        duration: 300
                    }
                }
            }
            Behavior on x {
                NumberAnimation {
                    easing.type: Easing.InOutCubic
                    duration: 300
                }
            }
        }
        MultiEffect {
            source: rect
            anchors.fill: rect
            shadowEnabled: true
            shadowColor: Qt.alpha(rect.color, 0.8)
            shadowHorizontalOffset: rect.height / 10
            shadowVerticalOffset: shadowHorizontalOffset
        }
    }
    checked: root.digital[control.channel] ? root.digital[control.channel] : 0
    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel ? "D" + control.channel : ""
        color: buttonTextColor
        font.pixelSize: height * 0.5
        anchors.right: parent.right
    }
    MouseArea {
        anchors.fill: parent
        onPressed: cipClient.sendData(CrestronCIP.push(control.channel))
        onReleased: cipClient.sendData(CrestronCIP.release(control.channel))
    }
}
