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
            content: ControlPad {
                id: dpadControl
                width: parent.width * 1.3 > parent.height ? parent.height / 1.3 : parent.width
                height: width * 1.3
                anchors.horizontalCenter: parent.horizontalCenter
                channel: 52
            }
        }
        Category {
            widthRatio: 0.4
            lable: qsTr("预置位")
            content: Grid {
                anchors.fill: parent
                columns: Math.ceil(cameraList.count / 3)
                spacing: height * 0.1
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
                            name: "预置位5"
                            iconUrl: "qrc:/content/icons/shexiangtou.png"
                        }
                        ListElement {
                            btnchannel: 63
                            name: "预置位6"
                            iconUrl: "qrc:/content/icons/shexiangtou.png"
                        }
                    }
                    delegate: VButton {
                        required property string name
                        required property int btnchannel
                        required property string iconUrl
                        width: (parent.width + parent.spacing) / parent.columns - parent.spacing
                        height: (parent.height + parent.spacing) / 3 - parent.spacing
                        text: name
                        channel: btnchannel
                        source: iconUrl
                    }
                }
            }
        }
    }
}
