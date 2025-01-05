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
            lable: qsTr("会议模式")
            content: Column {
                anchors.fill: parent
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
                        width: parent.width
                        height: (parent.height * (Global.settings.tabOnBottom ? 1 : 0.8)
                                 + parent.spacing) / systemList.count - parent.spacing
                        text: name
                        channel: btnchannel
                        disEnableChannel: disBtnChannel
                        source: iconUrl
                        confirm: showDialog
                        btnColor: bColor
                    }
                }
            }
        }

        Category {
            widthRatio: 0.5
            lable: qsTr("信号选择")
            content: Grid {
                anchors.fill: parent
                columns: Math.ceil(modeList.count / 3)
                spacing: height * 0.05
                Repeater {
                    model: ListModel {
                        id: modeList
                        ListElement {
                            name: qsTr("院内视频会议")
                            btnchannel: 41
                            iconUrl: "qrc:/content/icons/shipinhuiyi.png"
                        }
                        ListElement {
                            name: qsTr("远程视频会议")
                            btnchannel: 42
                            iconUrl: "qrc:/content/icons/shipinhuiyi.png"
                        }
                        ListElement {
                            name: qsTr("内网电脑")
                            btnchannel: 43
                            iconUrl: "qrc:/content/icons/zhuji.png"
                        }
                        ListElement {
                            name: qsTr("外网电脑")
                            btnchannel: 44
                            iconUrl: "qrc:/content/icons/zhuji.png"
                        }
                        ListElement {
                            name: qsTr("无线投屏")
                            btnchannel: 45
                            iconUrl: "qrc:/content/icons/wuxiantouping.png"
                        }
                    }
                    delegate: VButton {
                        id: myButton
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
