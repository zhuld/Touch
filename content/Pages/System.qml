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
            widthRatio: 0.19
            Column {
                anchors.fill: parent
                anchors.rightMargin: item.width * 0.02
                anchors.leftMargin: item.width * 0.02
                anchors.topMargin: item.width * 0.02
                anchors.bottomMargin: item.width * 0.03
                spacing: height * 0.05
                MyLable {
                    text: config.systemVolumeName
                    height: parent.height * 0.1
                }
                VolumeBar {
                    height: parent.height * 0.9 - parent.spacing
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    channel: config.systemVolumeChannel
                    muteChannel: config.systemVolumeMuteChannel
                    miniVolume: config.systemVolumeMiniVolume
                    maxVolume: config.systemVolumeMaxVolume
                    input: config.systemVolumeInput
                }
            }
        }

        Category {
            widthRatio: 0.38
            Column {
                anchors.fill: parent
                anchors.rightMargin: item.width * 0.03
                anchors.leftMargin: item.width * 0.03
                anchors.topMargin: item.width * 0.02
                anchors.bottomMargin: item.width * 0.02
                spacing: height * 0.05
                MyLable {
                    text: config.systemPowerName
                    height: parent.height * 0.1
                }
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
                        height: parent.height * 0.2 * sizeRatio
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
            widthRatio: 0.41
            Column {
                anchors.fill: parent
                anchors.rightMargin: item.width * 0.03
                anchors.leftMargin: item.width * 0.03
                anchors.topMargin: item.width * 0.02
                anchors.bottomMargin: item.width * 0.02
                spacing: height * 0.05
                MyLable {
                    text: config.systemSignalName
                    height: parent.height * 0.1
                }
                Repeater {
                    model: config.systemSignalList
                    delegate: MyButton {
                        id: myButton
                        required property string name
                        required property int btnchannel
                        required property string iconUrl
                        width: parent.width
                        height: parent.height * 0.9 / config.systemSignalList.count - parent.spacing
                        text: name
                        channel: btnchannel
                        icon.source: iconUrl
                    }
                }
            }
        }
    }
}
