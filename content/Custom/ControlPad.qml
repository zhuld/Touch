import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import QtQuick.Effects

import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

Item {
    id: controlPad

    property int channel
    property int disEnableChannel: 0
    enabled: Global.digital[disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.5

    implicitWidth: 100
    implicitHeight: 130
    readonly property real shift1: Math.sqrt(width * width / 8)
    readonly property real shift2: Math.sqrt(width * width / 32)
    readonly property real point1: width / 2 - shift1
    readonly property real point2: width / 2 - shift2
    readonly property real point3: width / 2 + shift2
    readonly property real point4: width / 2 + shift1

    Column {
        anchors.fill: parent
        spacing: width * 0.05
        Item {
            width: parent.width
            height: width
            Shape {
                id: upButton
                property int channel: controlPad.channel
                property bool checked: Global.digital[upButton.channel] ? true : false
                width: parent.width
                height: width
                y: checked ? -controlPad.width / 50 : -controlPad.width / 60
                Behavior on y {
                    NumberAnimation {
                        duration: Global.durationDelay
                    }
                }
                MyIconLabel {
                    height: parent.height * 0.3
                    width: height
                    anchors.horizontalCenter: parent.horizontalCenter
                    icon.source: "qrc:/content/icons/up.png"
                    icon.color: upButton.checked ? Global.backgroundColor : Global.buttonTextColor
                    Text {
                        height: parent.height
                        text: Global.settings.showChannel ? "D" + upButton.channel : ""
                        color: Global.buttonTextColor
                        font.pixelSize: channelSize
                        font.family: Global.alibabaPuHuiTi.font.family
                    }
                }
                containsMode: Shape.FillContains
                layer.enabled: true
                layer.samples: 16
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    shadowColor: Global.buttonShadowColor
                    shadowHorizontalOffset: shadowVerticalOffset / 2
                    shadowVerticalOffset: upButton.checked ? shadowHeight / 2 : shadowHeight
                    Behavior on shadowHorizontalOffset {
                        NumberAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
                ShapePath {
                    strokeWidth: 0
                    fillGradient: RadialGradient {
                        centerX: upButton.width * 0.5
                        centerY: upButton.height * 0.5
                        centerRadius: upButton.width
                        focalX: 0
                        focalY: 0
                        GradientStop {
                            position: 1
                            color: upButton.checked ? Qt.lighter(
                                                          Global.buttonCheckedColor,
                                                          1.2) : Qt.lighter(
                                                          Global.buttonColor,
                                                          1.2)
                            Behavior on color {
                                ColorAnimation {
                                    duration: Global.durationDelay
                                }
                            }
                        }
                        GradientStop {
                            position: 0
                            color: upButton.checked ? Qt.darker(
                                                          Global.buttonCheckedColor,
                                                          1.4) : Qt.darker(
                                                          Global.buttonColor,
                                                          1.4)
                            Behavior on color {
                                ColorAnimation {
                                    duration: Global.durationDelay
                                }
                            }
                        }
                    }
                    PathAngleArc {
                        radiusX: upButton.width / 2
                        radiusY: radiusX
                        centerX: upButton.width / 2
                        centerY: centerX
                        startAngle: -135
                        sweepAngle: 90
                    }
                    PathLine {
                        x: controlPad.point3
                        y: controlPad.point2
                    }
                    PathAngleArc {
                        radiusX: upButton.width / 4
                        radiusY: radiusX
                        centerX: upButton.width / 2
                        centerY: centerX
                        startAngle: -45
                        sweepAngle: -90
                    }
                    PathLine {
                        x: controlPad.point1
                        y: controlPad.point1
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    containmentMask: upButton
                    hoverEnabled: true
                    onPressedChanged: {
                        if (pressed) {
                            CrestronCIP.push(upButton.channel)
                        } else {
                            CrestronCIP.release(upButton.channel)
                        }
                    }
                }
            }

            Shape {
                id: leftButton
                property int channel: controlPad.channel + 2
                property bool checked: Global.digital[leftButton.channel] ? true : false
                width: parent.width
                height: width
                x: checked ? -controlPad.width / 50 : -controlPad.width / 60
                Behavior on x {
                    NumberAnimation {
                        duration: Global.durationDelay
                    }
                }
                MyIconLabel {
                    height: parent.height * 0.3
                    width: height
                    anchors.verticalCenter: parent.verticalCenter
                    icon.source: "qrc:/content/icons/left.png"
                    icon.color: leftButton.checked ? Global.backgroundColor : Global.buttonTextColor
                    Text {
                        height: parent.height
                        text: Global.settings.showChannel ? "D" + leftButton.channel : ""
                        color: Global.buttonTextColor
                        font.pixelSize: channelSize
                        font.family: Global.alibabaPuHuiTi.font.family
                    }
                }
                containsMode: Shape.FillContains
                layer.enabled: true
                layer.samples: 16
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    shadowColor: Global.buttonShadowColor
                    shadowHorizontalOffset: shadowVerticalOffset / 2
                    shadowVerticalOffset: leftButton.checked ? shadowHeight / 2 : shadowHeight
                    Behavior on shadowHorizontalOffset {
                        NumberAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
                ShapePath {
                    strokeWidth: 0
                    fillGradient: RadialGradient {
                        centerX: leftButton.width * 0.5
                        centerY: leftButton.height * 0.5
                        centerRadius: leftButton.width
                        focalX: 0
                        focalY: 0
                        GradientStop {
                            position: 1
                            color: leftButton.checked ? Qt.lighter(
                                                            Global.buttonCheckedColor,
                                                            1.2) : Qt.lighter(
                                                            Global.buttonColor,
                                                            1.2)
                            Behavior on color {
                                ColorAnimation {
                                    duration: Global.durationDelay
                                }
                            }
                        }
                        GradientStop {
                            position: 0
                            color: leftButton.checked ? Qt.darker(
                                                            Global.buttonCheckedColor,
                                                            1.4) : Qt.darker(
                                                            Global.buttonColor,
                                                            1.4)
                            Behavior on color {
                                ColorAnimation {
                                    duration: Global.durationDelay
                                }
                            }
                        }
                    }
                    PathAngleArc {
                        radiusX: leftButton.width / 2
                        radiusY: radiusX
                        centerX: leftButton.width / 2
                        centerY: centerX
                        startAngle: 135
                        sweepAngle: 90
                    }
                    PathLine {
                        x: controlPad.point2
                        y: controlPad.point2
                    }
                    PathAngleArc {
                        radiusX: leftButton.width / 4
                        radiusY: radiusX
                        centerX: leftButton.width / 2
                        centerY: centerX
                        startAngle: -135
                        sweepAngle: -90
                    }
                    PathLine {
                        x: controlPad.point1
                        y: controlPad.point4
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    containmentMask: leftButton
                    hoverEnabled: true
                    onPressedChanged: {
                        if (pressed) {
                            CrestronCIP.push(leftButton.channel)
                        } else {
                            CrestronCIP.release(leftButton.channel)
                        }
                    }
                }
            }

            Shape {
                id: rightButton
                property int channel: controlPad.channel + 3
                property bool checked: Global.digital[rightButton.channel] ? true : false
                width: parent.width
                height: width
                x: checked ? controlPad.width / 50 : controlPad.width / 60
                Behavior on x {
                    NumberAnimation {
                        duration: Global.durationDelay
                    }
                }
                MyIconLabel {
                    height: parent.height * 0.3
                    width: height
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    icon.source: "qrc:/content/icons/right.png"
                    icon.color: rightButton.checked ? Global.backgroundColor : Global.buttonTextColor
                    Text {
                        height: parent.height
                        text: Global.settings.showChannel ? "D" + rightButton.channel : ""
                        color: Global.buttonTextColor
                        font.pixelSize: channelSize
                        font.family: Global.alibabaPuHuiTi.font.family
                    }
                }
                containsMode: Shape.FillContains
                layer.enabled: true
                layer.samples: 16
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    shadowColor: Global.buttonShadowColor
                    shadowHorizontalOffset: shadowVerticalOffset / 2
                    shadowVerticalOffset: rightButton.checked ? shadowHeight / 2 : shadowHeight
                    Behavior on shadowHorizontalOffset {
                        NumberAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
                ShapePath {
                    strokeWidth: 0
                    fillGradient: RadialGradient {
                        centerX: rightButton.width * 0.5
                        centerY: rightButton.height * 0.5
                        centerRadius: rightButton.width
                        focalX: 0
                        focalY: 0
                        GradientStop {
                            position: 1
                            color: rightButton.checked ? Qt.lighter(
                                                             Global.buttonCheckedColor,
                                                             1.2) : Qt.lighter(
                                                             Global.buttonColor,
                                                             1.2)
                            Behavior on color {
                                ColorAnimation {
                                    duration: Global.durationDelay
                                }
                            }
                        }
                        GradientStop {
                            position: 0
                            color: rightButton.checked ? Qt.darker(
                                                             Global.buttonCheckedColor,
                                                             1.4) : Qt.darker(
                                                             Global.buttonColor,
                                                             1.4)
                            Behavior on color {
                                ColorAnimation {
                                    duration: Global.durationDelay
                                }
                            }
                        }
                    }
                    PathAngleArc {
                        radiusX: rightButton.width / 2
                        radiusY: radiusX
                        centerX: rightButton.width / 2
                        centerY: centerX
                        startAngle: -45
                        sweepAngle: 90
                    }
                    PathLine {
                        x: controlPad.point3
                        y: controlPad.point3
                    }
                    PathAngleArc {
                        radiusX: rightButton.width / 4
                        radiusY: radiusX
                        centerX: rightButton.width / 2
                        centerY: centerX
                        startAngle: 45
                        sweepAngle: -90
                    }
                    PathLine {
                        x: controlPad.point4
                        y: controlPad.point1
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    containmentMask: rightButton
                    hoverEnabled: true
                    onPressedChanged: {
                        if (pressed) {
                            CrestronCIP.push(rightButton.channel)
                        } else {
                            CrestronCIP.release(rightButton.channel)
                        }
                    }
                }
            }

            Shape {
                id: downButton
                property int channel: controlPad.channel + 1
                property bool checked: Global.digital[downButton.channel] ? true : false
                width: parent.width
                height: width
                y: checked ? controlPad.width / 50 : controlPad.width / 60
                Behavior on y {
                    NumberAnimation {
                        duration: Global.durationDelay
                    }
                }
                MyIconLabel {
                    height: parent.height * 0.3
                    width: height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    icon.source: "qrc:/content/icons/down.png"
                    icon.color: downButton.checked ? Global.backgroundColor : Global.buttonTextColor
                    Text {
                        height: parent.height
                        text: Global.settings.showChannel ? "D" + downButton.channel : ""
                        color: Global.buttonTextColor
                        font.pixelSize: channelSize
                        font.family: Global.alibabaPuHuiTi.font.family
                    }
                }
                containsMode: Shape.FillContains
                layer.enabled: true
                layer.samples: 16
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    shadowColor: Global.buttonShadowColor
                    shadowHorizontalOffset: shadowVerticalOffset / 2
                    shadowVerticalOffset: downButton.checked ? shadowHeight / 2 : shadowHeight
                    Behavior on shadowHorizontalOffset {
                        NumberAnimation {
                            duration: Global.durationDelay
                        }
                    }
                }
                ShapePath {
                    strokeWidth: 0
                    fillGradient: RadialGradient {
                        centerX: downButton.width * 0.5
                        centerY: downButton.height * 0.5
                        centerRadius: downButton.width
                        focalX: 0
                        focalY: 0
                        GradientStop {
                            position: 1
                            color: downButton.checked ? Qt.lighter(
                                                            Global.buttonCheckedColor,
                                                            1.2) : Qt.lighter(
                                                            Global.buttonColor,
                                                            1.2)
                            Behavior on color {
                                ColorAnimation {
                                    duration: Global.durationDelay
                                }
                            }
                        }
                        GradientStop {
                            position: 0
                            color: downButton.checked ? Qt.darker(
                                                            Global.buttonCheckedColor,
                                                            1.4) : Qt.darker(
                                                            Global.buttonColor,
                                                            1.4)
                            Behavior on color {
                                ColorAnimation {
                                    duration: Global.durationDelay
                                }
                            }
                        }
                    }
                    PathAngleArc {
                        radiusX: downButton.width / 2
                        radiusY: radiusX
                        centerX: downButton.width / 2
                        centerY: centerX
                        startAngle: 45
                        sweepAngle: 90
                    }
                    PathLine {
                        x: controlPad.point2
                        y: controlPad.point3
                    }
                    PathAngleArc {
                        radiusX: downButton.width / 4
                        radiusY: radiusX
                        centerX: downButton.width / 2
                        centerY: centerX
                        startAngle: 135
                        sweepAngle: -90
                    }
                    PathLine {
                        x: controlPad.point4
                        y: controlPad.point4
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    containmentMask: downButton
                    hoverEnabled: true
                    onPressedChanged: {
                        if (pressed) {
                            CrestronCIP.push(downButton.channel)
                        } else {
                            CrestronCIP.release(downButton.channel)
                        }
                    }
                }
            }
        }
        Row {
            height: parent.width * 0.25
            width: parent.width
            spacing: width - 2 * height
            MyButton {
                height: parent.height
                width: height
                source: "qrc:/content/icons/fangda.png"
                radius: height / 2
                channel: controlPad.channel + 4
            }
            MyButton {
                height: parent.height
                width: height
                source: "qrc:/content/icons/suoxiao.png"
                radius: height / 2
                channel: controlPad.channel + 5
            }
        }
    }
}
