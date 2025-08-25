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
            label: qsTr("图片内容")
            content: Grid {
                id: gridPic
                rows: 3
                anchors.fill: parent
                columns: Math.ceil(listOutput.count / rows)
                spacing: height * 0.05
                Repeater {
                    model: ListModel {
                        id: listOutput
                        ListElement {
                            name: qsTr("Picture 1")
                            btnchannel: 41
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/tupianji.png"
                        }
                        ListElement {
                            name: qsTr("Picture 2")
                            btnchannel: 42
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/tupianji.png"
                        }
                        ListElement {
                            name: qsTr("Picture 3")
                            btnchannel: 43
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/tupianji.png"
                        }
                        ListElement {
                            name: qsTr("Picture 4")
                            btnchannel: 44
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/tupianji.png"
                        }
                        ListElement {
                            name: qsTr("Picture 5")
                            btnchannel: 45
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/tupianji.png"
                        }
                    }
                    delegate: VButton {
                        required property string name
                        required property int btnchannel
                        required property int disBtnChannel
                        required property string iconUrl
                        width: (parent.width + gridPic.spacing) / gridPic.columns - gridPic.spacing
                        height: (parent.height + gridPic.spacing) / gridPic.rows - gridPic.spacing
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
            Layout.maximumWidth: parent.width * 0.2
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
                            btnchannel: 46
                            iconUrl: "qrc:/content/icons/tingzhibofang.png"
                        }
                        ListElement {
                            name: qsTr("前一幅")
                            btnchannel: 47
                            iconUrl: "qrc:/content/icons/qianyige.png"
                        }
                        ListElement {
                            name: qsTr("后一幅")
                            btnchannel: 48
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
