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

    property alias source: _icon.icon.source
    property alias text: textLabel.text
    property bool checked: root.digital[control.channel] ? true : false

    implicitHeight: parent.height
    implicitWidth: parent.width

    enabled: root.digital[control.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6
    Material.accent: config.buttonTextColor

    visible: control.channel === 0 ? false : true

    Shape {
        id: back
        property int channel: control.channel
        height: parent.height * 0.7
        width: height
        y: control.checked ? height / 40 : 0
        anchors.horizontalCenter: parent.horizontalCenter
        Behavior on y {
            NumberAnimation {
                duration: 100
            }
        }
        IconButton {
            id: _icon
            height: parent.height
            width: height
            icon.height: height / 2
            icon.width: width / 2
            icon.source: "qrc:/content/icons/up.png"
        }
        containsMode: Shape.FillContains
        layer.enabled: true
        layer.samples: 16
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: config.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset
            shadowVerticalOffset: control.checked ? shadowHeight / 2 : shadowHeight
            Behavior on shadowHorizontalOffset {
                NumberAnimation {
                    duration: 100
                }
            }
        }
        ShapePath {
            strokeWidth: 0
            strokeColor: "transparent"
            PathRectangle {
                x: 0
                y: 0
                radius: back.width / 2
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
                    color: control.checked ? Qt.darker(
                                                 config.buttonCheckedColor,
                                                 1.4) : Qt.darker(btnColor, 1.4)
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
                GradientStop {
                    position: 1
                    color: control.checked ? Qt.lighter(
                                                 config.buttonCheckedColor,
                                                 1.2) : Qt.lighter(btnColor,
                                                                   1.2)
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
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
}