import QtQuick
import QtQuick.Controls

import "./Custom"

Item {
    id: connectPage
    anchors.fill: parent
    anchors.margins: width * 0.02

    Column {
        width: parent.width
        height: parent.height
        spacing: height * 0.08
        Row {
            width: parent.width
            height: parent.height * 0.3
            spacing: width * 0.05
            Text {
                id: timeText
                width: parent.width * 0.58
                height: parent.height
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.8
                color: Global.buttonTextColor
                font.family: Global.lcdFont.font.family
                Text {
                    width: parent.width
                    height: parent.height
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: height * 0.8
                    opacity: 0.03
                    font.family: Global.lcdFont.font.family
                    text: "88:88:88"
                }
            }
            Rectangle {
                height: parent.height * 0.6
                y: parent.height * 0.2
                width: 2
                color: Global.buttonTextColor
            }
            Text {
                id: dateText
                width: parent.width * 0.32
                height: parent.height
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.23
                color: Global.buttonTextColor
                font.family: Global.alibabaPuHuiTi.font.family
            }
            Timer {
                id: timer
                property bool space: true
                interval: 500
                repeat: true
                running: true
                triggeredOnStart: true
                onTriggered: {
                    dateText.text = new Date().toLocaleDateString(
                                Qt.locale("zh_CN"), "yy年MM月dd日\n\rdddd")
                    if (space) {
                        timeText.text = new Date().toLocaleTimeString(
                                    Qt.locale("zh_CN"), "hh mm ss")
                    } else {
                        timeText.text = new Date().toLocaleTimeString(
                                    Qt.locale("zh_CN"), "hh:mm:ss")
                    }
                    space = !space
                }
            }
        }
        ScrollView {
            id: scrollView
            width: parent.width
            height: parent.height * 0.6
            clip: true
            Column {
                width: scrollView.width
                spacing: scrollView.height * 0.05
                Repeater {
                    model: Global.configListModel
                    delegate: ColorButton {
                        text: modelData
                        x: scrollView.width * 0.05
                        width: scrollView.width * 0.9
                        height: scrollView.height * 0.25
                        visible: index === 0 ? false : true
                        onClicked: {
                            Global.settings.configSetting = index
                            Global.config = Global.configList[Global.settings.configSetting]
                        }
                    }
                }
            }
        }
    }
}
