import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import QtQuick.Effects

import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

Item {
    id: control

    property int channel
    property int disEnableChannel: 0
    enabled: root.digital[control.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6

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
        Rectangle {
            width: parent.width
            height: width
            color: "transparent"

            Shape {
                id: upButton
                property int channel: control.channel
                property bool checked: root.digital[upButton.channel] ? true : false
                width: parent.width
                height: width
                y: checked ? -control.width / 50 : -control.width / 60
                Behavior on y {
                    NumberAnimation {
                        duration: 100
                    }
                }
                IconButton {
                    height: parent.height * 0.2
                    width: height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    icon.height: height
                    icon.width: width
                    hoverEnabled: false
                    backColor: "transparent"
                    icon.source: "qrc:/content/icons/up.png"
                    Text {
                        height: parent.height
                        text: root.settings.showChannel ? "D" + upButton.channel : ""
                        color: config.buttonTextColor
                        font.pixelSize: channelSize
                        font.family: alibabaPuHuiTi.font.family
                    }
                }
                containsMode: Shape.FillContains
                layer.enabled: true
                layer.samples: 16
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    shadowColor: config.buttonShadowColor
                    shadowHorizontalOffset: shadowVerticalOffset / 2
                    shadowVerticalOffset: upButton.checked ? 0 : height / 60
                    Behavior on shadowHorizontalOffset {
                        NumberAnimation {
                            duration: 100
                        }
                    }
                }
                ShapePath {
                    strokeWidth: 0
                    fillGradient: RadialGradient {
                        centerX: control.width * 0.5
                        centerY: control.height * 0.5
                        centerRadius: control.width
                        focalX: control.width * 0.25
                        focalY: control.height * 0.25
                        GradientStop {
                            position: 1
                            color: upButton.checked ? Qt.lighter(
                                                          config.buttonCheckedColor,
                                                          1.2) : Qt.lighter(
                                                          config.buttonColor,
                                                          1.2)
                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
                                }
                            }
                        }
                        GradientStop {
                            position: 0
                            color: upButton.checked ? Qt.darker(
                                                          config.buttonCheckedColor,
                                                          1.4) : Qt.darker(
                                                          config.buttonColor,
                                                          1.4)
                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
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
                        x: control.point3
                        y: control.point2
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
                        x: control.point1
                        y: control.point1
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
                property int channel: control.channel + 2
                property bool checked: root.digital[leftButton.channel] ? true : false
                width: parent.width
                height: width
                x: checked ? -control.width / 50 : -control.width / 60
                Behavior on x {
                    NumberAnimation {
                        duration: 100
                    }
                }
                IconButton {
                    height: parent.height * 0.2
                    width: height
                    anchors.verticalCenter: parent.verticalCenter
                    icon.height: height
                    icon.width: width
                    hoverEnabled: false
                    backColor: "transparent"
                    icon.source: "qrc:/content/icons/left.png"
                    anchors.left: parent.left
                    Text {
                        height: parent.height
                        text: root.settings.showChannel ? "D" + leftButton.channel : ""
                        color: config.buttonTextColor
                        font.pixelSize: channelSize
                        font.family: alibabaPuHuiTi.font.family
                    }
                }
                containsMode: Shape.FillContains
                layer.enabled: true
                layer.samples: 16
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    shadowColor: config.buttonShadowColor
                    shadowHorizontalOffset: shadowVerticalOffset / 2
                    shadowVerticalOffset: leftButton.checked ? 0 : height / 60
                    Behavior on shadowHorizontalOffset {
                        NumberAnimation {
                            duration: 100
                        }
                    }
                }
                ShapePath {
                    strokeWidth: 0
                    fillGradient: RadialGradient {
                        centerX: control.width * 0.5
                        centerY: control.height * 0.5
                        centerRadius: control.width
                        focalX: control.width * 0.25
                        focalY: control.height * 0.25
                        GradientStop {
                            position: 1
                            color: leftButton.checked ? Qt.lighter(
                                                            config.buttonCheckedColor,
                                                            1.2) : Qt.lighter(
                                                            config.buttonColor,
                                                            1.2)
                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
                                }
                            }
                        }
                        GradientStop {
                            position: 0
                            color: leftButton.checked ? Qt.darker(
                                                            config.buttonCheckedColor,
                                                            1.4) : Qt.darker(
                                                            config.buttonColor,
                                                            1.4)
                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
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
                        x: control.point2
                        y: control.point2
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
                        x: control.point1
                        y: control.point4
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
                property int channel: control.channel + 3
                property bool checked: root.digital[rightButton.channel] ? true : false
                width: parent.width
                height: width
                x: checked ? control.width / 50 : control.width / 60
                Behavior on x {
                    NumberAnimation {
                        duration: 100
                    }
                }
                IconButton {
                    height: parent.height * 0.2
                    width: height
                    anchors.verticalCenter: parent.verticalCenter
                    icon.height: height
                    icon.width: width
                    hoverEnabled: false
                    anchors.right: parent.right
                    backColor: "transparent"
                    icon.source: "qrc:/content/icons/right.png"
                    Text {
                        height: parent.height
                        text: root.settings.showChannel ? "D" + rightButton.channel : ""
                        color: config.buttonTextColor
                        font.pixelSize: channelSize
                        font.family: alibabaPuHuiTi.font.family
                    }
                }
                containsMode: Shape.FillContains
                layer.enabled: true
                layer.samples: 16
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    shadowColor: config.buttonShadowColor
                    shadowHorizontalOffset: shadowVerticalOffset / 2
                    shadowVerticalOffset: rightButton.checked ? 0 : height / 60
                    Behavior on shadowHorizontalOffset {
                        NumberAnimation {
                            duration: 100
                        }
                    }
                }
                ShapePath {
                    strokeWidth: 0
                    fillGradient: RadialGradient {
                        centerX: control.width * 0.5
                        centerY: control.height * 0.5
                        centerRadius: control.width
                        focalX: control.width * 0.25
                        focalY: control.height * 0.25
                        GradientStop {
                            position: 1
                            color: rightButton.checked ? Qt.lighter(
                                                             config.buttonCheckedColor,
                                                             1.2) : Qt.lighter(
                                                             config.buttonColor,
                                                             1.2)
                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
                                }
                            }
                        }
                        GradientStop {
                            position: 0
                            color: rightButton.checked ? Qt.darker(
                                                             config.buttonCheckedColor,
                                                             1.4) : Qt.darker(
                                                             config.buttonColor,
                                                             1.4)
                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
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
                        x: control.point3
                        y: control.point3
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
                        x: control.point4
                        y: control.point1
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
                property int channel: control.channel + 1
                property bool checked: root.digital[downButton.channel] ? true : false
                width: parent.width
                height: width
                y: checked ? control.width / 50 : control.width / 60
                Behavior on y {
                    NumberAnimation {
                        duration: 100
                    }
                }
                IconButton {
                    height: parent.height * 0.2
                    width: height
                    anchors.horizontalCenter: parent.horizontalCenter
                    icon.height: height
                    icon.width: width
                    hoverEnabled: false
                    anchors.bottom: parent.bottom
                    backColor: "transparent"
                    icon.source: "qrc:/content/icons/down.png"
                    Text {
                        height: parent.height
                        text: root.settings.showChannel ? "D" + downButton.channel : ""
                        color: config.buttonTextColor
                        font.pixelSize: channelSize
                        font.family: alibabaPuHuiTi.font.family
                    }
                }
                containsMode: Shape.FillContains
                layer.enabled: true
                layer.samples: 16
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    shadowColor: config.buttonShadowColor
                    shadowHorizontalOffset: shadowVerticalOffset / 2
                    shadowVerticalOffset: downButton.checked ? 0 : height / 60
                    Behavior on shadowHorizontalOffset {
                        NumberAnimation {
                            duration: 100
                        }
                    }
                }
                ShapePath {
                    strokeWidth: 0
                    fillGradient: RadialGradient {
                        centerX: control.width * 0.5
                        centerY: control.height * 0.5
                        centerRadius: control.width
                        focalX: control.width * 0.25
                        focalY: control.height * 0.25
                        GradientStop {
                            position: 1
                            color: downButton.checked ? Qt.lighter(
                                                            config.buttonCheckedColor,
                                                            1.2) : Qt.lighter(
                                                            config.buttonColor,
                                                            1.2)
                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
                                }
                            }
                        }
                        GradientStop {
                            position: 0
                            color: downButton.checked ? Qt.darker(
                                                            config.buttonCheckedColor,
                                                            1.4) : Qt.darker(
                                                            config.buttonColor,
                                                            1.4)
                            Behavior on color {
                                ColorAnimation {
                                    duration: 100
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
                        x: control.point2
                        y: control.point3
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
                        x: control.point4
                        y: control.point4
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
        Rectangle {
            height: parent.width * 0.25
            width: parent.width
            color: "transparent"
            MyButton {
                height: parent.height
                width: height
                icon.source: "qrc:/content/icons/fangda.png"
                icon.color: config.buttonTextColor
                radius: height / 2
                channel: control.channel + 4
            }
            MyButton {
                height: parent.height
                width: height
                anchors.right: parent.right
                icon.source: "qrc:/content/icons/suoxiao.png"
                icon.color: config.buttonTextColor
                radius: height / 2
                channel: control.channel + 5
            }
        }
    }
}
