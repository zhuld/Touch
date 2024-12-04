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
        Repeater {
            id: repeater
            model: config.volumeList

            delegate: Category {
                widthRatio: 1 / config.volumeList.count
                required property string name
                required property int vChannel
                required property int mChannel
                required property int minVol
                required property int maxVol
                required property bool inputType
                lable: name
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
                        channel: vChannel
                        muteChannel: mChannel
                        miniVolume: minVol
                        maxVolume: maxVol
                        input: inputType
                    }
                }
            }
        }
    }
}
