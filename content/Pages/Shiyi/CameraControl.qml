import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import QtQuick.Effects

import "../../Custom"

Item {
    implicitWidth: parent.width
    implicitHeight: parent.height
    Row {
        anchors.fill: parent
        spacing: width * 0.02
        Category {
            widthRatio: 0.5
            label: qsTr("摄像机控制")
            content: ControlPad {
                id: dpadControl
                width: parent.width * 1.3 > parent.height
                       * 0.8 ? parent.height * 0.8 / 1.3 : parent.width * 0.8
                height: width * 1.3
                anchors.centerIn: parent
                channel: 21
                disEnableChannel: cameraAuto.channel
            }
        }
        Category {
            widthRatio: 0.5
            label: qsTr("摄像跟踪")
            info: MySwitch {
                id: cameraAuto
                channel: 46
                text: checked ? "自动" : "手动"
                height: parent.height * 0.8
                width: height * 2
                anchors.verticalCenter: parent.verticalCenter
            }
            content: Item {
                anchors.fill: parent
                MyIconLabel {
                    id: camera
                    height: parent.height / 12
                    width: height
                    anchors.horizontalCenter: parent.horizontalCenter
                    icon.source: "qrc:/content/icons/camera.png"
                    icon.color: Global.buttonTextColor
                    rotation: 90
                    Behavior on rotation {
                        NumberAnimation {
                            duration: Global.durationDelay * 2
                        }
                    }
                    icon.width: width
                    icon.height: height
                }
                MyButton {
                    height: parent.height / 10
                    width: height * 2
                    text: "全景"
                    channel: 31
                    disEnableChannel: cameraAuto.channel
                    anchors.right: parent.right
                    anchors.bottom: camera.bottom
                }
                Shape {
                    id: back
                    width: parent.width * (Global.config.tabOnBottom ? 0.6 : 0.8)
                    height: parent.height * 0.86
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    containsMode: Shape.FillContains
                    layer.enabled: true
                    layer.samples: 16
                    layer.effect: MultiEffect {
                        shadowEnabled: true
                        shadowColor: Global.buttonShadowColor
                        shadowHorizontalOffset: shadowVerticalOffset
                        shadowVerticalOffset: shadowHeight
                    }
                    opacity: 0.8
                    ShapePath {
                        strokeWidth: 0
                        strokeColor: "transparent"
                        PathRectangle {
                            id: pathRect
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
                                color: Qt.darker(Global.backgroundColor, 1.2)
                            }
                            GradientStop {
                                position: 1
                                color: Qt.lighter(Global.backgroundColor, 1.2)
                            }
                        }
                    }
                    Grid {
                        id: grid
                        anchors.fill: parent
                        columns: 2
                        columnSpacing: parent.width * 0.35
                        rowSpacing: parent.height * 0.05
                        anchors.margins: parent.width * 0.1
                        Repeater {
                            model: ListModel {
                                id: positionList
                                ListElement {
                                    cameraRotation: 135
                                    btnchannel: 32
                                    label: "1"
                                }
                                ListElement {
                                    cameraRotation: 45
                                    btnchannel: 33
                                    label: "2"
                                }
                                ListElement {
                                    cameraRotation: 120
                                    btnchannel: 34
                                    label: "3"
                                }
                                ListElement {
                                    cameraRotation: 60
                                    btnchannel: 35
                                    label: "4"
                                }
                                ListElement {
                                    cameraRotation: 111
                                    btnchannel: 36
                                    label: "5"
                                }
                                ListElement {
                                    cameraRotation: 69
                                    btnchannel: 37
                                    label: "6"
                                }
                                ListElement {
                                    cameraRotation: 105
                                    btnchannel: 38
                                    label: "7"
                                }
                                ListElement {
                                    cameraRotation: 75
                                    btnchannel: 39
                                    label: "8"
                                }
                            }
                            delegate: MyButton {
                                required property int btnchannel
                                required property int cameraRotation
                                required property string label
                                width: (grid.width + grid.columnSpacing)
                                       / grid.columns - grid.columnSpacing
                                height: width
                                radius: height / 2
                                channel: btnchannel
                                text: label
                                disEnableChannel: cameraAuto.channel
                                onCheckedChanged: {
                                    if (checked) {
                                        camera.rotation = cameraRotation
                                    } else {
                                        camera.rotation = 90
                                    }
                                }
                                Component.onCompleted: {
                                    if (checked) {
                                        camera.rotation = cameraRotation
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
