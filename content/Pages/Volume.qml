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
            model: ListModel {
                id: volList
                ListElement {
                    name: "鹅颈话筒输入"
                    vChannel: 5
                    mChannel: 41
                    miniVol: -40
                    maxVol: 20
                    inputType: true
                }
                ListElement {
                    name: "手持话筒输入"
                    vChannel: 6
                    mChannel: 42
                    miniVol: -40
                    maxVol: 5
                    inputType: true
                }
                ListElement {
                    name: "音频输入"
                    vChannel: 7
                    mChannel: 43
                    miniVol: -30
                    maxVol: 10
                    inputType: true
                }

                ListElement {
                    name: "总音量输出"
                    vChannel: 8
                    mChannel: 44
                    miniVol: -40
                    maxVol: 0
                    inputType: false
                }

                ListElement {
                    name: "总音量输出"
                    vChannel: 8
                    mChannel: 44
                    miniVol: -40
                    maxVol: 0
                    inputType: false
                }
            }

            delegate: Category {
                widthRatio: 1 / volList.count
                required property string name
                required property int vChannel
                required property int mChannel
                required property int miniVol
                required property int maxVol
                required property bool inputType
                Column {
                    anchors.fill: parent
                    anchors.margins: item.width * 0.02
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
