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
            label: qsTr("单独控制")
            content: Grid {
                id: gridLight
                rows: 3
                anchors.fill: parent
                columns: Math.ceil(lightList.count / rows)
                spacing: height * 0.05
                Repeater {
                    model: ListModel {
                        id: lightList
                        ListElement {
                            name: qsTr("左吸顶灯")
                            btnChannel: 71
                        }
                        ListElement {
                            name: qsTr("右吸顶灯")
                            btnChannel: 72
                        }
                        ListElement {
                            name: qsTr("前筒灯")
                            btnChannel: 73
                        }
                        ListElement {
                            name: qsTr("四周筒灯")
                            btnChannel: 74
                        }
                        ListElement {
                            name: qsTr("灯带")
                            btnChannel: 75
                        }
                        ListElement {
                            name: qsTr("其他")
                            btnChannel: 76
                        }
                    }
                    delegate: VButton {
                        required property int btnChannel
                        required property string name
                        text: name
                        channel: btnChannel
                        width: (parent.width + parent.spacing) / parent.columns - parent.spacing
                        height: (parent.height + parent.spacing) / gridLight.rows - parent.spacing
                        source: checked ? "qrc:/content/icons/deng.png" : "qrc:/content/icons/dengju.png"
                    }
                }
            }
        }
        Category {
            widthRatio: 0.5
            label: qsTr("灯光模式")
            content: Grid {
                id: gridMode
                rows: lightModeList.count
                anchors.fill: parent
                columns: Math.ceil(lightModeList.count / rows)
                spacing: height * 0.05
                Repeater {
                    model: ListModel {
                        id: lightModeList
                        ListElement {
                            name: qsTr("全开")
                            btnchannel: 81
                            iconUrl: "qrc:/content/icons/quankai.png"
                        }
                        ListElement {
                            name: qsTr("全关")
                            btnchannel: 82
                            iconUrl: "qrc:/content/icons/quanguan.png"
                        }
                        ListElement {
                            name: qsTr("会议")
                            btnchannel: 83
                            iconUrl: "qrc:/content/icons/huiyizanzhuyantao.png"
                        }
                        ListElement {
                            name: qsTr("节电")
                            btnchannel: 84
                            iconUrl: "qrc:/content/icons/jieneng.png"
                        }
                    }
                    delegate: MyButton {
                        required property string name
                        required property int btnchannel
                        required property string iconUrl
                        width: (parent.width + parent.spacing) / parent.columns - parent.spacing
                        height: (parent.height + parent.spacing) / gridMode.rows - parent.spacing
                        text: name
                        channel: btnchannel
                        source: iconUrl
                    }
                }
            }
        }
    }
}
