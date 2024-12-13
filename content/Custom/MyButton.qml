import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

import "../Dialog"
import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

Button {
    id: control
    property int channel
    property int disEnableChannel: 0
    property alias radius: back.radius
    property bool confirm: false
    property color btnColor: config.buttonColor
    property real initY
    property bool inited: false

    implicitHeight: parent.height
    implicitWidth: parent.width

    checked: root.digital[control.channel] ? true : false
    enabled: root.digital[control.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6

    icon.width: height * 0.5
    icon.height: height * 0.5
    icon.color: config.buttonTextColor
    font.pixelSize: height * 0.35
    font.family: alibabaPuHuiTi.font.family
    spacing: width * 0.05

    Material.accent: config.buttonTextColor
    Material.foreground: config.buttonTextColor

    background: Rectangle {
        id: back
        anchors.fill: parent
        radius: height / 4
        Shape {
            antialiasing: true
            anchors.fill: parent
            ShapePath {
                strokeWidth: 0
                strokeColor: "transparent"
                PathRectangle {
                    x: 0
                    y: 0
                    radius: back.radius
                    width: back.width
                    height: back.height
                }
                fillGradient: RadialGradient {
                    centerX: back.width * 0.5
                    centerY: back.height * 0.5
                    centerRadius: back.width
                    focalX: back.width * 0.25
                    focalY: back.height * 0.25
                    GradientStop {
                        position: 1
                        color: down | checked ? Qt.lighter(
                                                    config.buttonCheckedColor,
                                                    1.3) : Qt.lighter(btnColor,
                                                                      1.4)
                        Behavior on color {
                            ColorAnimation {
                                duration: 100
                            }
                        }
                    }
                    GradientStop {
                        position: 0
                        color: down | checked ? Qt.darker(
                                                    config.buttonCheckedColor,
                                                    1.3) : Qt.darker(btnColor,
                                                                     1.2)
                        Behavior on color {
                            ColorAnimation {
                                duration: 100
                            }
                        }
                    }
                }
            }
        }
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: config.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset / 2
            shadowVerticalOffset: checked || pressed ? height / 60 : height / 30
            Behavior on shadowHorizontalOffset {
                NumberAnimation {
                    duration: 100
                }
            }
        }
    }

    ConfirmDialog {
        id: confirmDialog
        dialogIcon: icon.source
        dialogInfomation: "确定" + text + "？"
        dialogTitle: "提示"
        Timer {
            id: releaseTimer
            interval: 100
            repeat: false
            triggeredOnStart: false
            onTriggered: {
                confirmDialog.close()
                CrestronCIP.release(control.channel)
            }
        }
        onOkPress: {
            CrestronCIP.push(control.channel)
            releaseTimer.start()
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

    onPressedChanged: {
        if (pressed) {
            if (!confirm) {
                CrestronCIP.push(control.channel)
            } else {
                confirmDialog.open()
            }
        } else {
            if (!confirm) {
                CrestronCIP.release(control.channel)
            }
        }
    }

    onCheckedChanged: {
        if (!inited) {
            initY = y
            inited = true
        }
        if (checked) {
            y = initY + height / 40
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
