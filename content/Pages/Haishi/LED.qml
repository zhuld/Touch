import QtQuick
import QtQuick.Controls

import "../../Custom"

Item {
    implicitWidth: parent.width
    implicitHeight: parent.height

    Row {
        anchors.fill: parent
        spacing: width * 0.02
        Category {
            widthRatio: 0.4
            lable: qsTr("LED控制")
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.05
                Repeater {
                    model: ListModel {
                        id: ledList
                        ListElement {
                            name: qsTr("电源开")
                            btnchannel: 23
                            iconUrl: "qrc:/content/icons/guanji.png"
                        }
                        ListElement {
                            name: qsTr("电源关")
                            btnchannel: 24
                            iconUrl: "qrc:/content/icons/guanji.png"
                        }
                        ListElement {
                            name: qsTr("屏幕显示")
                            btnchannel: 27
                            iconUrl: "qrc:/content/icons/guanji.png"
                        }
                        ListElement {
                            name: qsTr("屏幕黑屏")
                            btnchannel: 26
                            iconUrl: "qrc:/content/icons/guanji.png"
                        }
                    }
                    delegate: MyButton {
                        required property string name
                        required property int btnchannel
                        required property string iconUrl
                        width: parent.width
                        height: (parent.height * 0.9 + parent.spacing)
                                / ledList.count - parent.spacing
                        text: name
                        channel: btnchannel
                        icon.source: iconUrl
                    }
                }

                Text {
                    width: parent.width
                    height: parent.height * 0.05
                    font.pixelSize: height
                    color: catagoryColor
                    horizontalAlignment: Text.AlignRight
                    text: qsTr("长按1秒")
                    font.family: alibabaPuHuiTi.font.family
                }
            }
        }

        Category {
            widthRatio: 0.2
            lable: qsTr("亮度")
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.04
                VolumeBar {
                    height: parent.height
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    channel: 1
                    muteChannel: 0
                    miniVolume: 0
                    maxVolume: 10
                    muteBtn: false
                }
            }
        }
    }
}
