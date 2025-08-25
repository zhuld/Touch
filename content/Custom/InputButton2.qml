pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import "../Js/crestroncip.js" as CrestronCIP

Item {
    id: controlInputButton2
    property int input
    property int channel
    property color btnColor: Global.buttonCheckedColor
    property color btnTextColor: Global.buttonTextColor
    property string textInput
    property string iconSource

    property real dragX
    property real dragY

    width: parent.width
    height: parent.height
    z: mouseArea.pressed ? 1 : 0

    signal pressedChanged(bool pressed)
    ParallelAnimation {
        id: dragButtonAnimation
        NumberAnimation {
            target: back
            property: "x"
            duration: Global.durationDelay * 3
            to: controlInputButton2.dragX
            easing.type: Easing.OutBack
        }
        NumberAnimation {
            target: back
            property: "y"
            duration: Global.durationDelay * 3
            to: controlInputButton2.dragY
            easing.type: Easing.OutBack
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag.target: back
        onPressedChanged: {
            controlInputButton2.pressedChanged(mouseArea.pressed)
            if (pressed) {
                back.Drag.hotSpot.x = back.height / 2
                back.Drag.hotSpot.y = mouseY
                controlInputButton2.dragX = back.x
                controlInputButton2.dragY = back.y
                back.x = mouseX - back.height / 2
                CrestronCIP.push(controlInputButton2.channel)
            } else {
                back.Drag.drop()
                //back.x = 0
                dragButtonAnimation.start()
                CrestronCIP.release(controlInputButton2.channel)
            }
        }
    }

    Shape {
        id: back2
        width: parent.width
        height: parent.height
        opacity: 0.5
        ShapePath {
            strokeWidth: 0
            strokeColor: "transparent"
            PathRectangle {
                x: 0
                y: 0
                width: back2.width
                height: back2.height
                radius: height / 5
            }
            fillGradient: RadialGradient {
                centerX: back2.width * 0.5
                centerY: back2.height * 0.5
                centerRadius: back2.width
                focalX: 0
                focalY: 0
                GradientStop {
                    position: 1
                    color: controlInputButton2.btnColor
                }
            }
        }
        MyIconLabel {
            font.pixelSize: height * 0.25
            height: parent.height
            width: parent.width
            text: controlInputButton2.textInput
            icon.source: controlInputButton2.iconSource
        }
        layer.enabled: true
        layer.effect: MultiEffect {
            id: effect2
            shadowEnabled: true
            shadowColor: Global.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset / 2
            shadowVerticalOffset: mouseArea.pressed ? Global.shadowHeight / 2 : Global.shadowHeight
            Behavior on shadowHorizontalOffset {
                NumberAnimation {
                    duration: Global.durationDelay
                }
            }
        }
        Text {
            width: parent.width
            height: parent.height
            text: controlInputButton2.input
            font.pixelSize: height
            color: controlInputButton2.btnTextColor
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignTop
            font.bold: true
            opacity: 0.1
            font.family: Global.alibabaPuHuiTi.font.family
        }
    }

    Shape {
        id: back
        width: mouseArea.pressed ? height : parent.width
        height: parent.height
        Text {
            id: channel
            height: parent.height
            text: Global.settings.showChannel ? "D" + controlInputButton2.channel : ""
            color: Global.buttonTextColor
            font.pixelSize: Global.channelSize
            font.family: Global.alibabaPuHuiTi.font.family
        }
        ShapePath {
            strokeWidth: 0
            strokeColor: "transparent"
            PathRectangle {
                x: 0
                y: 0
                width: back.width
                height: back.height
                radius: mouseArea.pressed ? height / 2 : height / 5
            }
            fillGradient: RadialGradient {
                centerX: back.width * 0.5
                centerY: back.height * 0.5
                centerRadius: back.width
                focalX: 0
                focalY: 0
                GradientStop {
                    position: mouseArea.pressed ? 0 : 1
                    color: Qt.lighter(controlInputButton2.btnColor, 1.2)
                    Behavior on color {
                        ColorAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
                GradientStop {
                    position: mouseArea.pressed ? 1 : 0
                    color: Qt.darker(controlInputButton2.btnColor, 1.4)
                    Behavior on color {
                        ColorAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
            }
        }
        MyIconLabel {
            font.pixelSize: height * 0.25
            height: parent.height
            width: parent.width
            text: mouseArea.pressed ? "" : controlInputButton2.textInput
            icon.source: controlInputButton2.iconSource
        }
        layer.enabled: true
        layer.effect: MultiEffect {
            id: effect
            shadowEnabled: true
            shadowColor: Global.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset / 2
            shadowVerticalOffset: mouseArea.pressed ? Global.shadowHeight / 2 : Global.shadowHeight
            Behavior on shadowHorizontalOffset {
                NumberAnimation {
                    duration: Global.durationDelay
                }
            }
        }
        Text {
            width: parent.width
            height: parent.height
            text: controlInputButton2.input
            font.pixelSize: height
            color: controlInputButton2.btnTextColor
            horizontalAlignment: mouseArea.pressed ? Text.AlignHCenter : Text.AlignRight
            verticalAlignment: mouseArea.pressed ? Text.AlignVCenter : Text.AlignTop
            font.bold: true
            opacity: 0.1
            font.family: Global.alibabaPuHuiTi.font.family
        }
        clip: true
        Drag.keys: [controlInputButton2.input, controlInputButton2.btnColor]
        Drag.active: mouseArea.drag.active
    }
}
