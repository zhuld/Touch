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
            widthRatio: config.cameraPadRatio
            lable: config.cameraPadName
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.04
                ControlPad {
                    id: dpadControl
                    width: parent.width * 1.3 > parent.height ? parent.height / 1.3 : parent.width
                    height: width * 1.3
                    anchors.horizontalCenter: parent.horizontalCenter
                    channel: config.cameraPadChannel
                }
            }
        }
        Category {
            widthRatio: config.cameraAutoRatio
            lable: config.cameraAutoName
            MySwitch {
                height: parent.height * 0.06
                channel: config.cameraAutoChannel
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: height * 0.4
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
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.04
                Rectangle {
                    width: parent.width
                    height: parent.height
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
                        width: parent.width * 0.7
                        height: parent.height * 0.9
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        border.color: catagoryColor
                        border.width: width * 0.01
                        color: "transparent"
                        radius: width * 0.08
                        Grid {
                            anchors.fill: parent
                            columns: 3
                            rowSpacing: parent.height * 0.03
                            columnSpacing: parent.width * 0.07
                            anchors.margins: parent.width * 0.1
                            Repeater {
                                model: config.cameraAutoList
                                delegate: MyButton {
                                    required property int btnchannel
                                    required property int cameraRotation
                                    required property string label
                                    required property bool used
                                    width: table.width * 0.22
                                    height: width
                                    channel: btnchannel
                                    font.pixelSize: height * 0.6
                                    text: label
                                    opacity: used ? 1 : 0
                                    radius: height * 0.5
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
