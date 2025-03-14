import QtQuick
import QtQuick.Controls

import "../../Custom"

Item {
    implicitWidth: parent.width
    implicitHeight: parent.height
    Row {
        anchors.fill: parent
        spacing: width * 0.02
        Repeater {
            id: repeater
            model: ListModel {
                id: volumeList
                ListElement {
                    name: qsTr("鹅颈话筒")
                    vChannel: 11
                    mChannel: 51
                    minVol: -40
                    maxVol: 0
                    inputType: true
                }
                ListElement {
                    name: qsTr("手持话筒")
                    vChannel: 12
                    mChannel: 52
                    minVol: -40
                    maxVol: 0
                    inputType: true
                }
                ListElement {
                    name: qsTr("电脑音频")
                    vChannel: 13
                    mChannel: 53
                    minVol: -40
                    maxVol: 5
                    inputType: true
                }

                ListElement {
                    name: qsTr("外接音频")
                    vChannel: 14
                    mChannel: 54
                    minVol: -40
                    maxVol: 5
                    inputType: true
                }

                ListElement {
                    name: qsTr("总音量")
                    vChannel: 15
                    mChannel: 55
                    minVol: -40
                    maxVol: 5
                    inputType: false
                }
            }

            delegate: Category {
                widthRatio: 1 / volumeList.count
                required property string name
                required property int vChannel
                required property int mChannel
                required property int minVol
                required property int maxVol
                required property bool inputType
                label: name
                content: VolumeBar {
                    anchors.fill: parent
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
