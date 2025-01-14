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
            widthRatio: 0.3
            label: qsTr("输出")
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
                            name: qsTr("大屏")
                            btnchannel: 163
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/pingmugongxiang.png"
                        }
                        ListElement {
                            name: qsTr("地插输出")
                            btnchannel: 161
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/HDMIjiekou.png"
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
            widthRatio: 0.7
            label: qsTr("输入信号")
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
                            name: qsTr("机柜电脑-左")
                            btnchannel: 154
                            iconUrl: "qrc:/content/icons/zhuji.png"
                        }
                        ListElement {
                            name: qsTr("机柜电脑-右")
                            btnchannel: 157
                            iconUrl: "qrc:/content/icons/zhuji.png"
                        }
                        ListElement {
                            name: qsTr("摄像机")
                            btnchannel: 156
                            iconUrl: "qrc:/content/icons/camera.png"
                        }
                        ListElement {
                            name: qsTr("无线投屏")
                            btnchannel: 155
                            iconUrl: "qrc:/content/icons/wuxiantouping.png"
                        }
                        ListElement {
                            name: qsTr("地插-讲台")
                            btnchannel: 152
                            iconUrl: "qrc:/content/icons/HDMIjiekou.png"
                        }
                        ListElement {
                            name: qsTr("一体机")
                            btnchannel: 151
                            iconUrl: "qrc:/content/icons/yitiji.png"
                        }
                        ListElement {
                            name: qsTr("VR-左")
                            btnchannel: 153
                            iconUrl: "qrc:/content/icons/zhuji.png"
                        }
                        ListElement {
                            name: qsTr("VR-右")
                            btnchannel: 150
                            iconUrl: "qrc:/content/icons/zhuji.png"
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
