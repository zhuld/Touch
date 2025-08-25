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
            label: qsTr("网页")
            content: Grid {
                id: gridWeb
                rows: 3
                anchors.fill: parent
                columns: Math.ceil(listOutput.count / rows)
                spacing: height * 0.05
                Repeater {
                    model: ListModel {
                        id: listOutput
                        ListElement {
                            name: qsTr("Baidu")
                            btnchannel: 81
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/web.png"
                        }
                        ListElement {
                            name: qsTr("Bing")
                            btnchannel: 82
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/web.png"
                        }
                        ListElement {
                            name: qsTr("Action")
                            btnchannel: 83
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/web.png"
                        }
                        ListElement {
                            name: qsTr("Clock")
                            btnchannel: 84
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/web.png"
                        }
                    }
                    delegate: VButton {
                        required property string name
                        required property int btnchannel
                        required property int disBtnChannel
                        required property string iconUrl
                        width: (parent.width + gridWeb.spacing) / gridWeb.columns - gridWeb.spacing
                        height: (parent.height + gridWeb.spacing) / gridWeb.rows - gridWeb.spacing
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
                            btnchannel: 86
                            iconUrl: "qrc:/content/icons/tingzhibofang.png"
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
