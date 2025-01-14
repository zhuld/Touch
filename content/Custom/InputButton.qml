import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

Item {
    id: dragButton
    property int input
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
            target: dragButton
            property: "x"
            duration: Global.durationDelay*3
            to: dragX
            easing.type: Easing.OutBack
        }
        NumberAnimation {
            target: dragButton
            property: "y"
            duration: Global.durationDelay*3
            to: dragY
            easing.type: Easing.OutBack
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag.target: dragButton
        onPressedChanged: {
            dragButton.pressedChanged(mouseArea.pressed)
            if (pressed) {
                dragButton.Drag.hotSpot.x = mouseX
                dragButton.Drag.hotSpot.y = mouseY
                dragX = dragButton.x
                dragY = dragButton.y
            } else {
                dragButton.Drag.drop()
                dragButtonAnimation.start()
            }
        }
    }

    Shape {
        id: back
        width: parent.width
        height: parent.height
        y: mouseArea.pressed ? height / 40 : 0
        Behavior on y {
            NumberAnimation {
                duration: Global.durationDelay
            }
        }
        ShapePath {
            strokeWidth: 0
            strokeColor: "transparent"
            PathRectangle {
                x: 0
                y: 0
                width: back.width
                height: back.height
                radius: height / 5
            }
            fillGradient: RadialGradient {
                centerX: back.width * 0.5
                centerY: back.height * 0.5
                centerRadius: back.width
                focalX: 0
                focalY: 0
                GradientStop {
                    position: mouseArea.pressed ? 0 : 1
                    color: Qt.lighter(btnColor, 1.2)
                    Behavior on color {
                        ColorAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
                GradientStop {
                    position: mouseArea.pressed ? 1 : 0
                    color: Qt.darker(btnColor, 1.4)
                    Behavior on color {
                        ColorAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
            }
        }
        MyIconLabel {
            font.pixelSize: height * 0.35
            height: parent.height
            width: parent.width
            text: dragButton.textInput
            icon.source: dragButton.iconSource
        }
        layer.enabled: true
        layer.effect: MultiEffect {
            id: effect
            shadowEnabled: true
            shadowColor: Global.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset / 2
            shadowVerticalOffset: mouseArea.pressed ? shadowHeight / 2 : shadowHeight
            Behavior on shadowHorizontalOffset {
                NumberAnimation {
                    duration: Global.durationDelay
                }
            }
        }
        Text {
            id: inputText
            width: parent.width
            height: parent.height
            text: input
            font.pixelSize: height
            color: btnTextColor
            horizontalAlignment: Text.AlignRight
            font.bold: true
            opacity: 0.1
            font.family: Global.alibabaPuHuiTi.font.family
        }
        clip: true
    }
    Drag.keys: [input, btnColor]
    Drag.active: mouseArea.drag.active
}
