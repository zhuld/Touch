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
                anchors.margins: item.width * 0.02
                spacing: height * 0.04
                MyLable {
                    id: label
                    text: qsTr("摄像机控制")
                    height: parent.height * 0.1
                }
                DPad {
                    id: dpadControl
                    width: parent.width * 1.3 > parent.height
                           * 0.83 ? parent.height * 0.83 / 1.3 : parent.width
                    height: width * 1.3
                    anchors.horizontalCenter: parent.horizontalCenter
                    channel: 20
                }
            }
        }
        Category {
            widthRatio: 0.5
            Column {
                anchors.fill: parent
                anchors.margins: item.width * 0.02
                //spacing: height*0.05
                MyLable {
                    text: qsTr("话筒跟踪")
                    height: parent.height * 0.1
                    MySwitch {
                        height: parent.height * 0.6
                        channel: 40
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
                        }
                    }
                }
                Rectangle {
                    width: parent.width
                    height: parent.height * 0.9
                    color: "transparent"
                    Rectangle {
                        id: tv
                        width: parent.width * 0.5
                        height: width * 0.05
                        anchors.horizontalCenter: parent.horizontalCenter
                        border.color: buttonCheckedColor
                        border.width: width * 0.01
                        color: "transparent"
                    }
                    IconImage {
                        id: camera
                        height: tv.height * 3
                        width: height
                        anchors.top: tv.bottom
                        anchors.horizontalCenter: tv.horizontalCenter
                        source: "qrc:/content/icons/camera.png"
                        rotation: 90
                        color: buttonCheckedColor
                        Behavior on rotation {
                            NumberAnimation {
                                duration: 300
                            }
                        }
                    }
                    Rectangle {
                        id: table
                        width: parent.width * 0.7
                        height: parent.height * 0.86
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        border.color: buttonCheckedColor
                        border.width: width * 0.01
                        color: "transparent"
                        radius: width * 0.05
                        Grid {
                            anchors.fill: parent
                            columns: 2
                            rowSpacing: parent.height * 0.05
                            columnSpacing: parent.width * 0.4
                            anchors.margins: parent.width * 0.1
                            Repeater {
                                model: ListModel {
                                    ListElement {
                                        rotation: 135
                                    }
                                    ListElement {
                                        rotation: 45
                                    }
                                    ListElement {
                                        rotation: 120
                                    }
                                    ListElement {
                                        rotation: 60
                                    }
                                    ListElement {
                                        rotation: 111
                                    }
                                    ListElement {
                                        rotation: 69
                                    }
                                    ListElement {
                                        rotation: 105
                                    }
                                    ListElement {
                                        rotation: 75
                                    }
                                }
                                delegate: MyButton {
                                    required property int index
                                    required property int rotation
                                    width: table.width * 0.2
                                    height: width
                                    channel: 31 + index
                                    font.pixelSize: height * 0.6
                                    text: index + 1
                                    radius: height * 0.2
                                    Connections {
                                        onCheckedChanged: if (checked) {
                                                              camera.rotation = rotation
                                                          }
                                        Component.onCompleted: if (checked) {
                                                                   camera.rotation = rotation
                                                               }
                                    }
                                }
                            }
                        }
                        MyButton {
                            id: button9
                            width: table.width * 0.2
                            height: width
                            channel: 39
                            text: "9"
                            anchors.bottom: table.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: height * 0.6
                            anchors.bottomMargin: table.width * 0.1
                            radius: height * 0.2
                            Connections {
                                onCheckedChanged: if (button9.checked) {
                                                      camera.rotation = 90
                                                  }
                                Component.onCompleted: if (button9.checked) {
                                                           camera.rotation = 90
                                                       }
                            }
                        }
                    }
                }
            }
        }
    }
}
