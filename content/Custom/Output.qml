import QtQuick
import QtQuick.Shapes
import QtQuick.Controls
import QtQuick.Effects

import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

Rectangle {
    id: control

    property int output
    property alias textOutput: textOutput.text
    property alias textInput: label.text
    property string disableInput

    property color dragShadowColor

    //: buttonRedColor
    readonly property var input: root.analog[output]

    property int disEnableChannel: 0

    enabled: root.digital[control.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.2
    radius: height / 10

    layer.enabled: true
    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: dropContainer.containsDrag ? control.dragShadowColor : buttonShadowColor
        shadowHorizontalOffset: height / 30
        shadowVerticalOffset: shadowHorizontalOffset * 2
        Behavior on shadowColor {
            ColorAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }
    }
    Shape {
        id: back
        anchors.fill: parent
        ShapePath {
            strokeWidth: 0
            strokeColor: "transparent"
            PathRectangle {
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
                focalX: back.width * 0.25
                focalY: back.height * 0.25
                GradientStop {
                    position: 1
                    color: input > 0 & input < 9 ? Qt.lighter(
                                                       config.videoInputList.get(
                                                           input - 1).bgColor,
                                                       1.1) : Qt.lighter(
                                                       buttonColor, 1.2)
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
                GradientStop {
                    position: 0
                    color: input > 0 & input < 9 ? Qt.darker(
                                                       config.videoInputList.get(
                                                           input - 1).bgColor,
                                                       1.3) : Qt.darker(
                                                       buttonColor, 1.2)
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
            }
        }
    }

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
        IconButton {
            id: icon
            height: parent.height
            icon.color: buttonTextColor
            anchors.verticalCenter: textInput.verticalCenter
            backColor: "transparent"
            icon.source: input > 0 & input < 9 ? config.videoInputList.get(
                                                     input - 1).source : ""
        }
        Text {
            id: label
            height: parent.height
            font.pixelSize: height * 0.5
            color: buttonTextColor
            verticalAlignment: Text.AlignVCenter
            font.family: alibabaPuHuiTi.font.family
            Behavior on text {
                PropertyAnimation {
                    target: textInput
                    easing.type: Easing.OutCubic
                    properties: "x"
                    from: 0
                    to: control.width * 0.2
                    duration: 500
                }
            }
            text: input > 0 & input < 9 ? config.videoInputList.get(
                                              input - 1).name : null
        }
        x: control.width * 0.2
        spacing: 0
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
        text: root.settings.showChannel ? "A" + control.output : ""
        color: buttonTextColor
        font.pixelSize: height * 0.3
        font.family: alibabaPuHuiTi.font.family
    }
    Text {
        id: disEnableChannel
        height: parent.height
        text: root.settings.showChannel ? "E" + control.disEnableChannel : ""
        color: buttonTextColor
        font.pixelSize: height * 0.3
        anchors.right: parent.right
        font.family: alibabaPuHuiTi.font.family
    }
    DropArea {
        id: dropContainer
        anchors.fill: parent
        onDropped: drop => {
                       if (disableInput !== drop.keys[0]) {
                           CrestronCIP.level(output, drop.keys[0])
                       }
                   }

        onEntered: drop => control.dragShadowColor = drop.keys[1]
    }
}
