import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

Item {
    id: dragButton
    property int input
    property color btnColor: config.buttonCheckedColor
    property color btnTextColor: config.buttonTextColor
    property alias textInput: icon.text
    property alias iconSource: icon.icon.source

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
            duration: 400
            to: dragX
            easing.type: Easing.OutBack
        }
        NumberAnimation {
            target: dragButton
            property: "y"
            duration: 400
            to: dragY
            easing.type: Easing.OutBack
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag.target: parent
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
        width: parent.width
        height: parent.height
        y: mouseArea.pressed ? height / 40 : 0
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
                focalX: back.width * 0.25
                focalY: back.height * 0.25
                GradientStop {
                    position: 1
                    color: mouseArea.pressed ? Qt.lighter(btnColor,
                                                          1.2) : Qt.lighter(
                                                   btnColor, 1.3)
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
                GradientStop {
                    position: 0
                    color: mouseArea.pressed ? Qt.darker(btnColor,
                                                         1.5) : Qt.darker(
                                                   btnColor, 1.3)
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
            }
        }
    }
    IconLabel {
        id: icon
        height: parent.height * 0.8
        anchors.centerIn: parent
    }
    Drag.keys: [input, btnColor]
    Drag.active: mouseArea.drag.active
    layer.enabled: true
    layer.effect: MultiEffect {
        id: effect
        shadowEnabled: true
        shadowColor: config.buttonShadowColor
        shadowHorizontalOffset: shadowVerticalOffset / 2
        shadowVerticalOffset: mouseArea.pressed ? shadowHeight / 2 : shadowHeight
        Behavior on shadowHorizontalOffset {
            NumberAnimation {
                duration: 100
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
        font.family: alibabaPuHuiTi.font.family
    }

    Rectangle {
        id: back
        anchors.fill: parent
        radius: height / 5
        color: btnColor
        opacity: 0.2
    }
}
