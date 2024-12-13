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
                    vChannel: 5
                    mChannel: 51
                    minVol: -40
                    maxVol: 0
                    inputType: true
                }
                ListElement {
                    name: qsTr("手持话筒")
                    vChannel: 6
                    mChannel: 52
                    minVol: -40
                    maxVol: 0
                    inputType: true
                }
                ListElement {
                    name: qsTr("电脑音频")
                    vChannel: 7
                    mChannel: 53
                    minVol: -40
                    maxVol: 5
                    inputType: true
                }

                ListElement {
                    name: qsTr("外接音频")
                    vChannel: 8
                    mChannel: 54
                    minVol: -40
                    maxVol: 5
                    inputType: true
                }

                ListElement {
                    name: qsTr("总音量")
                    vChannel: 9
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
                lable: name
                Rectangle {
                    anchors.fill: parent
                    anchors.topMargin: parent.height * 0.15
                    anchors.bottomMargin: parent.height * 0.04
                    anchors.leftMargin: parent.height * 0.04
                    anchors.rightMargin: anchors.leftMargin
                    color: "transparent"
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
