import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import QtQuick.Effects

import "qrc:/qt/qml/content/crestroncip.js" as CrestronCIP

Item {
    id: control
    implicitHeight: parent.height
    implicitWidth: parent.width

    property int miniVolume: -40
    property int maxVolume: 0

    property int muteChannel
    property int channel
    property int volume: 0

    property bool input: true

    Slider {
        id: slider
        height: parent.height * 0.92
        width: height * 0.25
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: -handle.height / 4
        orientation: Qt.Vertical

        stepSize: 1 / (maxVolume - miniVolume)
        snapMode: Slider.SnapAlways

        WheelHandler {
            property: "value"
            rotationScale: -1 / 1000
        }

        handle: Rectangle {
            id: handle
            width: parent.width * 0.3
            height: parent.width * 0.6
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.visualPosition * (parent.availableHeight - height)
            z: 1
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: input ? "#07111B" : "#57111B"
                }
                GradientStop {
                    position: 0.1
                    color: input ? "#5598CF" : "#A598CF"
                }
                GradientStop {
                    position: 0.2
                    color: input ? "#182632" : "#682632"
                }
                GradientStop {
                    position: 0.49
                    color: input ? "#2F4E69" : "#8F4E69"
                }
                GradientStop {
                    position: 0.50
                    color: input ? "#A8C8E8" : "#A8C8E8"
                }
                GradientStop {
                    position: 0.51
                    color: input ? "#385E7E" : "#885E7E"
                }
                GradientStop {
                    position: 0.9
                    color: input ? "#3F6C94" : "#8F6C94"
                }
                GradientStop {
                    position: 1.0
                    color: input ? "#07111B" : "#57111B"
                }
            }
            radius: width * 0.2
            Behavior on y {
                enabled: !slider.pressed
                NumberAnimation {
                    easing.type: Easing.OutCubic
                    duration: 300
                }
            }
            opacity: parent.pressed ? 0.6 : 1
            Behavior on opacity {
                NumberAnimation {
                    duration: 300
                }
            }
        }

        MultiEffect {
            source: handle
            anchors.fill: handle
            shadowEnabled: true
            shadowColor: Qt.alpha(buttonCheckedColor, 0.8)
            shadowHorizontalOffset: handle.height / 10
            shadowVerticalOffset: shadowHorizontalOffset * volume / (maxVolume - miniVolume)
        }
        background: Rectangle {
            height: parent.availableHeight - handle.height + width
            width: parent.width * 0.12
            y: handle.height / 2 - width / 2
            anchors.horizontalCenter: parent.horizontalCenter
            radius: width / 2
            gradient: Gradient {
                orientation: Qt.Horizontal
                GradientStop {
                    position: 0
                    color: Qt.darker(backgroundColor, 1.2)
                }
                GradientStop {
                    position: 0.2
                    color: backgroundColor
                }
                GradientStop {
                    position: 1
                    color: backgroundColor
                }
            }
            opacity: 0.9
            Rectangle {
                height: parent.height - parent.width
                width: parent.width * 0.7
                anchors.centerIn: parent
                radius: width / 2
                gradient: Gradient {
                    GradientStop {
                        position: 1
                        color: buttonColor
                    }
                    GradientStop {
                        position: (maxVolume + 5) > 0 ? (maxVolume + 5)
                                                        / (maxVolume - miniVolume) : 0
                        color: buttonCheckedColor
                    }
                    GradientStop {
                        position: 0
                        color: (maxVolume + 5) > 0 ? "red" : buttonCheckedColor
                    }
                }
                Rectangle {
                    height: slider.visualPosition * parent.height
                    width: parent.width
                    color: backgroundColor
                }
            }
        }

        onMoved: {
            volume = Math.round(
                        ((1 - visualPosition) * (maxVolume - miniVolume)))
            cipClient.sendData(CrestronCIP.level(control.channel, volume))
            //WS.level(control.channel, volume)
        }

        onValueChanged: {
            volume = Math.round(
                        ((1 - visualPosition) * (maxVolume - miniVolume)))
            //WS.level(control.channel, volume)
            cipClient.sendData(CrestronCIP.level(control.channel, volume))
        }

        Repeater {
            id: repeater
            model: (maxVolume - miniVolume) + 1
            Item {
                anchors.fill: parent
                Shape {
                    //刻度线左
                    anchors.fill: parent
                    ShapePath {
                        strokeColor: (-index + maxVolume) <= 0 ? volumeBlueColor : volumeRedColor
                        strokeWidth: (Math.floor(
                                          index / 5) * 5 === index) ? 2 : 1
                        startX: (Math.floor(index / 5) * 5
                                 === index) ? parent.width * 0.2 : parent.width * 0.3
                        startY: parent.handle.height / 2
                                + (parent.availableHeight - parent.handle.height)
                                / (maxVolume - miniVolume) * index
                        PathLine {
                            x: parent.width * 0.4
                            y: parent.handle.height / 2
                               + (parent.availableHeight - parent.handle.height)
                               / (maxVolume - miniVolume) * index
                        }
                    }
                }
                Shape {
                    //刻度线右
                    anchors.fill: parent
                    ShapePath {
                        strokeColor: (-index + maxVolume) <= 0 ? volumeBlueColor : volumeRedColor
                        strokeWidth: (Math.floor(
                                          index / 5) * 5 === index) ? 2 : 1
                        startX: parent.width * 0.6
                        startY: parent.handle.height / 2
                                + (parent.availableHeight - parent.handle.height)
                                / (maxVolume - miniVolume) * index
                        PathLine {
                            x: (Math.floor(index / 5) * 5
                                === index) ? parent.width * 0.9 : parent.width * 0.7
                            y: parent.handle.height / 2
                               + (parent.availableHeight - parent.handle.height)
                               / (maxVolume - miniVolume) * index
                        }
                    }
                }
                Text {
                    text: (Math.floor(
                               index / 5) * 5 === index) ? -index + maxVolume : ""
                    width: parent.parent.width * 0.3
                    height: parent.parent.handle.height
                    horizontalAlignment: Text.AlignRight
                    x: -parent.width * 0.15
                    y: (parent.parent.availableHeight - parent.parent.handle.height)
                       / (maxVolume - miniVolume) * index
                    color: (-index + maxVolume) <= 0 ? volumeBlueColor : volumeRedColor
                    font.pixelSize: height * 0.3
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
    MyButton {
        id: mute
        height: parent.height * 0.1
        width: slider.width
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        icon.source: root.digital[control.muteChannel] ? "qrc:/content/icons/mute.png" : "qrc:/content/icons/unmute.png"
        icon.color: root.digital[control.muteChannel] ? volumeRedColor : buttonTextColor
        textColor: root.digital[control.muteChannel] ? volumeRedColor : buttonTextColor
        channel: muteChannel
        text: root.digital[control.muteChannel] ? "静音" : root.analog[control.channel] ? root.analog[control.channel] + miniVolume : miniVolume
    }
    Text {
        id: channel
        height: parent.height * 0.2
        text: root.settings.showChannel ? "A" + control.channel : ""
        color: buttonTextColor
        font.pixelSize: height * 0.3
    }
    Component.onCompleted: slider.value = ((root.analog[control.channel])
                                           / (maxVolume - miniVolume))
}
