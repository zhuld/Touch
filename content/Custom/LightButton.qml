import QtQuick
import QtQuick.Shapes
import QtQuick.Effects

import "qrc:/qt/qml/content/js/crestroncip.js" as CrestronCIP

Item {
    id: control
    property int channel
    property alias text: label.text
    property color lightColor: "khaki"
    property bool checked

    property int disEnableChannel: 0
    enabled: root.digital[control.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6
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
                position: 0.735
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
            font.family: alibabaPuHuiTi.font.family
        }
    }
    MultiEffect {
        source: rect
        anchors.fill: rect
        shadowEnabled: true
        shadowColor: buttonShadowColor
        shadowHorizontalOffset: rect.height / 100
        shadowVerticalOffset: shadowHorizontalOffset
    }
    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel ? "D" + control.channel : ""
        color: buttonTextColor
        font.pixelSize: height * 0.1
        font.family: alibabaPuHuiTi.font.family
    }
    Text {
        id: disEnableChannel
        height: parent.height
        text: root.settings.showChannel ? "E" + control.disEnableChannel : ""
        color: buttonTextColor
        font.pixelSize: height * 0.1
        anchors.right: parent.right
        font.family: alibabaPuHuiTi.font.family
    }
    MouseArea {
        anchors.fill: parent
        onPressed: CrestronCIP.push(control.channel)
        onReleased: CrestronCIP.release(control.channel)
    }
    checked: root.digital[control.channel] ? root.digital[control.channel] : 0
}
