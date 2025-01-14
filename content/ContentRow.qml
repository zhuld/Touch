import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

import "./Custom"
import "./Pages"
import "./Dialog"

Item {
    id: main
    anchors.fill: parent
    anchors.leftMargin: parent.width * 0.02
    anchors.bottomMargin: parent.width * 0.02

    ProcessDialog {
        id: processDialog
        dialogInfomation: "正在执行指令，请稍后..."
        dialogTitle: "提示"
        channel: Global.config.processDialogChannel
        autoClose: 50
    }
    Row {
        id: tabBar
        width: parent.width * 0.98
        height: parent.height * 0.15
        x: (width - height * Global.tabList.count) / (Global.tabList.count + 1)
        anchors.bottom: parent.bottom
        Repeater {
            id: repeater
            model: Global.tabList
            delegate: MyTabButton {
                id: tabButton
                required property string name
                required property string iconUrl
                required property int index
                required property int pageChannel
                text: name
                width: parent.height
                height: parent.height
                source: iconUrl
                channel: pageChannel
                onCheckedChanged: {
                    if (checked & stackLayout.currentIndex !== index) {
                        stackLayout.currentIndex = index
                    }
                }
            }
        }
        spacing: (width - height * Global.tabList.count) / (Global.tabList.count + 1)
    }
    SwipeView {
        id: stackLayout
        anchors.top: parent.top
        width: parent.width
        height: parent.height - tabBar.height
        Repeater {
            model: Global.tabList
            delegate: Loader {
                required property string pageUrl
                id: pageLoader
                source: pageUrl
            }
        }
        orientation: Qt.Horizontal
        spacing: parent.width / 10
        interactive: false
        clip: true
        Component.onCompleted: contentItem.highlightMoveDuration = 0
    }
    Component.onCompleted: {
        // Clear the filtered model
        Global.tabList.clear()
        // Loop through original model and add filtered items to Global.tabList
        for (var i = 0; i < Global.config.pageList.count; i++) {
            var item = Global.config.pageList.get(i)
            if (!item.test || Global.settings.showChannel) {
                Global.tabList.append(item)
            }
        }
    }
    Connections {
        target: settingDialog
        onShowChannelChanged: {
            Global.tabList.clear()
            for (var i = 0; i < Global.config.pageList.count; i++) {
                var item = Global.config.pageList.get(i)
                if (!item.test || Global.settings.showChannel) {
                    Global.tabList.append(item)
                }
            }
        }
    }
}
