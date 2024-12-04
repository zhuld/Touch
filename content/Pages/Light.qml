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
            widthRatio: config.lightRatio
            lable: config.lightName
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.04
                Grid {
                    id: grid
                    width: parent.width
                    height: parent.height
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
            widthRatio: config.lightModeRatio
            lable: config.lightModeName
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.04
                Repeater {
                    model: config.lightModeList
                    delegate: MyButton {
                        id: myButton
                        required property string name
                        required property int btnchannel
                        required property string iconUrl
                        width: parent.width
                        height: (parent.height + parent.spacing)
                                / config.lightModeList.count - parent.spacing
                        text: name
                        channel: btnchannel
                        icon.source: iconUrl
                    }
                }
            }
        }
    }
}
