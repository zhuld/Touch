import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import QtQuick.Effects

import "../"
import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

Item {
    id: control
    implicitHeight: parent.height
    implicitWidth: parent.width

    property int miniVolume: -40
    property int maxVolume: 0

    property int muteChannel
    property int channel
    property int disEnableChannel: 0

    property bool input: true

    property bool muteBtn: true

    enabled: Global.digital[control.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6

    Slider {
        id: slider
        height: parent.height * 0.92
        width: height * 0.3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: -handle.height / 4
        orientation: Qt.Vertical
        live: false
        value: Math.round(
                   Global.analog[control.channel] * (maxVolume - miniVolume) / 65535 + miniVolume)
        from: miniVolume
        to: maxVolume
        stepSize: 1

        snapMode: Slider.SnapAlways

        background: Shape {
            id: back
            height: parent.availableHeight - handle.height + width
            width: parent.width * 0.05
            y: handle.height / 2 - width / 2
            anchors.horizontalCenter: parent.horizontalCenter
            ShapePath {
                strokeWidth: 0
                strokeColor: "transparent"
                PathRectangle {
                    id: pathRect
                    x: 0
                    y: 0
                    radius: back.width / 2
                    width: back.width
                    height: back.height
                }
                fillGradient: LinearGradient {
                    y1: pathRectangle.height / 2
                    y2: pathRectangle.height / 2
                    x1: 0
                    x2: pathRectangle.width
                    // GradientStop {
                    //     position: 1
                    //     color: Global.buttonCheckedColor
                    // }
                    // GradientStop {
                    //     position: (maxVolume + 5) > 0 ? (maxVolume + 5)
                    //                                     / (maxVolume - miniVolume) : 0
                    //     color: Global.buttonCheckedColor
                    // }
                    // GradientStop {
                    //     position: 0
                    //     color: (maxVolume + 5) > 0 ? "red" : buttonCheckedColor
                    // }
                    GradientStop {
                        position: 0
                        color: Qt.darker(Global.buttonCheckedColor, 1.4)
                    }
                    GradientStop {
                        position: 1
                        color: Global.buttonCheckedColor
                    }
                }
            }
            ShapePath {
                strokeWidth: 0
                strokeColor: "transparent"
                PathRectangle {
                    id: pathRectangle
                    x: 0
                    y: 0
                    radius: back.width / 2
                    width: back.width
                    height: slider.visualPosition * back.height
                }
                fillGradient: LinearGradient {
                    y1: pathRectangle.height / 2
                    y2: pathRectangle.height / 2
                    x1: 0
                    x2: pathRectangle.width
                    GradientStop {
                        position: 0
                        color: Qt.darker(Global.buttonColor, 1.4)
                    }
                    GradientStop {
                        position: 1
                        color: Global.buttonColor
                    }
                }
            }
        }

        Repeater {
            model: (maxVolume - miniVolume) + 1
            Item {
                anchors.fill: parent
                Shape {
                    //刻度线左
                    anchors.fill: parent

                    ShapePath {
                        strokeColor: (-index + maxVolume)
                                     <= 0 ? Global.buttonTextColor : Global.buttonTextRedColor
                        strokeWidth: (Math.floor(
                                          index / 5) * 5 === index) ? 2 : 1
                        startX: (Math.floor(index / 5) * 5
                                 === index) ? parent.width * 0.25 : parent.width * 0.3
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
                    //刻度线右
                    ShapePath {
                        strokeColor: (-index + maxVolume)
                                     <= 0 ? Global.buttonTextColor : Global.buttonTextRedColor
                        strokeWidth: (Math.floor(
                                          index / 5) * 5 === index) ? 2 : 1
                        startX: width * 0.6
                        startY: parent.handle.height / 2
                                + (parent.availableHeight - parent.handle.height)
                                / (maxVolume - miniVolume) * index
                        PathLine {
                            x: (Math.floor(
                                    index / 5) * 5 === index) ? width * 0.8 : width * 0.7
                            y: parent.handle.height / 2
                               + (parent.availableHeight - parent.handle.height)
                               / (maxVolume - miniVolume) * index
                        }
                    }
                }

                Text {
                    text: (Math.floor(
                               index / 5) * 5 === index) ? -index + maxVolume : ""
                    width: parent.width * 0.3
                    height: parent.parent.handle.height
                    horizontalAlignment: Text.AlignRight
                    x: -width * 0.3
                    y: (parent.parent.availableHeight - height) / (maxVolume - miniVolume) * index
                    color: (-index + maxVolume)
                           <= 0 ? Global.buttonTextColor : Global.buttonTextRedColor
                    font.pixelSize: height * 0.2
                    verticalAlignment: Text.AlignVCenter
                    font.family: Global.alibabaPuHuiTi.font.family
                }
            }
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
                    position: 0.48
                    color: input ? "#2F4E69" : "#8F4E69"
                }
                GradientStop {
                    position: 0.50
                    color: input ? "#A8C8E8" : "#A8C8E8"
                }
                GradientStop {
                    position: 0.52
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
            radius: width * 0.1
            layer.enabled: true
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: Global.buttonShadowColor
                shadowHorizontalOffset: parent.pressed ? shadowHeight / 2 : shadowHeight
                shadowVerticalOffset: shadowHorizontalOffset * (1 - slider.position)
                Behavior on shadowHorizontalOffset {
                    NumberAnimation {
                        duration: 100
                    }
                }
            }
        }

        onMoved: {
            moveTimer.restart()
        }
        //用于检测滑块停止滑动
        Timer {
            id: moveTimer
            interval: 200 // 毫秒
            repeat: false
            onTriggered: {
                CrestronCIP.level(control.channel,
                                  Math.round(slider.position * 65535))
            }
        }
    }

    MyButton {
        height: parent.height * 0.1
        width: parent.width * 0.9
        anchors.horizontalCenter: parent.horizontalCenter
        source: checked ? "qrc:/content/icons/mute.png" : "qrc:/content/icons/unmute.png"
        iconColor: checked ? Global.buttonTextRedColor : Global.buttonTextColor
        channel: muteChannel
        disEnableChannel: control.disEnableChannel
        text: slider.value
        visible: control.muteBtn
        anchors.bottom: parent.bottom
    }
    MyIconLabel {
        height: parent.height * 0.1
        width: parent.width
        text: slider.value
        color: Global.buttonTextColor
        visible: !control.muteBtn
        anchors.bottom: parent.bottom
    }

    Text {
        id: channel
        height: parent.height
        text: Global.settings.showChannel ? "A" + control.channel + "E"
                                            + control.disEnableChannel : ""
        color: Global.buttonTextColor
        font.pixelSize: channelSize
        font.family: Global.alibabaPuHuiTi.font.family
    }
}
