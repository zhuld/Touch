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
            Grid {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                columns: Math.ceil(ledList.count / 3)
                spacing: height * 0.1
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
            Text {
                width: parent.width
                height: parent.height * 0.05
                font.pixelSize: height
                color: config.catagoryColor
                horizontalAlignment: Text.AlignRight
                text: qsTr("长按1秒")
                anchors.bottom: parent.bottom
                font.family: alibabaPuHuiTi.font.family
            }
        }
        Category {
            widthRatio: 0.2
            lable: qsTr("亮度")
            VolumeBar {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
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
