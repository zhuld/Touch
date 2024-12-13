import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

import "../Dialog"
import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

Item {
    id: control
    property int channel
    property int disEnableChannel: 0
    //property alias radius: back.radius
    property bool confirm: false
    property color btnColor: config.buttonColor

    property alias source: iconButton.icon.source
    property alias text: textLabel.text
    property alias checked: iconButton.checked

    implicitHeight: parent.height
    implicitWidth: parent.width

    enabled: root.digital[control.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6
    Material.accent: config.buttonTextColor

    visible: control.channel === 0 ? false : true

    Button {
        id: iconButton
        height: parent.height * 0.7
        width: height
        anchors.margins: 0
        anchors.horizontalCenter: parent.horizontalCenter
        icon.width: width * 0.5
        icon.height: height * 0.5
        icon.color: config.buttonTextColor
        checked: root.digital[control.channel] ? true : false
        background: Rectangle {
            id: back
            anchors.fill: parent
            //anchors.centerIn: parent
            radius: height / 2
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
                            position: 0
                            color: iconButton.checked ? Qt.darker(
                                                            config.buttonCheckedColor,
                                                            1.4) : Qt.darker(
                                                            btnColor, 1.4)
                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
                                }
                            }
                        }

                        GradientStop {
                            position: 1
                            color: iconButton.checked ? Qt.lighter(
                                                            config.buttonCheckedColor,
                                                            1.2) : Qt.lighter(
                                                            btnColor, 1.2)
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
                shadowVerticalOffset: iconButton.checked
                                      || iconButton.pressed ? height / 60 : height / 20
                Behavior on shadowHorizontalOffset {
                    NumberAnimation {
                        duration: 100
                    }
                }
            }
        }
        ConfirmDialog {
            id: confirmDialog
            dialogIcon: control.source
            dialogInfomation: "确定" + control.text + "？"
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
            if (checked) {
                y = height / 40
            } else {
                y = 0
            }
        }
        Behavior on y {
            NumberAnimation {
                duration: 100
            }
        }
    }
    Text {
        id: textLabel
        width: parent.width
        height: parent.height * 0.2
        font.pixelSize: height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.bottom: parent.bottom
        color: config.buttonTextColor
        font.family: alibabaPuHuiTi.font.family
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
}
