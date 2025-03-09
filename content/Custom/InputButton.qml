import QtQuick
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
            target: back
            property: "x"
            duration: Global.durationDelay * 3
            to: dragButton.dragX
            easing.type: Easing.OutBack
        }
        NumberAnimation {
            target: back
            property: "y"
            duration: Global.durationDelay * 3
            to: dragButton.dragY
            easing.type: Easing.OutBack
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag.target: back
        onPressedChanged: {
            dragButton.pressedChanged(mouseArea.pressed)
            if (pressed) {
                back.Drag.hotSpot.x = back.height / 2
                back.Drag.hotSpot.y = mouseY
                dragButton.dragX = back.x
                dragButton.dragY = back.y
                back.x = mouseX - back.height / 2
            } else {
                back.Drag.drop()
                //back.x = 0
                dragButtonAnimation.start()
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
                    color: dragButton.btnColor
                }
            }
        }
        MyIconLabel {
            font.pixelSize: height * 0.3
            height: parent.height
            width: parent.width
            text: dragButton.textInput
            icon.source: dragButton.iconSource
        }
        layer.enabled: true
        layer.effect: MultiEffect {
            id: effect2
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
            width: parent.width
            height: parent.height
            text: dragButton.input
            font.pixelSize: height
            color: dragButton.btnTextColor
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
                    color: Qt.lighter(dragButton.btnColor, 1.2)
                    Behavior on color {
                        ColorAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
                GradientStop {
                    position: mouseArea.pressed ? 1 : 0
                    color: Qt.darker(dragButton.btnColor, 1.4)
                    Behavior on color {
                        ColorAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
            }
        }
        MyIconLabel {
            font.pixelSize: height * 0.3
            height: parent.height
            width: parent.width
            text: mouseArea.pressed ? "" : dragButton.textInput
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
            width: parent.width
            height: parent.height
            text: dragButton.input
            font.pixelSize: height
            color: dragButton.btnTextColor
            horizontalAlignment: mouseArea.pressed ? Text.AlignHCenter : Text.AlignRight
            verticalAlignment: mouseArea.pressed ? Text.AlignVCenter : Text.AlignTop
            font.bold: true
            opacity: 0.1
            font.family: Global.alibabaPuHuiTi.font.family
        }
        clip: true
        Drag.keys: [dragButton.input, dragButton.btnColor]
        Drag.active: mouseArea.drag.active
    }
}
