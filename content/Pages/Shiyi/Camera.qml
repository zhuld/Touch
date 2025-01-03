import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

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
            Item {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                ControlPad {
                    id: dpadControl
                    width: parent.width * 1.3 > parent.height ? parent.height / 1.3 : parent.width
                    height: width * 1.3
                    anchors.horizontalCenter: parent.horizontalCenter
                    channel: 20
                }
            }
        }
        Category {
            widthRatio: 0.5
            lable: qsTr("摄像跟踪")
            MySwitch {
                height: parent.height * 0.06
                channel: 40
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: height * 0.4
                Text {
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: parent.checked ? "自动" : "手动"
                    font.pixelSize: parent.height * 0.7
                    color: config.buttonTextColor
                    anchors.right: parent.left
                    font.family: alibabaPuHuiTi.font.family
                }
            }
            Item {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                Rectangle {
                    id: tv
                    width: parent.width * 0.6
                    height: width * 0.05
                    anchors.horizontalCenter: parent.horizontalCenter
                    border.color: config.catagoryColor
                    border.width: width * 0.01
                    color: "transparent"
                }
                IconLabel {
                    id: camera
                    height: tv.height * 8
                    width: camera.height
                    anchors.centerIn: tv
                    icon.source: "qrc:/content/icons/camera.png"
                    icon.color: config.catagoryColor
                    rotation: 90
                    Behavior on rotation {
                        NumberAnimation {
                            duration: 300
                        }
                    }
                }
                Rectangle {
                    id: table
                    width: parent.width * 0.9
                    height: parent.height * 0.9
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    border.color: config.catagoryColor
                    border.width: width * 0.01
                    color: "transparent"
                    radius: width * 0.08
                    Grid {
                        id: grid
                        anchors.fill: parent
                        columns: 3
                        spacing: parent.height * 0.05
                        anchors.margins: parent.width * 0.1
                        Repeater {
                            model: ListModel {
                                id: positionList
                                ListElement {
                                    cameraRotation: 135
                                    btnchannel: 39
                                    label: "8"
                                    used: true
                                }
                                ListElement {
                                    used: false
                                }
                                ListElement {
                                    cameraRotation: 45
                                    btnchannel: 38
                                    label: "7"
                                    used: true
                                }
                                ListElement {
                                    cameraRotation: 120
                                    btnchannel: 37
                                    label: "6"
                                    used: true
                                }
                                ListElement {
                                    used: false
                                }
                                ListElement {
                                    cameraRotation: 60
                                    btnchannel: 36
                                    label: "5"
                                    used: true
                                }
                                ListElement {
                                    cameraRotation: 111
                                    btnchannel: 35
                                    label: "4"
                                    used: true
                                }
                                ListElement {
                                    used: false
                                }
                                ListElement {
                                    cameraRotation: 69
                                    btnchannel: 34
                                    label: "3"
                                    used: true
                                }
                                ListElement {
                                    cameraRotation: 105
                                    btnchannel: 33
                                    label: "2"
                                    used: true
                                }
                                ListElement {
                                    cameraRotation: 90
                                    btnchannel: 31
                                    label: ""
                                    used: true
                                }
                                ListElement {
                                    cameraRotation: 75
                                    btnchannel: 32
                                    label: "1"
                                    used: true
                                }
                            }
                            delegate: MyButton {
                                required property int btnchannel
                                required property int cameraRotation
                                required property string label
                                required property bool used
                                width: (grid.width + grid.spacing) / grid.columns - grid.spacing
                                height: (grid.height + grid.spacing) / positionList.count
                                        * grid.columns - grid.spacing
                                channel: btnchannel
                                text: label
                                opacity: used ? 1 : 0
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
