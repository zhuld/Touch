import QtQuick
import QtQuick.Shapes
import QtQuick.Controls
import QtQuick.Effects

import "qrc:/qt/qml/content/crestroncip.js" as CrestronCIP

Rectangle {
    id: control

    property string output
    property alias textOutput: textOutput.text
    property alias textInput: label.text
    property string disableInput

    readonly property var input: root.analog[output]

    gradient: Gradient {
        GradientStop {
            id: downColor
            position: 1.0
            color: buttonColor
            Behavior on color {
                ColorAnimation {
                    duration: 500
                }
            }
        }

        GradientStop {
            position: 0.2
            color: Qt.darker(buttonColor, 1.4)
            Behavior on color {
                ColorAnimation {
                    duration: 500
                }
            }
        }
    }

    radius: height / 10

    Text {
        id: textOutput
        height: parent.height * 0.5
        font.pixelSize: height * 0.5
        x: outputText.width
        verticalAlignment: Text.AlignVCenter
        text: "Output"
        color: buttonTextColor
        font.family: alibabaPuHuiTi.font.family
    }

    Text {
        id: outputText
        height: parent.height
        font.pixelSize: height * 0.6
        anchors.margins: height * 0.1
        anchors.left: parent.left
        text: output
        color: buttonTextColor
        font.bold: true
        opacity: 0.1
        font.family: alibabaPuHuiTi.font.family
    }
    Row {
        id: textInput
        anchors.top: textOutput.bottom
        height: parent.height * 0.5
        Image {
            id: icon
            height: control.height * 0.35
            width: height
            anchors.top: label.top
        }
        Text {
            id: label
            height: control.height * 0.5
            font.pixelSize: height * 0.5
            color: buttonTextColor
            font.family: alibabaPuHuiTi.font.family
            Behavior on text {
                PropertyAnimation {
                    target: textInput
                    easing.type: Easing.OutCubic
                    properties: "x"
                    from: 0
                    to: control.width * 0.3
                    duration: 500
                }
            }
        }
        x: control.width * 0.3
        spacing: width * 0.05
    }
    Text {
        id: inputText
        height: parent.height * 0.5
        font.pixelSize: height
        anchors.margins: height * 0.1
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        text: input ? input : ""
        color: buttonTextColor
        font.bold: true
        opacity: 0.1
        font.family: alibabaPuHuiTi.font.family
    }
    Text {
        id: channel
        height: parent.height
        width: parent.width
        horizontalAlignment: Text.AlignRight
        text: root.settings.showChannel ? "A" + control.output : ""
        color: buttonTextColor
        font.pixelSize: height * 0.3
        font.family: alibabaPuHuiTi.font.family
    }
    DropArea {
        id: dropContainer
        anchors.fill: parent
        Connections {
            onDropped: drop => {
                           if (disableInput !== drop.keys[0]) {
                               CrestronCIP.level(output, drop.keys[0])
                           }
                           control.opacity = 1
                       }
            onEntered: drop => {
                           if (disableInput !== drop.keys[0]) {
                               control.opacity = 0.6
                           }
                       }
            onExited: {
                control.opacity = 1
            }
        }
    }

    Binding {
        target: downColor
        property: "color"
        value: input > 0 ? inputModel.get(input - 1).bgColor : buttonColor
    }
    Binding {
        target: label
        property: "text"
        value: input > 0 ? inputModel.get(input - 1).name : null
    }
    Binding {
        target: icon
        property: "source"
        value: input > 0 ? inputModel.get(input - 1).source : null
    }
}
