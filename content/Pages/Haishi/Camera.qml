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
            Layout.maximumWidth: parent.width * 0.55
            Layout.rightMargin: parent.width * 0.02
            Layout.bottomMargin: parent.width * 0.02
            label: qsTr("摄像机控制")
            content: ControlPad {
                id: dpadControl
                width: parent.width * 1.3 > parent.height ? parent.height / 1.3 : parent.width
                height: width * 1.3
                anchors.horizontalCenter: parent.horizontalCenter
                channel: 52
            }
        }
        Category {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumWidth: parent.width * 0.45
            Layout.rightMargin: parent.width * 0.02
            Layout.bottomMargin: parent.width * 0.02
            label: qsTr("预置位")
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
                            btnchannel: 58
                            name: "正常"
                            iconUrl: "qrc:/content/icons/shexiangtou.png"
                        }
                        ListElement {
                            btnchannel: 59
                            name: "全景"
                            iconUrl: "qrc:/content/icons/shexiangtou.png"
                        }
                        ListElement {
                            btnchannel: 60
                            name: "特写"
                            iconUrl: "qrc:/content/icons/shexiangtou.png"
                        }
                        ListElement {
                            btnchannel: 61
                            name: "白板"
                            iconUrl: "qrc:/content/icons/shexiangtou.png"
                        }
                        ListElement {
                            btnchannel: 62
                            name: "预置位5"
                            iconUrl: "qrc:/content/icons/shexiangtou.png"
                        }
                        ListElement {
                            btnchannel: 63
                            name: "预置位6"
                            iconUrl: "qrc:/content/icons/shexiangtou.png"
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
    }
}
