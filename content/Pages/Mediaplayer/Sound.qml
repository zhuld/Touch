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
            Layout.maximumWidth: parent.width * 0.2
            Layout.rightMargin: parent.width * 0.02
            Layout.bottomMargin: parent.width * 0.02
            label: qsTr("背景音乐内容")
            content: Grid {
                id: gridSound
                rows: 3
                anchors.fill: parent
                columns: Math.ceil(listOutput.count / rows)
                spacing: height * 0.05
                Repeater {
                    model: ListModel {
                        id: listOutput
                        ListElement {
                            name: qsTr("Sound 1")
                            btnchannel: 31
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/music.png"
                        }
                        ListElement {
                            name: qsTr("Sound 2")
                            btnchannel: 32
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/music.png"
                        }
                        ListElement {
                            name: qsTr("Sound 3")
                            btnchannel: 33
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/music.png"
                        }
                    }
                    delegate: VButton {
                        required property string name
                        required property int btnchannel
                        required property int disBtnChannel
                        required property string iconUrl
                        width: (parent.width + gridSound.spacing)
                               / gridSound.columns - gridSound.spacing
                        height: (parent.height + gridSound.spacing)
                                / gridSound.rows - gridSound.spacing
                        text: name
                        channel: btnchannel
                        disEnableChannel: disBtnChannel
                        source: iconUrl
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
            label: qsTr("控制")
            content: Grid {
                id: gridControl
                rows: 3
                anchors.fill: parent
                columns: Math.ceil(listInput.count / rows)
                spacing: height * 0.05
                Repeater {
                    model: ListModel {
                        id: listInput
                        ListElement {
                            name: qsTr("停止")
                            btnchannel: 34
                            iconUrl: "qrc:/content/icons/tingzhibofang.png"
                        }
                        ListElement {
                            name: qsTr("暂停")
                            btnchannel: 35
                            iconUrl: "qrc:/content/icons/zanting.png"
                        }
                        ListElement {
                            name: qsTr("恢复")
                            btnchannel: 36
                            iconUrl: "qrc:/content/icons/bofang.png"
                        }
                        ListElement {
                            name: qsTr("下一首")
                            btnchannel: 37
                            iconUrl: "qrc:/content/icons/houyige.png"
                        }
                    }
                    delegate: VButton {
                        required property string name
                        required property int btnchannel
                        required property string iconUrl
                        width: (parent.width + gridControl.spacing)
                               / gridControl.columns - gridControl.spacing
                        height: (parent.height + gridControl.spacing)
                                / gridControl.rows - gridControl.spacing
                        text: name
                        channel: btnchannel
                        source: iconUrl
                    }
                }
            }
        }

        Rectangle {
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumWidth: parent.width * 0.3
            Layout.rightMargin: parent.width * 0.02
            Layout.bottomMargin: parent.width * 0.02
        }
    }
}
