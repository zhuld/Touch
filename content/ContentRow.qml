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

    ListModel {
        id: filteredModel
    }
    ProcessDialog {
        id: processDialog
        dialogInfomation: "正在执行指令，请稍后..."
        dialogTitle: "提示"
        channel: config.processDialogChannel
        autoClose: 50
    }
    Row {
        id: tabBar
        width: parent.width * 0.98
        height: parent.height * 0.15
        x: (width - height * filteredModel.count) / (filteredModel.count + 1)
        anchors.bottom: parent.bottom
        Repeater {
            id: repeater
            model: filteredModel
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
        spacing: (width - height * filteredModel.count) / (filteredModel.count + 1)
    }
    SwipeView {
        id: stackLayout
        anchors.top: parent.top
        width: parent.width
        height: parent.height - tabBar.height
        Repeater {
            model: filteredModel
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
        filteredModel.clear()
        // Loop through original model and add filtered items to filteredModel
        for (var i = 0; i < config.pageList.count; i++) {
            var item = config.pageList.get(i)
            if (!item.test || Global.settings.showChannel) {
                filteredModel.append(item)
            }
        }
    }
    Connections {
        target: settingDialog
        onShowChannelChanged: {
            filteredModel.clear()
            for (var i = 0; i < config.pageList.count; i++) {
                var item = config.pageList.get(i)
                if (!item.test || Global.settings.showChannel) {
                    filteredModel.append(item)
                }
            }
        }
    }
}
