import QtQuick
import QtQuick.Controls
import QtQuick.Effects

import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

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
            color: control.checked ? config.buttonCheckedColor : config.buttonColor
            border.color: config.buttonTextColor
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
            color: config.buttonTextColor
            anchors.verticalCenter: parent.verticalCenter
            Text {
                anchors.centerIn: parent
                text: "✓"
                color: config.buttonCheckedColor
                font.pixelSize: parent.height * 0.8
                opacity: checked ? 1 : 0
                font.family: alibabaPuHuiTi.font.family
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

            layer.enabled: true
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: config.buttonShadowColor
                shadowHorizontalOffset: height / 40
                shadowVerticalOffset: shadowHorizontalOffset
            }
        }
    }
    checked: root.digital[control.channel] ? root.digital[control.channel] : 0
    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel ? "D" + control.channel : ""
        color: config.buttonTextColor
        font.pixelSize: channelSize
        anchors.right: parent.right
        font.family: alibabaPuHuiTi.font.family
    }
    MouseArea {
        anchors.fill: parent
        onPressedChanged: {
            if (pressed) {
                CrestronCIP.push(control.channel)
            } else {
                CrestronCIP.release(control.channel)
            }
        }
    }
}
