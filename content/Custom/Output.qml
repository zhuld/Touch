import QtQuick
import QtQuick.Shapes
import QtQuick.Controls
import QtQuick.Effects

import "qrc:/qt/qml/content/crestroncip.js" as CrestronCIP

Rectangle {
    id: control

    property string output
    property alias textOutput: textOutput.text
    property alias textInput: textInput.text

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
            position: 0.3
            color: Qt.darker(buttonColor, 1.4)
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
    }
    IconLabel {
        id: textInput
        height: parent.height * 0.5
        font.pixelSize: height * 0.5
        width: parent.width - inputText.width
        alignment: Text.AlignRight
        anchors.margins: height * 0.1
        anchors.bottom: parent.bottom
        color: buttonTextColor
        icon.height: height * 0.5
        icon.color: buttonTextColor
        spacing: width * 0.05

        Behavior on text {
            PropertyAnimation {
                target: textInput
                easing.type: Easing.OutCubic
                properties: "x"
                from: -width * 0.4
                to: 0
                duration: 500
            }
        }
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
    }
    Text {
        id: channel
        height: parent.height
        width: parent.width
        horizontalAlignment: Text.AlignRight
        text: root.settings.showChannel ? "A" + control.output : ""
        color: buttonTextColor
        font.pixelSize: height * 0.3
    }
    DropArea {
        id: dropContainer
        anchors.fill: parent
        Connections {
            onDropped: drop => {
                           tcpClient.sendData(CrestronCIP.level(output,
                                                                drop.keys[0]))
                           control.opacity = 1
                       }
            onEntered: {
                control.opacity = 0.6
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
        target: textInput
        property: "text"
        value: input > 0 ? inputModel.get(input - 1).name : null
    }
    Binding {
        target: textInput
        property: "icon.source"
        value: input > 0 ? inputModel.get(input - 1).iconSource : null
    }
}
