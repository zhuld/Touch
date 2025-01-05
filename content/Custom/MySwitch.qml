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
        width: parent.width * 0.7
        height: parent.height / 2
        radius: height / 2
        color: control.checked ? Global.buttonCheckedColor : Global.buttonColor
        border.color: Global.buttonTextColor
        anchors.centerIn: parent
        Behavior on color {
            ColorAnimation {
                duration: 300
            }
        }
    }
    Rectangle {
        x: control.checked ? parent.width - parent.height : parent.height - height
        width: parent.height * 0.8
        height: width
        radius: height * 0.5
        color: Global.backgroundColor
        border.color: Global.buttonTextColor
        anchors.verticalCenter: parent.verticalCenter
        Text {
            anchors.centerIn: parent
            text: checked ? "✓" : ""
            color: Global.buttonCheckedColor
            font.pixelSize: parent.height * 0.8
            font.family: Global.alibabaPuHuiTi.font.family
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
            shadowColor: Global.buttonShadowColor
            shadowHorizontalOffset: shadowHeight / 2
            shadowVerticalOffset: shadowHorizontalOffset
        }
    }
    checked: Global.digital[control.channel] ? Global.digital[control.channel] : 0
    Text {
        id: channel
        height: parent.height
        text: Global.settings.showChannel ? "D" + control.channel : ""
        color: Global.buttonTextColor
        font.pixelSize: channelSize
        anchors.right: parent.right
        font.family: Global.alibabaPuHuiTi.font.family
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
