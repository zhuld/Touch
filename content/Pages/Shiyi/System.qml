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
            label: qsTr("会议模式")
            content: Grid {
                id: gridSystem
                rows: Global.config.tabOnBottom ? 3 : 4
                anchors.fill: parent
                columns: Math.ceil(systemList.count / rows)
                spacing: height * 0.05
                Repeater {
                    model: ListModel {
                        id: systemList
                        ListElement {
                            name: qsTr("显示屏会议")
                            btnchannel: 2
                            disBtnChannel: 0
                            sizeRatio: 1
                            bColor: "mediumseagreen"
                            iconUrl: "qrc:/content/icons/pingmugongxiang.png"
                            showDialog: true
                        }
                        ListElement {
                            name: qsTr("普通会议")
                            btnchannel: 3
                            disBtnChannel: 0
                            sizeRatio: 1
                            bColor: "mediumseagreen"
                            iconUrl: "qrc:/content/icons/huiyizanzhuyantao.png"
                            showDialog: true
                        }
                        ListElement {
                            name: qsTr("结束会议")
                            btnchannel: 4
                            disBtnChannel: 0
                            sizeRatio: 1
                            bColor: "salmon"
                            iconUrl: "qrc:/content/icons/guanji.png"
                            showDialog: true
                        }
                    }
                    delegate: MyButton {
                        required property string name
                        required property int btnchannel
                        required property int disBtnChannel
                        required property real sizeRatio
                        required property string iconUrl
                        required property bool showDialog
                        required property color bColor
                        width: (parent.width + parent.spacing) / parent.columns - parent.spacing
                        height: (parent.height + parent.spacing) / gridSystem.rows - parent.spacing
                        text: name
                        channel: btnchannel
                        disEnableChannel: disBtnChannel
                        source: iconUrl
                        confirm: showDialog
                        //btnColor: bColor
                        btnCheckColor: Qt.darker(bColor, 1.4)
                    }
                }
            }
        }

        Category {
            widthRatio: 0.5
            label: qsTr("显示模式")
            content: Grid {
                id: gridMode
                rows: 3
                anchors.fill: parent
                columns: Math.ceil(modeList.count / rows)
                spacing: height * 0.05
                Repeater {
                    model: ListModel {
                        id: modeList
                        ListElement {
                            name: qsTr("华为视频会议")
                            btnchannel: 61
                            iconUrl: "qrc:/content/icons/shipinhuiyi.png"
                            disableChannel: 4
                        }
                        ListElement {
                            name: qsTr("远程视频会议")
                            btnchannel: 62
                            iconUrl: "qrc:/content/icons/shipinhuiyi.png"
                            disableChannel: 4
                        }
                        ListElement {
                            name: qsTr("内网电脑")
                            btnchannel: 63
                            iconUrl: "qrc:/content/icons/zhuji.png"
                            disableChannel: 4
                        }
                        ListElement {
                            name: qsTr("外网电脑")
                            btnchannel: 64
                            iconUrl: "qrc:/content/icons/zhuji.png"
                            disableChannel: 4
                        }
                        ListElement {
                            name: qsTr("无线投屏")
                            btnchannel: 65
                            iconUrl: "qrc:/content/icons/wuxiantouping.png"
                            disableChannel: 4
                        }
                    }
                    delegate: VButton {
                        required property string name
                        required property int btnchannel
                        required property string iconUrl
                        required property int disableChannel
                        disEnableChannel: disableChannel
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
