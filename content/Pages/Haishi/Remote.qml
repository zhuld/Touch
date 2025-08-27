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
            Layout.maximumWidth: parent.width * 0.25
            Layout.rightMargin: parent.width * 0.02
            Layout.bottomMargin: parent.width * 0.02
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
                        width: (gridOutput.width + gridOutput.spacing)
                               / gridOutput.columns - gridOutput.spacing
                        height: (gridOutput.height + gridOutput.spacing)
                                / gridOutput.rows - gridOutput.spacing
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
                        width: (gridInput.width + gridInput.spacing)
                               / gridInput.columns - gridInput.spacing
                        height: (gridInput.height + gridInput.spacing)
                                / gridInput.rows - gridInput.spacing
                        text: name
                        channel: btnchannel
                        source: iconUrl
                    }
                }
            }
        }

        Category {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumWidth: parent.width * 0.25
            Layout.rightMargin: parent.width * 0.02
            Layout.bottomMargin: parent.width * 0.02
            label: qsTr("智能模式")
            content: Grid {
                id: gridRemote
                rows: 3
                anchors.fill: parent
                columns: Math.ceil(remoteMode.count / rows)
                spacing: height * 0.05
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
                        width: (gridRemote.width + gridRemote.spacing)
                               / gridRemote.columns - gridRemote.spacing
                        height: (gridRemote.height + gridRemote.spacing)
                                / gridRemote.rows - gridRemote.spacing
                        text: name
                        channel: btnchannel
                        source: iconUrl
                    }
                }
            }
        }
    }
}
