import QtQuick
import QtQuick.Shapes
import QtQuick.Effects

import "qrc:/qt/qml/content/crestroncip.js" as CrestronCIP

Item {
    id: control
    property int channel
    property alias text: label.text
    property color lightColor: "khaki"
    property bool checked

    Rectangle {
        id: rect
        anchors.fill: parent
        anchors.margins: height * 0.01
        gradient: Gradient {
            GradientStop {
                position: 1.0
                color: control.checked ? buttonCheckedColor : buttonColor
                Behavior on color {
                    ColorAnimation {
                        duration: 300
                    }
                }
            }
            GradientStop {
                position: 0.74
                color: control.checked ? buttonCheckedColor : buttonColor
                Behavior on color {
                    ColorAnimation {
                        duration: 300
                    }
                }
            }
            GradientStop {
                position: 0.73
                color: control.checked ? lightColor : buttonColor
                Behavior on color {
                    ColorAnimation {
                        duration: 300
                    }
                }
            }
            GradientStop {
                position: 0
                color: control.checked ? Qt.alpha(lightColor, 0.2) : buttonColor
                Behavior on color {
                    ColorAnimation {
                        duration: 300
                    }
                }
            }
        }
        radius: width * 0.1
        Text {
            id: label
            width: parent.width
            height: parent.height * 0.2
            font.pixelSize: height * 0.5
            anchors.bottom: parent.bottom
            color: buttonTextColor
            horizontalAlignment: Text.AlignHCenter
        }
    }
    MultiEffect {
        source: rect
        anchors.fill: rect
        shadowEnabled: true
        shadowColor: Qt.alpha(buttonCheckedColor, 0.8)
        shadowHorizontalOffset: rect.height / 100
        shadowVerticalOffset: shadowHorizontalOffset
    }
    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel ? "D" + control.channel : ""
        color: buttonTextColor
        font.pixelSize: height * 0.1
        anchors.left: parent.left
    }
    MouseArea {
        anchors.fill: parent
        onPressed: tcpClient.sendData(CrestronCIP.push(control.channel))
        onReleased: tcpClient.sendData(CrestronCIP.release(control.channel))
    }
    checked: root.digital[control.channel] ? root.digital[control.channel] : 0
}
