import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: control

    property string input
    property color btnColor: buttonCheckedColor
    property color textColor: buttonTextColor
    property alias text: label.text
    property alias icon: label.icon

    MouseArea {
        id: mouseArea

        width: parent.width
        height: parent.height
        anchors.centerIn: parent

        drag.target: dragButton

        onReleased: {
            dragButton.Drag.drop()
            dragButtonAnimation.start()
        }
        onPressed: {
            dragButton.Drag.hotSpot.x = mouseX
            dragButton.Drag.hotSpot.y = mouseY
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
            id: back
            anchors.fill: parent
            radius: height * 0.1
            color: Qt.alpha(btnColor, 0.2)
            gradient: Gradient {
                GradientStop {
                    position: 1.0
                    color: mouseArea.pressed ? Qt.darker(btnColor,
                                                         1.4) : btnColor
                    Behavior on color {
                        ColorAnimation {
                            duration: 300
                        }
                    }
                }
                GradientStop {
                    position: 0
                    color: Qt.alpha(btnColor, 0.4)
                }
            }
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }

            Text {
                id: inputText
                anchors.fill: parent
                anchors.margins: height * 0.2
                text: input
                font.pixelSize: height
                color: textColor
                horizontalAlignment: Text.AlignRight
                font.bold: true
                opacity: 0.1
            }
        }

        Rectangle {
            id: dragButton
            width: control.width
            height: control.height
            radius: height * 0.1
            color: "transparent"
            z: 1
            IconLabel {
                id: label
                anchors.fill: parent
                text: "Input"
                font.pixelSize: height * 0.35
                color: buttonTextColor
                icon.height: height * 0.35
                icon.color: buttonTextColor
                spacing: width * 0.05
            }

            Drag.keys: [input]
            Drag.active: mouseArea.drag.active
        }

        MultiEffect {
            source: back
            anchors.fill: back
            shadowEnabled: true
            shadowColor: Qt.alpha(btnColor, 0.5)
            shadowHorizontalOffset: back.height / 40
            shadowVerticalOffset: shadowHorizontalOffset
        }
    }
}
