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
            widthRatio: 0.7
            lable: qsTr("单独控制")
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.04
                Grid {
                    id: grid
                    width: parent.width
                    height: parent.height
                    columns: 3
                    spacing: height * 0.05
                    Repeater {
                        model: ListModel {
                            id: lightList
                            ListElement {
                                name: qsTr("左吸顶灯")
                                btnChannel: 61
                            }
                            ListElement {
                                name: qsTr("右吸顶灯")
                                btnChannel: 62
                            }
                            ListElement {
                                name: qsTr("前筒灯")
                                btnChannel: 63
                            }
                            ListElement {
                                name: qsTr("四周筒灯")
                                btnChannel: 64
                            }
                            ListElement {
                                name: qsTr("灯带")
                                btnChannel: 65
                            }
                            ListElement {
                                name: qsTr("其他")
                                btnChannel: 66
                            }
                        }
                        delegate: LightButton {
                            required property int btnChannel
                            required property string name
                            text: name
                            channel: btnChannel
                            width: (grid.width + grid.spacing) / grid.columns - grid.spacing
                            height: (grid.height + grid.spacing) / lightList.count
                                    * grid.columns - grid.spacing
                        }
                    }
                }
            }
        }

        Category {
            widthRatio: 0.3
            lable: qsTr("灯光模式")
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.04
                Repeater {
                    model: ListModel {
                        id: lightModeList
                        ListElement {
                            name: qsTr("全开")
                            btnchannel: 67
                            iconUrl: "qrc:/content/icons/quankai.png"
                        }
                        ListElement {
                            name: qsTr("全关")
                            btnchannel: 68
                            iconUrl: "qrc:/content/icons/quanguan.png"
                        }
                        ListElement {
                            name: qsTr("会议")
                            btnchannel: 69
                            iconUrl: "qrc:/content/icons/huiyizanzhuyantao.png"
                        }
                        ListElement {
                            name: qsTr("节电")
                            btnchannel: 70
                            iconUrl: "qrc:/content/icons/jieneng.png"
                        }
                    }
                    delegate: MyButton {
                        id: myButton
                        required property string name
                        required property int btnchannel
                        required property string iconUrl
                        width: parent.width
                        height: (parent.height + parent.spacing)
                                / lightModeList.count - parent.spacing
                        text: name
                        channel: btnchannel
                        icon.source: iconUrl
                    }
                }
            }
        }
    }
}
