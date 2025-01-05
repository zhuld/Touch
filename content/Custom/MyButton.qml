import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes
import QtMultimedia

import "../Dialog"
import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

Item {
    id: control
    property int channel
    property int disEnableChannel: 0
    property alias radius: pathRect.radius
    property bool confirm: false
    property color btnColor: Global.buttonColor

    property alias source: _icon.icon.source
    property alias iconColor: _icon.icon.color
    property alias text: _icon.text
    property bool checked: Global.digital[control.channel] ? true : false

    implicitHeight: parent.height
    implicitWidth: parent.width

    enabled: Global.digital[control.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6
    Material.accent: Global.buttonTextColor

    Shape {
        id: back
        property int channel: control.channel
        height: parent.height
        width: parent.width
        y: control.checked ? height / 40 : 0
        anchors.horizontalCenter: parent.horizontalCenter
        Behavior on y {
            NumberAnimation {
                duration: 100
            }
        }
        MyIconLabel {
            id: _icon
            height: parent.height
            width: parent.width
            color: control.checked ? Global.backgroundColor : Global.buttonTextColor
            icon.color: control.checked ? Global.backgroundColor : Global.buttonTextColor
        }

        containsMode: Shape.FillContains
        layer.enabled: true
        layer.samples: 16
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: Global.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset
            shadowVerticalOffset: control.enabled ? (control.checked ? shadowHeight / 2 : shadowHeight) : shadowHeight / 4
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
                id: pathRect
                x: 0
                y: 0
                radius: back.height / 5
                width: back.width
                height: back.height
            }
            fillGradient: RadialGradient {
                centerX: back.width * 0.5
                centerY: back.height * 0.5
                centerRadius: back.width
                focalX: 0
                focalY: 0
                GradientStop {
                    position: 0
                    color: control.checked ? Qt.darker(
                                                 Global.buttonCheckedColor,
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
                                                 Global.buttonCheckedColor,
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
                    //playSound.play()
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
        onConfirm: {
            CrestronCIP.push(control.channel)
            releaseTimer.start()
        }
    }
    Text {
        id: channel
        height: parent.height
        text: Global.settings.showChannel ? "D" + control.channel + "E"
                                            + control.disEnableChannel : ""
        color: Global.buttonTextColor
        font.pixelSize: channelSize
        font.family: Global.alibabaPuHuiTi.font.family
    }
    SoundEffect {
        id: playSound
        source: "qrc:/content/sound/click.wav"
    }
}
