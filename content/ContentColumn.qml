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

    ProcessDialog {
        id: processDialog
        dialogInfomation: "正在执行指令，请稍后..."
        dialogTitle: "提示"
        channel: Global.config.processDialogChannel
        autoClose: 50
    }
    Column {
        id: tabBar
        width: parent.width * 0.1
        height: parent.height - parent.width * 0.02
        anchors.margins: 0
        spacing: height * 0.03
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
                width: parent.width
                height: (parent.height + parent.spacing) / (Global.tabList.count) - parent.spacing
                        < width ? (parent.height + parent.spacing)
                                  / (Global.tabList.count) - parent.spacing : width
                source: iconUrl
                channel: pageChannel
                onCheckedChanged: {
                    if (checked & stackLayout.currentIndex !== index) {
                        stackLayout.currentIndex = index
                    }
                }
            }
        }
    }
    SwipeView {
        id: stackLayout
        anchors.right: parent.right
        width: parent.width * 0.98 - tabBar.width
        height: parent.height
        Repeater {
            model: Global.tabList
            delegate: Loader {
                required property string pageUrl
                id: pageLoader
                source: pageUrl
            }
        }
        spacing: parent.height / 10
        orientation: Qt.Vertical
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
