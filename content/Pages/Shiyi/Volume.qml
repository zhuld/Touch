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
                    vLevel: 0
                    mChannel: 51
                    minVol: -30
                    maxVol: 0
                    inputType: true
                }
                ListElement {
                    name: qsTr("手持话筒")
                    vChannel: 12
                    vLevel: 0
                    mChannel: 52
                    minVol: -30
                    maxVol: 0
                    inputType: true
                }
                ListElement {
                    name: qsTr("屏幕音频")
                    vChannel: 13
                    vLevel: 0
                    mChannel: 53
                    minVol: -30
                    maxVol: 0
                    inputType: true
                }

                ListElement {
                    name: qsTr("外接音频")
                    vChannel: 14
                    vLevel: 0
                    mChannel: 54
                    minVol: -30
                    maxVol: 0
                    inputType: true
                }

                ListElement {
                    name: qsTr("总音量")
                    vChannel: 15
                    vLevel: 0
                    mChannel: 55
                    minVol: -40
                    maxVol: 0
                    inputType: false
                }
            }

            delegate: Category {
                widthRatio: 1 / volumeList.count
                required property string name
                required property int vChannel
                required property int vLevel
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
                    level: vLevel
                }
            }
        }
    }
}
