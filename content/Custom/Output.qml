import QtQuick
import QtQuick.Shapes
import QtQuick.Controls
import QtQuick.Effects

import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

Item {
    id: control

    property int output
    property alias textOutput: textOutput.text
    property string disableInput
    property color dragShadowColor
    readonly property var input: root.analog[output]
    property int disEnableChannel: 0
    property var inputListMode

    enabled: root.digital[control.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.2
    layer.enabled: true
    layer.effect: MultiEffect {
        id: effect
        shadowEnabled: true
        shadowColor: dropContainer.containsDrag ? control.dragShadowColor : config.buttonShadowColor
        shadowHorizontalOffset: height / 60
        shadowVerticalOffset: dropContainer.containsDrag ? shadowHeight * 2 : shadowHeight / 2
        Behavior on shadowColor {
            ColorAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }
        Behavior on shadowVerticalOffset {
            PropertyAnimation {
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
                    color: input > 0 & input
                           <= inputListMode.count ? Qt.lighter(
                                                        inputListMode.get(
                                                            input - 1).bgColor,
                                                        1.1) : Qt.lighter(
                                                        config.buttonColor, 1.2)
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
                GradientStop {
                    position: 0
                    color: input > 0 & input
                           <= inputListMode.count ? Qt.darker(
                                                        inputListMode.get(
                                                            input - 1).bgColor,
                                                        1.3) : Qt.darker(
                                                        config.buttonColor, 1.2)
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
        color: config.buttonTextColor
        font.family: alibabaPuHuiTi.font.family
    }

    Text {
        id: outputText
        height: parent.height
        font.pixelSize: height * 0.6
        anchors.margins: height * 0.1
        anchors.left: parent.left
        text: output
        color: config.buttonTextColor
        font.bold: true
        opacity: 0.1
        font.family: alibabaPuHuiTi.font.family
    }
    IconLabel {
        id: textInput
        anchors.bottom: parent.bottom
        height: parent.height * 0.6
        icon.source: input > 0 & input <= inputListMode.count ? inputListMode.get(
                                                                    input - 1).source : ""
        text: input > 0 & input <= inputListMode.count ? inputListMode.get(
                                                             input - 1).name : null
        anchors.right: parent.right
        anchors.rightMargin: inputText.width
    }
    Text {
        id: inputText
        height: parent.height * 0.5
        font.pixelSize: height
        anchors.margins: height * 0.1
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        text: input ? input : ""
        color: config.buttonTextColor
        font.bold: true
        opacity: 0.1
        font.family: alibabaPuHuiTi.font.family
    }
    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel ? "A" + control.output + "E" + control.disEnableChannel : ""
        color: config.buttonTextColor
        font.pixelSize: channelSize
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
