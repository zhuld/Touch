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
            Layout.maximumWidth: parent.width * 0.3
            Layout.rightMargin: parent.width * 0.02
            Layout.bottomMargin: parent.width * 0.02
            label: qsTr("显示屏")
            content: Grid {
                id: gridTV
                rows: 3
                anchors.fill: parent
                columns: Math.ceil(tvList.count / rows)
                spacing: height * 0.05
                Repeater {
                    model: ListModel {
                        id: tvList
                        ListElement {
                            name: qsTr("开机")
                            btnchannel: 71
                            iconUrl: "qrc:/content/icons/kaiji.png"
                        }
                        ListElement {
                            name: qsTr("关机")
                            btnchannel: 72
                            iconUrl: "qrc:/content/icons/kaiji.png"
                        }
                    }
                    delegate: VButton {
                        required property string name
                        required property int btnchannel
                        required property string iconUrl
                        width: (gridTV.width + gridTV.spacing) / gridTV.columns - gridTV.spacing
                        height: (gridTV.height + gridTV.spacing) / gridTV.rows - gridTV.spacing
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
            Layout.maximumWidth: parent.width * 0.3
            Layout.rightMargin: parent.width * 0.02
            Layout.bottomMargin: parent.width * 0.02
            label: qsTr("摄像机")
            content: Grid {
                id: gridCamera
                rows: 3
                anchors.fill: parent
                columns: Math.ceil(cameraList.count / rows)
                spacing: height * 0.05
                Repeater {
                    model: ListModel {
                        id: cameraList
                        ListElement {
                            name: qsTr("开机")
                            btnchannel: 75
                            iconUrl: "qrc:/content/icons/kaiji.png"
                        }
                        ListElement {
                            name: qsTr("关机")
                            btnchannel: 76
                            iconUrl: "qrc:/content/icons/kaiji.png"
                        }
                    }
                    delegate: VButton {
                        required property string name
                        required property int btnchannel
                        required property string iconUrl
                        width: (gridCamera.width + gridCamera.spacing)
                               / gridCamera.columns - gridCamera.spacing
                        height: (gridCamera.height + gridCamera.spacing)
                                / gridCamera.rows - gridCamera.spacing
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
            Layout.maximumWidth: parent.width * 0.4
            Layout.rightMargin: parent.width * 0.02
            Layout.bottomMargin: parent.width * 0.02
        }
    }
}
