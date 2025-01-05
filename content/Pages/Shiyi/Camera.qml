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
            lable: qsTr("摄像机控制")
            content: ControlPad {
                id: dpadControl
                width: parent.width * 1.3 > parent.height ? parent.height / 1.3 : parent.width
                height: width * 1.3
                anchors.horizontalCenter: parent.horizontalCenter
                channel: 20
                disEnableChannel: cameraAuto.channel
            }
        }
        Category {
            widthRatio: 0.5
            lable: qsTr("摄像跟踪")
            MySwitch {
                id: cameraAuto
                height: parent.height * 0.06
                channel: 40
                anchors.top: parent.top
                anchors.topMargin: height * 0.4
                anchors.right: parent.right
                anchors.rightMargin: height * 0.4
                Text {
                    height: parent.height
                    text: parent.checked ? "自动" : "手动"
                    font.pixelSize: parent.height * 0.7
                    color: Global.buttonTextColor
                    anchors.right: parent.left
                    font.family: Global.alibabaPuHuiTi.font.family
                }
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
                            duration: 300
                        }
                    }
                    icon.width: width
                    icon.height: height
                }
                MyButton {
                    height: parent.height / 10
                    width: height * 2
                    text: "复位"
                    channel: 31
                    disEnableChannel: cameraAuto.channel
                    anchors.right: parent.right
                    anchors.bottom: camera.bottom
                }
                Shape {
                    id: back
                    width: parent.width * (Global.settings.tabOnBottom ? 0.6 : 0.8)
                    height: parent.height * 0.9
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
                        Behavior on shadowHorizontalOffset {
                            NumberAnimation {
                                duration: 100
                            }
                        }
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
                                Behavior on color {
                                    ColorAnimation {
                                        duration: 100
                                    }
                                }
                            }
                            GradientStop {
                                position: 1
                                color: Qt.lighter(Global.backgroundColor, 1.2)
                                Behavior on color {
                                    ColorAnimation {
                                        duration: 100
                                    }
                                }
                            }
                        }
                    }
                    Grid {
                        id: grid
                        anchors.fill: parent
                        columns: 2
                        columnSpacing: parent.width * 0.3
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
                                height: (grid.height + grid.rowSpacing) / positionList.count
                                        * grid.columns - grid.rowSpacing
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
                                Behavior on opacity {
                                    OpacityAnimator {
                                        duration: 300
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
