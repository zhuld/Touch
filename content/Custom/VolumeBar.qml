pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import QtQuick.Effects

import "../Js/crestroncip.js" as CrestronCIP

Item {
    id: controlVolumeBar
    implicitHeight: parent.height
    implicitWidth: parent.width

    property int miniVolume: -40
    property int maxVolume: 0

    property int muteChannel
    property int channel
    property int level
    property int disEnableChannel: 0

    property bool input: true

    property bool muteBtn: true

    enabled: Global.digital[controlVolumeBar.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6

    Slider {
        id: slider
        height: controlVolumeBar.height * 0.92
        width: height * 0.3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: controlVolumeBar.top
        anchors.topMargin: -handle.height / 4
        orientation: Qt.Vertical
        live: false
        value: Math.round(
                   Global.analog[controlVolumeBar.channel]
                   * (controlVolumeBar.maxVolume - controlVolumeBar.miniVolume)
                   / 65535 + controlVolumeBar.miniVolume)
        from: controlVolumeBar.miniVolume
        to: controlVolumeBar.maxVolume
        stepSize: 1

        snapMode: Slider.SnapAlways

        background: Shape {
            id: back
            height: parent.height - handle.height + width
            width: parent.width * 0.1
            y: handle.height / 2 - width / 2
            anchors.horizontalCenter: parent.horizontalCenter
            ShapePath {
                strokeWidth: 0
                strokeColor: "transparent"
                PathRectangle {
                    id: pathRect
                    x: 0
                    y: back.height - height
                    radius: width / 3
                    width: back.width
                    height: back.height
                }
                fillGradient: LinearGradient {
                    y1: pathRect.height
                    y2: 0
                    x1: pathRect.width / 2
                    x2: pathRect.width / 2
                    GradientStop {
                        position: 0.6
                        color: "green"
                    }
                    GradientStop {
                        position: 0.8
                        color: "orange"
                    }
                    GradientStop {
                        position: 1
                        color: "red"
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
                    radius: width / 3
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
            model: (controlVolumeBar.maxVolume - controlVolumeBar.miniVolume) / 5 + 1
            delegate: Item {
                id: item
                required property int index
                anchors.fill: parent
                Shape {

                    //刻度线左
                    //anchors.fill: parent
                    ShapePath {
                        strokeColor: (-item.index + controlVolumeBar.maxVolume)
                                     <= 0 ? Global.buttonTextColor : Global.buttonTextRedColor
                        strokeWidth: (Math.floor(
                                          item.index / 2) * 2 === item.index) ? 2 : 1
                        startX: (Math.floor(item.index / 2) * 2
                                 === item.index) ? slider.width * 0.25 : slider.width * 0.3
                        startY: slider.handle.height / 2 + (slider.height - slider.handle.height)
                                / (controlVolumeBar.maxVolume
                                   - controlVolumeBar.miniVolume) * 5 * item.index
                        PathLine {
                            x: slider.width * 0.4
                            y: slider.handle.height / 2 + (slider.height - slider.handle.height)
                               / (controlVolumeBar.maxVolume
                                  - controlVolumeBar.miniVolume) * 5 * item.index
                        }
                    }
                    //刻度线右
                    ShapePath {
                        strokeColor: (-item.index + controlVolumeBar.maxVolume)
                                     <= 0 ? Global.buttonTextColor : Global.buttonTextRedColor
                        strokeWidth: (Math.floor(
                                          item.index / 2) * 2 === item.index) ? 2 : 1
                        startX: slider.width * 0.6
                        startY: slider.handle.height / 2 + (slider.height - slider.handle.height)
                                / (controlVolumeBar.maxVolume
                                   - controlVolumeBar.miniVolume) * 5 * item.index
                        PathLine {
                            x: (Math.floor(item.index / 2) * 2
                                === item.index) ? slider.width * 0.8 : slider.width * 0.7
                            y: slider.handle.height / 2 + (slider.height - slider.handle.height)
                               / (controlVolumeBar.maxVolume
                                  - controlVolumeBar.miniVolume) * 5 * item.index
                        }
                    }
                }

                Text {
                    text: (Math.floor(item.index / 2) * 2
                           === item.index) ? -item.index * 5 + controlVolumeBar.maxVolume : ""
                    width: parent.width * 0.3
                    height: slider.handle.height
                    horizontalAlignment: Text.AlignRight
                    x: -width * 0.2
                    y: (slider.height - height) / (controlVolumeBar.maxVolume
                                                   - controlVolumeBar.miniVolume) * 5 * item.index
                    color: (-item.index + controlVolumeBar.maxVolume)
                           <= 0 ? Global.buttonTextColor : Global.buttonTextRedColor
                    font.pixelSize: height * 0.25
                    verticalAlignment: Text.AlignVCenter
                    font.family: Global.alibabaPuHuiTi.font.family
                }
            }
        }

        handle: Rectangle {
            id: handle
            width: parent.width * 0.3
            height: width * 2
            anchors.horizontalCenter: parent.horizontalCenter
            y: slider.visualPosition * (parent.height - height)
            Behavior on y {
                enabled: !slider.pressed
                NumberAnimation {
                    duration: Global.durationDelay
                }
            }
            //opacity: 0.8
            z: 1
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: controlVolumeBar.input ? "#07111B" : "#57111B"
                }
                GradientStop {
                    position: 0.1
                    color: controlVolumeBar.input ? "#5598CF" : "#A598CF"
                }
                GradientStop {
                    position: 0.2
                    color: controlVolumeBar.input ? "#182632" : "#682632"
                }
                GradientStop {
                    position: 0.48
                    color: controlVolumeBar.input ? "#2F4E69" : "#8F4E69"
                }
                GradientStop {
                    position: 0.50
                    color: controlVolumeBar.input ? "#A8C8E8" : "#A8C8E8"
                }
                GradientStop {
                    position: 0.52
                    color: controlVolumeBar.input ? "#385E7E" : "#885E7E"
                }
                GradientStop {
                    position: 0.9
                    color: controlVolumeBar.input ? "#3F6C94" : "#8F6C94"
                }
                GradientStop {
                    position: 1.0
                    color: controlVolumeBar.input ? "#07111B" : "#57111B"
                }
            }
            radius: width * 0.1
            layer.enabled: true
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: Global.buttonShadowColor
                shadowHorizontalOffset: slider.pressed ? Global.shadowHeight
                                                         / 2 : Global.shadowHeight
                shadowVerticalOffset: shadowHorizontalOffset * (1 - slider.position)
                Behavior on shadowHorizontalOffset {
                    NumberAnimation {
                        duration: Global.durationDelay
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
                CrestronCIP.level(controlVolumeBar.channel,
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
        channel: controlVolumeBar.muteChannel
        disEnableChannel: controlVolumeBar.disEnableChannel
        text: slider.value
        visible: controlVolumeBar.muteBtn
        anchors.bottom: parent.bottom
    }
    MyIconLabel {
        height: parent.height * 0.1
        width: parent.width
        text: slider.value
        color: Global.buttonTextColor
        visible: !controlVolumeBar.muteBtn
        anchors.bottom: parent.bottom
    }

    Text {
        id: channel
        height: parent.height
        text: Global.settings.showChannel ? "A" + controlVolumeBar.channel + "E"
                                            + controlVolumeBar.disEnableChannel : ""
        color: Global.buttonTextColor
        font.pixelSize: Global.channelSize
        font.family: Global.alibabaPuHuiTi.font.family
    }
}
