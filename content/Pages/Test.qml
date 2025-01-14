import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP
import "../Custom"

Item {
    id: test
    implicitWidth: parent.width
    implicitHeight: parent.height
    Row {
        anchors.fill: parent
        spacing: width * 0.02
        Category {
            label: qsTr("测试")
            widthRatio: 0.5
            content: Column {
                anchors.fill: parent
                Shape {
                    id: back
                    //property int channel: control.channel
                    height: 200
                    width: 400
                    y: mouseArea.pressed ? height / 40 : 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    MyIconLabel {
                        id: _icon
                        height: parent.height
                        width: parent.width
                        //anchors.centerIn: parent
                    }

                    containsMode: Shape.FillContains
                    layer.enabled: true
                    layer.samples: 16
                    layer.effect: MultiEffect {
                        shadowEnabled: true
                        shadowColor: Global.buttonShadowColor
                        shadowHorizontalOffset: shadowVerticalOffset
                        shadowVerticalOffset: mouseArea.pressed ? shadowHeight / 2 : shadowHeight
                    }
                    ShapePath {
                        strokeWidth: 0
                        strokeColor: "transparent"
                        PathRectangle {
                            id: pathRect
                            x: 0
                            y: 0
                            radius: back.height / 5
                            width: back.width
                            height: back.height
                        }
                        fillGradient: RadialGradient {
                            centerX: slider2.position * back.width * 0.5 * 2
                            centerY: slider2.position * back.height * 0.5 * 2
                            centerRadius: slider.position * back.width * 2
                            focalX: slider1.position * back.width * 0.25 * 4
                            focalY: slider1.position * back.height * 0.25 * 4
                            focalRadius: slider3.position * back.width * 2
                            GradientStop {
                                position: 1
                                color: mouseArea.pressed ? Qt.darker(
                                                               Global.buttonCheckedColor,
                                                               1.4) : Qt.darker(
                                                               Global.buttonColor,
                                                               1.4)
                            }
                            GradientStop {
                                position: 0
                                color: mouseArea.pressed ? Qt.lighter(
                                                               Global.buttonCheckedColor,
                                                               1.2) : Qt.lighter(
                                                               Global.buttonColor,
                                                               1.2)
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                    }
                }

                DelayButton {
                    width: 200
                    height: 100
                }
            }
        }
        Category {
            label: qsTr("测试")
            widthRatio: 0.5
            content: Column {
                anchors.fill: parent

                Slider {
                    id: slider
                    width: 400
                    height: 100
                    value: 0.5
                    from: 0
                    to: 1
                    stepSize: 0.01
                    snapMode: Slider.SnapAlways
                    MyIconLabel {
                        height: parent.height
                        text: "centerR" + parent.position
                        anchors.left: parent.right
                    }
                }
                Slider {
                    id: slider1
                    width: 400
                    height: 100
                    value: 1
                    from: 0
                    to: 1
                    stepSize: 0.01
                    snapMode: Slider.SnapAlways
                    MyIconLabel {
                        height: parent.height
                        text: "focalXY" + parent.position
                        anchors.left: parent.right
                    }
                }
                Slider {
                    id: slider2
                    width: 400
                    height: 100
                    value: 1
                    from: 0
                    to: 1
                    stepSize: 0.01
                    snapMode: Slider.SnapAlways
                    MyIconLabel {
                        height: parent.height
                        text: "centerXY" + parent.position
                        anchors.left: parent.right
                    }
                }
                Slider {
                    id: slider3
                    width: 400
                    height: 100
                    from: 0
                    to: 1
                    stepSize: 0.01
                    snapMode: Slider.SnapAlways
                    MyIconLabel {
                        height: parent.height
                        text: "focalR" + parent.position
                        anchors.left: parent.right
                    }
                }
            }
        }
    }
}
