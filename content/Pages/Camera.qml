import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

import "../Custom"

Item {
    implicitWidth: parent.width
    implicitHeight: parent.height
    Row {
        id: row
        anchors.fill: parent
        spacing: width * 0.02
        Category {
            widthRatio: 0.5
            Column {
                anchors.fill: parent
                anchors.rightMargin: item.width * 0.03
                anchors.leftMargin: item.width * 0.03
                anchors.topMargin: item.width * 0.02
                anchors.bottomMargin: item.width * 0.02
                spacing: height * 0.04
                MyLable {
                    id: label
                    text: config.cameraPadName
                    height: parent.height * 0.1
                }
                ControlPad {
                    id: dpadControl
                    width: parent.width * 1.3 > parent.height
                           * 0.83 ? parent.height * 0.83 / 1.3 : parent.width
                    height: width * 1.3
                    anchors.horizontalCenter: parent.horizontalCenter
                    channel: config.cameraPadChannel
                }
            }
        }
        Category {
            widthRatio: 0.48
            Column {
                anchors.fill: parent
                anchors.rightMargin: item.width * 0.03
                anchors.leftMargin: item.width * 0.03
                anchors.topMargin: item.width * 0.02
                anchors.bottomMargin: item.width * 0.02
                MyLable {
                    text: config.cameraAutoName
                    height: parent.height * 0.1
                    MySwitch {
                        height: parent.height * 0.6
                        channel: config.cameraAutoChannel
                        anchors.right: parent.right
                        anchors.top: parent.top
                        Text {
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: parent.checked ? "自动" : "手动"
                            font.pixelSize: parent.height * 0.7
                            color: buttonTextColor
                            anchors.right: parent.left
                            font.family: alibabaPuHuiTi.font.family
                        }
                    }
                }
                Rectangle {
                    width: parent.width
                    height: parent.height * 0.9
                    color: "transparent"
                    Rectangle {
                        id: tv
                        width: parent.width * 0.6
                        height: width * 0.05
                        anchors.horizontalCenter: parent.horizontalCenter
                        border.color: catagoryColor
                        border.width: width * 0.01
                        color: "transparent"
                    }
                    IconButton {
                        id: camera
                        height: tv.height * 8
                        width: camera.height
                        anchors.top: tv.top
                        anchors.horizontalCenter: tv.horizontalCenter
                        icon.source: "qrc:/content/icons/camera.png"
                        icon.color: catagoryColor
                        backColor: "transparent"
                        hoverEnabled: false
                        rotation: 90
                        Behavior on rotation {
                            NumberAnimation {
                                duration: 300
                            }
                        }
                    }
                    Rectangle {
                        id: table
                        width: parent.width * 0.8
                        height: parent.height * 0.86
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        border.color: catagoryColor
                        border.width: width * 0.01
                        color: "transparent"
                        radius: width * 0.08
                        Grid {
                            anchors.fill: parent
                            columns: 3
                            rowSpacing: parent.height * 0.04
                            columnSpacing: parent.width * 0.1
                            anchors.margins: parent.width * 0.1
                            Repeater {
                                model: config.cameraAutoList
                                delegate: MyButton {
                                    required property int btnchannel
                                    required property int cameraRotation
                                    required property string label
                                    required property bool used
                                    width: table.width * 0.2
                                    height: width
                                    channel: btnchannel
                                    font.pixelSize: height * 0.6
                                    text: label
                                    opacity: used ? 1 : 0
                                    radius: height * 0.2
                                    onCheckedChanged: {
                                        if (checked) {
                                            camera.rotation = cameraRotation
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
}
