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
            widthRatio: 0.6
            lable: qsTr("摄像机控制")
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
                    channel: 52
                }
            }
        }
        Category {
            widthRatio: 0.4
            lable: qsTr("预置位")
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.04
                Repeater {
                    model: ListModel {
                        id: cameraList
                        ListElement {
                            btnchannel: 58
                            name: "正常"
                            iconUrl: "qrc:/content/icons/shexiangtou.png"
                        }
                        ListElement {
                            btnchannel: 59
                            name: "全景"
                            iconUrl: "qrc:/content/icons/shexiangtou.png"
                        }
                        ListElement {
                            btnchannel: 60
                            name: "特写"
                            iconUrl: "qrc:/content/icons/shexiangtou.png"
                        }
                        ListElement {
                            btnchannel: 61
                            name: "白板"
                            iconUrl: "qrc:/content/icons/shexiangtou.png"
                        }
                        ListElement {
                            btnchannel: 62
                            name: "预留"
                            iconUrl: "qrc:/content/icons/shexiangtou.png"
                        }
                    }
                    delegate: MyButton {
                        required property string name
                        required property int btnchannel
                        required property string iconUrl
                        width: parent.width
                        height: (parent.height + parent.spacing) / cameraList.count - parent.spacing
                        text: name
                        channel: btnchannel
                        icon.source: iconUrl
                    }
                }
            }
        }
    }
}
