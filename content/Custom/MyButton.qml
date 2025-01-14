import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes
import QtMultimedia
import QtQuick.Templates as T
import "../Dialog"
import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

T.Button {
    id: control
    property int channel
    property int disEnableChannel: 0
    property bool confirm: false
    property color btnColor: Global.buttonColor

    property real radius: control.height / 5
    property string source
    property color textColor: checked ? Global.backgroundColor : Global.buttonTextColor
    property color iconColor: checked ? Global.backgroundColor : Global.buttonTextColor

    checked: Global.digital[control.channel] ? true : false

    implicitHeight: parent.height
    implicitWidth: parent.width

    enabled: Global.digital[control.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6
    Behavior on opacity {
        OpacityAnimator {
            duration: Global.durationDelay
        }
    }
    Material.accent: Global.buttonTextColor

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
    contentItem: MyIconLabel {
        anchors.fill: back
        color: control.textColor
        icon.color: control.iconColor
        icon.source: control.source
        text: control.text
    }
    background: Shape {
        id: back
        height: parent.height
        width: parent.width
        y: control.checked ? height / 40 : 0
        Behavior on y {
            NumberAnimation {
                duration: Global.durationDelay
            }
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
                    duration: Global.durationDelay
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
                radius: control.radius
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
                            duration: Global.durationDelay
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
                            duration: Global.durationDelay
                        }
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
