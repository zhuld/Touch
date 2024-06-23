import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

import "../Custom"

Item {
    implicitWidth: parent.width
    implicitHeight: parent.height
    Row{
        id:row
        anchors.fill: parent
        spacing: width*0.02
        Category{
            widthRatio: 0.5

            Column{
                anchors.fill: parent
                anchors.margins: item.width*0.02
                spacing: height*0.05
                MyLable{
                    text: qsTr("话筒跟踪")
                    height: parent.height*0.1
                    MySwitch{
                        height: parent.height*0.7
                        //anchors.verticalCenter: parent.verticalCenter
                        channel: 40
                        anchors.right: parent.right
                    }
                }
                Rectangle{
                    width: parent.width
                    height: parent.height*0.82
                    color: "transparent"
                    Rectangle{
                        id:tv
                        width: parent.width*0.5
                        height: width*0.05
                        anchors.horizontalCenter: parent.horizontalCenter
                        border.color: borderColor
                        border.width: 2
                        color: "transparent"
                    }
                    Rectangle{
                        id:speakRight
                        width: parent.width*0.05
                        height: width
                        anchors.left: tv.right
                        anchors.leftMargin: parent.width*0.1
                        border.color: borderColor
                        border.width: 2
                        color: "transparent"
                    }
                    Rectangle{
                        id:speakLeft
                        width: parent.width*0.05
                        height: width
                        anchors.right: tv.left
                        anchors.rightMargin: parent.width*0.1
                        border.color: borderColor
                        border.width: 2
                        color: "transparent"
                    }

                    Rectangle{
                        id:table
                        width: parent.width*0.6
                        height: parent.height*0.9
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        border.color: borderColor
                        border.width: 2
                        color: "transparent"
                        radius: width/10

                        Grid{
                            anchors.fill: parent
                            columns: 2
                            rowSpacing: parent.height*0.1
                            columnSpacing: parent.width*0.4
                            anchors.margins: parent.width*0.1
                            Repeater{
                                model: 8
                                delegate: MyButton{
                                    width: table.width*0.2
                                    height: width
                                    channel: 31+index
                                    font.pixelSize: height*0.6
                                    text: index+1
                                    radius: height*0.2
                                }
                            }
                        }
                        MyButton{
                            width: table.width*0.2
                            height: width
                            channel: 39
                            text: "9"
                            anchors.bottom: table.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: height*0.6
                            anchors.bottomMargin: table.width*0.1
                            radius: height*0.2
                        }
                    }
                }
            }
        }
        Category{
            widthRatio: 0.5
            Column{
                anchors.fill: parent
                anchors.margins: item.width*0.02
                spacing: height*0.04
                MyLable{
                    id:label
                    text: qsTr("摄像机控制")
                    height: parent.height*0.1
                }
                DPad{
                    id:dpadControl
                    width: parent.width*1.3>parent.height*0.83 ? parent.height*0.83/1.3 :parent.width
                    height: width*1.3
                    anchors.horizontalCenter: parent.horizontalCenter
                    channel: 20
                }
            }
        }
    }
}
