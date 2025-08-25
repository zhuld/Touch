pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

Item {
    implicitWidth: parent.width
    implicitHeight: parent.height
    RowLayout {
        anchors.fill: parent
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
                id: category
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumWidth: parent.width / volumeList.count
                Layout.rightMargin: parent.width * 0.02
                Layout.bottomMargin: parent.width * 0.02
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
                    channel: category.vChannel
                    muteChannel: category.mChannel
                    miniVolume: category.minVol
                    maxVolume: category.maxVol
                    input: category.inputType
                    level: category.vLevel
                }
            }
        }
    }
}
