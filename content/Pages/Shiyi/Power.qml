import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import QtQuick.Effects

import "../../Custom"

Item {
    implicitWidth: parent.width
    implicitHeight: parent.height
    Row {
        anchors.fill: parent
        spacing: width * 0.02
        Category {
            widthRatio: 0.3
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
                        width: (parent.width + parent.spacing) / parent.columns - parent.spacing
                        height: (parent.height + parent.spacing) / gridTV.rows - parent.spacing
                        text: name
                        channel: btnchannel
                        source: iconUrl
                    }
                }
            }
        }
        Category {
            widthRatio: 0.3
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
                        width: (parent.width + parent.spacing) / parent.columns - parent.spacing
                        height: (parent.height + parent.spacing) / gridCamera.rows - parent.spacing
                        text: name
                        channel: btnchannel
                        source: iconUrl
                    }
                }
            }
        }
    }
}
