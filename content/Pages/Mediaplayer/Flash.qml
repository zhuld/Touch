pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

Item {
    anchors.fill: parent
    RowLayout {
        anchors.fill: parent
        Category {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumWidth: parent.width * 0.5
            Layout.rightMargin: parent.width * 0.02
            Layout.bottomMargin: parent.width * 0.02
            label: qsTr("Flash内容")
            content: Grid {
                id: gridFlash
                rows: 3
                anchors.fill: parent
                columns: Math.ceil(listOutput.count / rows)
                spacing: height * 0.05
                Repeater {
                    model: ListModel {
                        id: listOutput
                        ListElement {
                            name: qsTr("Flash 1")
                            btnchannel: 61
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/Flash.png"
                        }
                        ListElement {
                            name: qsTr("Flash 2")
                            btnchannel: 62
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/Flash.png"
                        }
                        ListElement {
                            name: qsTr("Flash 3")
                            btnchannel: 63
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/Flash.png"
                        }
                        ListElement {
                            name: qsTr("Flash 4")
                            btnchannel: 64
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/Flash.png"
                        }
                        ListElement {
                            name: qsTr("Flash 5")
                            btnchannel: 65
                            disBtnChannel: 0
                            iconUrl: "qrc:/content/icons/Flash.png"
                        }
                    }
                    delegate: VButton {
                        required property string name
                        required property int btnchannel
                        required property int disBtnChannel
                        required property string iconUrl
                        width: (parent.width + gridFlash.spacing)
                               / gridFlash.columns - gridFlash.spacing
                        height: (parent.height + gridFlash.spacing)
                                / gridFlash.rows - gridFlash.spacing
                        text: name
                        channel: btnchannel
                        disEnableChannel: disBtnChannel
                        source: iconUrl
                    }
                }
            }
        }

        Rectangle {
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumWidth: parent.width * 0.5
            Layout.rightMargin: parent.width * 0.02
            Layout.bottomMargin: parent.width * 0.02
        }
    }
}
