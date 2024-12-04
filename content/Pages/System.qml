import QtQuick
import QtQuick.Controls

import "../Custom"

Item {
    implicitWidth: parent.width
    implicitHeight: parent.height

    Row {
        id: row
        anchors.fill: parent
        spacing: width * 0.02
        Category {
            widthRatio: config.systemVolumeRatio
            lable: config.volumeList.get(4).name
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.04
                VolumeBar {
                    height: parent.height
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    channel: config.volumeList.get(4).vChannel
                    muteChannel: config.volumeList.get(4).mChannel
                    miniVolume: config.volumeList.get(4).minVol
                    maxVolume: config.volumeList.get(4).maxVol
                    input: config.volumeList.get(4).inputType
                }
            }
        }

        Category {
            widthRatio: config.systemPowerRatio
            lable: config.systemPowerName
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.05
                Repeater {
                    id: listMode
                    model: config.systemPowerList
                    delegate: MyButton {
                        required property string name
                        required property int btnchannel
                        required property int disBtnChannel
                        required property real sizeRatio
                        required property string iconUrl
                        required property bool showDialog
                        required property color bColor
                        width: parent.width
                        height: (parent.height - parent.spacing)
                                / config.systemPowerList.count - parent.spacing
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
            widthRatio: config.systemSignalRatio
            lable: config.systemSignalName
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.04
                Repeater {
                    model: config.systemSignalList
                    delegate: MyButton {
                        id: myButton
                        required property string name
                        required property int btnchannel
                        required property string iconUrl
                        width: parent.width
                        height: (parent.height + parent.spacing)
                                / config.systemSignalList.count - parent.spacing
                        text: name
                        channel: btnchannel
                        icon.source: iconUrl
                    }
                }
            }
        }
    }
}
