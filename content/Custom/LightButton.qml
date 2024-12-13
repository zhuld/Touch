import QtQuick
import QtQuick.Shapes
import QtQuick.Effects

import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

Item {
    id: control
    property int channel
    property alias text: label.text
    property color lightColor: "khaki"
    property bool checked
    property real initY
    property bool inited: false

    property int disEnableChannel: 0
    enabled: root.digital[control.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6
    Rectangle {
        id: rect
        anchors.fill: parent
        anchors.margins: height * 0.01
        gradient: Gradient {
            GradientStop {
                position: 0
                color: control.checked ? config.buttonCheckedColor : config.buttonColor
                Behavior on color {
                    ColorAnimation {
                        duration: 300
                    }
                }
            }
            GradientStop {
                position: 0.265
                color: control.checked ? config.buttonCheckedColor : config.buttonColor
                Behavior on color {
                    ColorAnimation {
                        duration: 300
                    }
                }
            }
            GradientStop {
                position: 0.27
                color: control.checked ? lightColor : Qt.darker(
                                             config.buttonColor, 1.1)
                Behavior on color {
                    ColorAnimation {
                        duration: 300
                    }
                }
            }
            GradientStop {
                position: 1
                color: control.checked ? Qt.alpha(lightColor, 0.2) : Qt.darker(
                                             config.buttonColor, 1.4)
                Behavior on color {
                    ColorAnimation {
                        duration: 300
                    }
                }
            }
        }
        radius: height / 10
        Text {
            id: label
            width: parent.width
            height: parent.height * 0.3
            font.pixelSize: height * 0.4
            anchors.top: parent.top
            anchors.topMargin: height * 0.2
            color: config.buttonTextColor
            horizontalAlignment: Text.AlignHCenter
            font.family: alibabaPuHuiTi.font.family
        }
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: config.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset / 2
            shadowVerticalOffset: control.checked ? height / 80 : height / 40
            Behavior on shadowHorizontalOffset {
                NumberAnimation {
                    duration: 100
                }
            }
        }
    }

    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel ? "D" + control.channel + "E"
                                          + control.disEnableChannel : ""
        color: config.buttonTextColor
        font.pixelSize: channelSize
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
    checked: root.digital[control.channel] ? root.digital[control.channel] : 0
    onCheckedChanged: {
        if (!inited) {
            initY = y
            inited = true
        }
        if (checked) {
            y = initY + height / 60
        } else {
            y = initY
        }
    }
    Behavior on y {
        NumberAnimation {
            duration: 100
        }
    }
}
