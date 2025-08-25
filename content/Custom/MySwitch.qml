pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import QtQuick.Templates as T

import "../Js/crestroncip.js" as CrestronCIP

T.Button {
    id: controlMySwitch
    property int channel

    implicitHeight: parent.height
    implicitWidth: parent.width * 2

    checked: Global.digital[controlMySwitch.channel] ? true : false

    indicator: Rectangle {
        width: height * 2
        height: parent.height * 0.5
        radius: height * 0.5
        color: controlMySwitch.checked ? Global.buttonCheckedColor : Global.buttonColor
        border.color: Global.buttonTextColor
        x: height / 2
        anchors.verticalCenter: parent.verticalCenter
        Behavior on color {
            ColorAnimation {
                duration: Global.durationDelay
            }
        }
        Rectangle {
            x: controlMySwitch.checked ? parent.width - parent.height : parent.height - height
            width: parent.height * 1.6
            height: width
            radius: height * 0.5
            color: Global.backgroundColor
            border.color: Global.buttonTextColor
            anchors.verticalCenter: parent.verticalCenter
            Text {
                anchors.centerIn: parent
                text: "✓"
                opacity: controlMySwitch.checked ? 1 : 0
                color: Global.buttonCheckedColor
                font.pixelSize: parent.height * 0.8
                font.family: Global.alibabaPuHuiTi.font.family
                Behavior on opacity {
                    NumberAnimation {
                        easing.type: Easing.InOutQuad
                        duration: Global.durationDelay
                    }
                }
            }
            Behavior on x {
                NumberAnimation {
                    easing.type: Easing.InOutCubic
                    duration: Global.durationDelay
                }
            }
            layer.enabled: true
            layer.samples: 16
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: Global.buttonShadowColor
                shadowHorizontalOffset: Global.shadowHeight / 2
                shadowVerticalOffset: shadowHorizontalOffset
            }
        }
    }
    contentItem: Text {
        height: parent.height
        text: controlMySwitch.text
        font.pixelSize: height * 0.7
        anchors.left: controlMySwitch.indicator.right
        leftPadding: height * 0.5
        color: Global.buttonTextColor
        font.family: Global.alibabaPuHuiTi.font.family
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: channel
        height: parent.height
        text: Global.settings.showChannel ? "D" + controlMySwitch.channel : ""
        color: Global.buttonTextColor
        font.pixelSize: Global.channelSize
        anchors.right: parent.right
        font.family: Global.alibabaPuHuiTi.font.family
    }

    onPressedChanged: {
        if (pressed) {
            //if (!checked) {
            CrestronCIP.push(controlMySwitch.channel)
        } else {
            CrestronCIP.release(controlMySwitch.channel)
            //}
        }
    }
}
