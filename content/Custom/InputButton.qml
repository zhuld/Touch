import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: control

    property int input
    property color btnColor: buttonCheckedColor
    property color textColor: buttonTextColor
    property alias textInput: label.text
    property alias iconSource: icon.icon.source

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
            id: dragButton
            width: parent.width
            height: parent.height
            radius: height * 0.1
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
            z: 1
            Row {
                id: iconLabel
                height: parent.height
                anchors.horizontalCenter: dragButton.horizontalCenter
                IconButton {
                    id: icon
                    height: parent.height * 0.8
                    icon.color: buttonTextColor
                    anchors.verticalCenter: iconLabel.verticalCenter
                }
                Text {
                    id: label
                    font.pixelSize: parent.height * 0.35
                    anchors.verticalCenter: iconLabel.verticalCenter
                    color: buttonTextColor
                    font.family: alibabaPuHuiTi.font.family
                }
                spacing: 0
            }

            Drag.keys: [input]
            Drag.active: mouseArea.drag.active
        }

        Rectangle {
            id: back
            anchors.fill: parent
            radius: height * 0.1
            color: Qt.alpha(btnColor, 0.2)

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
                font.family: alibabaPuHuiTi.font.family
            }
        }

        MultiEffect {
            source: back
            anchors.fill: back
            shadowEnabled: true
            shadowColor: buttonShadowColor
            shadowHorizontalOffset: back.height / 40
            shadowVerticalOffset: shadowHorizontalOffset
        }
    }
}
