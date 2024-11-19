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
                widthRatio: 0.98 / config.volumeList.count
                required property string name
                required property int vChannel
                required property int mChannel
                required property int miniVol
                required property int maxVol
                required property bool inputType
                Column {
                    anchors.fill: parent
                    anchors.rightMargin: item.width * 0.02
                    anchors.leftMargin: item.width * 0.02
                    anchors.topMargin: item.width * 0.02
                    anchors.bottomMargin: item.width * 0.03
                    spacing: height * 0.05
                    MyLable {
                        text: name
                        height: parent.height * 0.1
                    }
                    VolumeBar {
                        height: parent.height * 0.9 - parent.spacing
                        width: parent.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        channel: vChannel
                        muteChannel: mChannel
                        miniVolume: miniVol
                        maxVolume: maxVol
                        input: inputType
                    }
                }
            }
        }
    }
}
