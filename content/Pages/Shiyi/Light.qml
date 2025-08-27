pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

Item {
    implicitWidth: parent.width
    implicitHeight: parent.height

    RowLayout {
        anchors.fill: parent
        Category {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumWidth: parent.width * 0.5
            Layout.rightMargin: parent.width * 0.02
            Layout.bottomMargin: parent.width * 0.02
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
                        width: (gridLight.width + gridLight.spacing)
                               / gridLight.columns - gridLight.spacing
                        height: (gridLight.height + gridLight.spacing)
                                / gridLight.rows - gridLight.spacing
                        source: checked ? "qrc:/content/icons/deng.png" : "qrc:/content/icons/dengju.png"
                    }
                }
            }
        }
        Category {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumWidth: parent.width * 0.5
            Layout.rightMargin: parent.width * 0.02
            Layout.bottomMargin: parent.width * 0.02
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
                        width: (gridMode.width + gridMode.spacing)
                               / gridMode.columns - gridMode.spacing
                        height: (gridMode.height + gridMode.spacing)
                                / gridMode.rows - gridMode.spacing
                        text: name
                        channel: btnchannel
                        source: iconUrl
                    }
                }
            }
        }
    }
}
