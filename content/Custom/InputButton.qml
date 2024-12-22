import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

Item {
    id: control

    property int input
    property color btnColor: config.buttonCheckedColor
    property color btnTextColor: config.buttonTextColor
    property alias textInput: label.text
    property alias iconSource: icon.icon.source

    signal pressedChanged(bool pressed)

    MouseArea {
        id: mouseArea
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        drag.target: dragButton
        onPressedChanged: {
            control.pressedChanged(mouseArea.pressed)
            if (pressed) {
                dragButton.Drag.hotSpot.x = mouseX
                dragButton.Drag.hotSpot.y = mouseY
            } else {
                dragButton.Drag.drop()
                dragButtonAnimation.start()
            }
        }

        ParallelAnimation {
            id: dragButtonAnimation
            NumberAnimation {
                target: dragButton
                property: "x"
                duration: 400
                to: 0
                easing.type: Easing.OutBack
            }
            NumberAnimation {
                target: dragButton
                property: "y"
                duration: 400
                to: 0
                easing.type: Easing.OutBack
            }
        }

        Rectangle {
            id: dragButton
            width: parent.width
            height: parent.height
            radius: height / 5
            y: mouseArea.pressed ? height / 40 : 0
            Shape {
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
                            color: mouseArea.pressed ? Qt.lighter(
                                                           btnColor,
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
                            color: mouseArea.pressed ? Qt.darker(
                                                           btnColor,
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
            Row {
                id: iconLabel
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                IconButton {
                    id: icon
                    height: parent.height * 0.8
                    icon.color: config.buttonTextColor
                    anchors.verticalCenter: parent.verticalCenter
                    enabled: false
                }
                Text {
                    id: label
                    font.pixelSize: parent.height * 0.35
                    font.family: alibabaPuHuiTi.font.family
                    anchors.verticalCenter: parent.verticalCenter
                    color: config.buttonTextColor
                }
                spacing: 0
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
                clip: true
            }
        }
    }
    Rectangle {
        id: back
        anchors.fill: parent
        radius: dragButton.radius
        color: btnColor
        opacity: 0.2
    }
}
