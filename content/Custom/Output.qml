pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Shapes
import QtQuick.Effects

import "../Js/crestroncip.js" as CrestronCIP

Item {
    id: controlOutput

    property int output
    property alias textOutput: textOutput.text
    property color dragShadowColor
    readonly property int input: Global.analog[output]
    property int disEnableChannel: 0
    property ListModel inputListMode

    enabled: Global.digital[controlOutput.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.4
    layer.enabled: true
    layer.effect: MultiEffect {
        id: effect
        shadowEnabled: true
        shadowColor: dropContainer.containsDrag ? controlOutput.dragShadowColor : Global.buttonShadowColor
        shadowHorizontalOffset: height / 60
        shadowVerticalOffset: dropContainer.containsDrag ? Global.shadowHeight
                                                           * 2 : Global.shadowHeight / 2
        Behavior on shadowColor {
            ColorAnimation {
                duration: Global.durationDelay
                easing.type: Easing.OutCubic
            }
        }
        Behavior on shadowVerticalOffset {
            PropertyAnimation {
                duration: Global.durationDelay
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
                radius: height / 20
            }
            fillGradient: RadialGradient {
                centerX: back.width * 0.5
                centerY: back.height * 0.5
                centerRadius: back.width
                focalX: 0
                focalY: 0
                GradientStop {
                    position: 0
                    color: Qt.alpha(
                               controlOutput.input > 0 & controlOutput.input
                               <= controlOutput.inputListMode.count ? Qt.darker(
                                                                          controlOutput.inputListMode.get(controlOutput.input - 1).bgColor, 1.4) : Global.backgroundColor,
                               0.5)
                    Behavior on color {
                        ColorAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
                GradientStop {
                    position: 1
                    color: controlOutput.input > 0 & controlOutput.input
                           <= controlOutput.inputListMode.count ? Qt.lighter(
                                                                      controlOutput.inputListMode.get(controlOutput.input - 1).bgColor,
                                                                      1.2) : Qt.lighter(
                                                                      Global.backgroundColor,
                                                                      1.3)
                    Behavior on color {
                        ColorAnimation {
                            duration: Global.durationDelay
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
        x: outputNumber.width
        verticalAlignment: Text.AlignVCenter
        text: "Output"
        color: Global.buttonTextColor
        font.family: Global.alibabaPuHuiTi.font.family
    }

    Text {
        id: outputNumber
        height: parent.height
        font.pixelSize: height * 0.6
        anchors.margins: height * 0.1
        anchors.left: parent.left
        text: controlOutput.output
        color: Global.buttonTextColor
        font.bold: true
        opacity: 0.1
        font.family: Global.alibabaPuHuiTi.font.family
    }
    MyIconLabel {
        id: textInput
        anchors.bottom: parent.bottom
        height: parent.height * 0.6
        width: parent.width - inputNumber.width
        alignment: Text.AlignRight
        icon.source: controlOutput.input > 0 & controlOutput.input
                     <= controlOutput.inputListMode.count ? controlOutput.inputListMode.get(
                                                                controlOutput.input - 1).source : ""
        text: controlOutput.input > 0 & controlOutput.input
              <= controlOutput.inputListMode.count ? controlOutput.inputListMode.get(
                                                         controlOutput.input - 1).name : null
        anchors.right: parent.right
        anchors.rightMargin: inputNumber.width
    }
    Text {
        id: inputNumber
        height: parent.height * 0.4
        font.pixelSize: height
        anchors.margins: height * 0.1
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        text: controlOutput.input ? controlOutput.input : ""
        color: Global.buttonTextColor
        font.bold: true
        opacity: 0.1
        font.family: Global.alibabaPuHuiTi.font.family
    }
    Text {
        id: channel
        height: parent.height
        text: Global.settings.showChannel ? "A" + controlOutput.output + "E"
                                            + controlOutput.disEnableChannel : ""
        color: Global.buttonTextColor
        font.pixelSize: Global.channelSize
        font.family: Global.alibabaPuHuiTi.font.family
    }
    DropArea {
        id: dropContainer
        anchors.fill: parent
        onDropped: drop => CrestronCIP.level(controlOutput.output, drop.keys[0])
        onEntered: drop => controlOutput.dragShadowColor = drop.keys[1]
    }
}
