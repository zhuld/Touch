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
            widthRatio: 0.5
            label: qsTr("视频内容")
            content: Grid {
                id: gridOutput
                rows: 3
                anchors.fill: parent
                columns: Math.ceil(listOutput.count / rows)
                spacing: height * 0.05
                Repeater {
                    model: ListModel {
                        id: listOutput
                        ListElement {
                            name: qsTr("Movie 1")
                            btnchannel: 21
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/pingmugongxiang.png"
                        }
                        ListElement {
                            name: qsTr("Movie 2")
                            btnchannel: 22
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/pingmugongxiang.png"
                        }
                        ListElement {
                            name: qsTr("Movie 3")
                            btnchannel: 23
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/pip.png"
                        }
                        ListElement {
                            name: qsTr("Movie 4")
                            btnchannel: 24
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/pip.png"
                        }
                        ListElement {
                            name: qsTr("Movie 5")
                            btnchannel: 25
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/pip.png"
                        }
                        ListElement {
                            name: qsTr("Camera")
                            btnchannel: 26
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/pip.png"
                        }
                    }
                    delegate: VButton {
                        required property string name
                        required property int btnchannel
                        required property int disBtnChannel
                        required property string iconUrl
                        width: (parent.width + parent.spacing) / parent.columns - parent.spacing
                        height: (parent.height + parent.spacing) / gridOutput.rows - parent.spacing
                        text: name
                        channel: btnchannel
                        disEnableChannel: disBtnChannel
                        source: iconUrl
                    }
                }
            }
        }

        Category {
            widthRatio: 0.5
            label: qsTr("控制")
            content: Grid {
                id: gridInput
                rows: 3
                anchors.fill: parent
                columns: Math.ceil(listInput.count / rows)
                spacing: height * 0.05
                Repeater {
                    model: ListModel {
                        id: listInput
                        ListElement {
                            name: qsTr("停止")
                            btnchannel: 27
                            iconUrl: "qrc:/content/icons/camera.png"
                        }
                        ListElement {
                            name: qsTr("暂停")
                            btnchannel: 28
                            iconUrl: "qrc:/content/icons/wuxiantouping.png"
                        }
                        ListElement {
                            name: qsTr("恢复")
                            btnchannel: 29
                            iconUrl: "qrc:/content/icons/HDMIjiekou.png"
                        }
                    }
                    delegate: VButton {
                        required property string name
                        required property int btnchannel
                        required property string iconUrl
                        width: (parent.width + parent.spacing) / parent.columns - parent.spacing
                        height: (parent.height + parent.spacing) / gridInput.rows - parent.spacing
                        text: name
                        channel: btnchannel
                        source: iconUrl
                    }
                }
            }
        }
    }
}
