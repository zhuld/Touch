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
            lable: qsTr("输出")
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
                    columns: Math.ceil(listOutput.count / 3)
                    spacing: height * 0.1
                    Repeater {
                        model: ListModel {
                            id: listOutput
                            ListElement {
                                name: qsTr("主窗口")
                                btnchannel: 160
                                disBtnChannel: 0
                                iconUrl: "qrc:/content/icons/pingmugongxiang.png"
                            }
                            ListElement {
                                name: qsTr("画中画")
                                btnchannel: 162
                                disBtnChannel: 0
                                iconUrl: "qrc:/content/icons/pingmugongxiang.png"
                            }
                            ListElement {
                                name: qsTr("开窗模式")
                                btnchannel: 171
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
                            height: (parent.height + parent.spacing) / 3 - parent.spacing
                            text: name
                            channel: btnchannel
                            disEnableChannel: disBtnChannel
                            source: iconUrl
                        }
                    }
                }
            }
        }

        Category {
            widthRatio: 0.4
            lable: qsTr("输入信号")
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
                    columns: Math.ceil(listInput.count / 3)
                    spacing: height * 0.1
                    Repeater {
                        model: ListModel {
                            id: listInput
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
                            height: (parent.height + parent.spacing) / 3 - parent.spacing
                            text: name
                            channel: btnchannel
                            source: iconUrl
                        }
                    }
                }
            }
        }

        Category {
            widthRatio: 0.3
            lable: qsTr("智能模式")
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
                    columns: Math.ceil(remoteMode.count / 3)
                    spacing: height * 0.1
                    Repeater {
                        model: ListModel {
                            id: remoteMode
                            ListElement {
                                name: qsTr("自动跟踪")
                                btnchannel: 173
                                iconUrl: "qrc:/content/icons/camera.png"
                            }
                            ListElement {
                                name: qsTr("手写提取")
                                btnchannel: 174
                                iconUrl: "qrc:/content/icons/shouxie.png"
                            }
                            ListElement {
                                name: qsTr("无绿幕抠像")
                                btnchannel: 175
                                iconUrl: "qrc:/content/icons/kouxiang.png"
                            }
                        }
                        delegate: VButton {
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
