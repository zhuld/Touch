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
            widthRatio: 0.35
            lable: qsTr("输出")
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.05
                Repeater {
                    model: ListModel {
                        id: outputList
                        ListElement {
                            name: qsTr("大屏左")
                            btnchannel: 163
                            disBtnChannel: 0
                            sizeRatio: 1
                            iconUrl: "qrc:/content/icons/pingmugongxiang.png"
                        }
                        ListElement {
                            name: qsTr("大屏右")
                            btnchannel: 164
                            disBtnChannel: 0
                            sizeRatio: 1
                            iconUrl: "qrc:/content/icons/pingmugongxiang.png"
                        }
                        ListElement {
                            name: qsTr("地插输出")
                            btnchannel: 161
                            disBtnChannel: 0
                            sizeRatio: 1
                            iconUrl: "qrc:/content/icons/HDMIjiekou.png"
                        }
                    }

                    delegate: MyButton {
                        required property string name
                        required property int btnchannel
                        required property int disBtnChannel
                        required property string iconUrl
                        width: parent.width
                        height: (parent.height * 0.75 + parent.spacing)
                                / outputList.count - parent.spacing
                        text: name
                        channel: btnchannel
                        disEnableChannel: disBtnChannel
                        icon.source: iconUrl
                    }
                }
            }
        }

        Category {
            widthRatio: 0.65
            lable: qsTr("输入信号")
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.04
                Grid {
                    width: parent.width
                    height: parent.height * 0.9
                    columns: 2
                    spacing: height * 0.05
                    Repeater {
                        model: ListModel {
                            id: inputList
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
                        delegate: MyButton {
                            required property string name
                            required property int btnchannel
                            required property string iconUrl
                            width: (parent.width + parent.spacing) / parent.columns - parent.spacing
                            height: (parent.height + parent.spacing) / inputList.count
                                    * parent.columns - parent.spacing
                            text: name
                            channel: btnchannel
                            icon.source: iconUrl
                        }
                    }
                }
            }
        }
    }
}
