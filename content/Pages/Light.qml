import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

import "../Custom"

Item {
    implicitWidth: parent.width
    implicitHeight: parent.height

    Row {
        id: row
        anchors.fill: parent
        spacing: width * 0.02

        Category {
            widthRatio: 0.68
            Column {
                anchors.fill: parent
                anchors.rightMargin: item.width * 0.03
                anchors.leftMargin: item.width * 0.03
                anchors.topMargin: item.width * 0.02
                anchors.bottomMargin: item.width * 0.02
                spacing: height * 0.05
                MyLable {
                    text: config.lightName
                    height: parent.height * 0.1
                }
                Grid {
                    id: grid
                    width: parent.width
                    height: parent.height * 0.85
                    columns: 3
                    spacing: height * 0.05
                    Repeater {
                        model: config.lightList
                        delegate: LightButton {
                            required property int btnChannel
                            required property string name
                            text: name
                            channel: btnChannel
                            width: (grid.width + grid.spacing) / grid.columns - grid.spacing
                            height: (grid.height + grid.spacing) / config.lightList.count
                                    * grid.columns - grid.spacing
                        }
                    }
                }
            }
        }

        Category {
            widthRatio: 0.3
            Column {
                anchors.fill: parent
                anchors.rightMargin: item.width * 0.03
                anchors.leftMargin: item.width * 0.03
                anchors.topMargin: item.width * 0.02
                anchors.bottomMargin: item.width * 0.02
                spacing: height * 0.05
                MyLable {
                    text: config.lightModeName
                    height: parent.height * 0.1
                }
                Repeater {
                    model: config.lightModeList
                    delegate: MyButton {
                        id: myButton
                        required property string name
                        required property int btnchannel
                        required property string iconUrl
                        width: parent.width
                        height: parent.height * 0.9 / config.lightModeList.count - parent.spacing
                        text: name
                        channel: btnchannel
                        icon.source: iconUrl
                    }
                }
            }
        }
    }
}
