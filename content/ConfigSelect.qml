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
                width: parent.width * 0.6
                height: parent.height
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.8
                color: Global.buttonTextColor
                font.family: Global.alibabaPuHuiTi.font.family
            }
            Rectangle {
                height: parent.height * 0.6
                y: parent.height * 0.2
                width: 2
                color: Global.buttonTextColor
            }
            Text {
                id: dateText
                width: parent.width * 0.4
                height: parent.height
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.2
                color: Global.buttonTextColor
                font.family: Global.alibabaPuHuiTi.font.family
            }
            Timer {
                id: timer
                interval: 1000
                repeat: true
                running: true
                triggeredOnStart: true
                onTriggered: {
                    dateText.text = new Date().toLocaleDateString(
                                Qt.locale("zh_CN"), "yy年MM月dd日\n\rdddd")
                    timeText.text = new Date().toLocaleTimeString(
                                Qt.locale("zh_CN"), "hh:mm:ss")
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
