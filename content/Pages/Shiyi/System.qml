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
            widthRatio: 0.2
            lable: qsTr("总音量")
            Rectangle {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                color: "transparent"
                VolumeBar {
                    height: parent.height
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    channel: 9
                    muteChannel: 55
                    miniVolume: -40
                    maxVolume: 5
                    input: false
                }
            }
        }

        Category {
            widthRatio: 0.4
            lable: qsTr("会议模式")
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: parent.height * 0.05
                Repeater {
                    model: ListModel {
                        id: systemList
                        ListElement {
                            name: qsTr("显示屏会议")
                            btnchannel: 2
                            disBtnChannel: 0
                            sizeRatio: 1
                            bColor: "forestgreen"
                            iconUrl: "qrc:/content/icons/pingmugongxiang.png"
                            showDialog: true
                        }
                        ListElement {
                            name: qsTr("普通会议")
                            btnchannel: 3
                            disBtnChannel: 0
                            sizeRatio: 1
                            bColor: "forestgreen"
                            iconUrl: "qrc:/content/icons/huiyizanzhuyantao.png"
                            showDialog: true
                        }
                        ListElement {
                            name: qsTr("结束会议")
                            btnchannel: 4
                            disBtnChannel: 0
                            sizeRatio: 1
                            bColor: "tomato"
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
                        height: (parent.height * 0.8 + parent.spacing)
                                / systemList.count - parent.spacing
                        text: name
                        channel: btnchannel
                        disEnableChannel: disBtnChannel
                        icon.source: iconUrl
                        confirm: showDialog
                        btnColor: bColor
                    }
                }
            }
        }

        Category {
            widthRatio: 0.4
            lable: qsTr("信号选择")
            Rectangle {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                color: "transparent"
                Grid {
                    width: parent.width
                    height: parent.height
                    columns: Math.ceil(modeList.count / 3)
                    spacing: height * 0.1
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
}
