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
    Column {
        id: tabBar
        width: parent.width * 0.1
        height: parent.height - parent.width * 0.02
        anchors.margins: 0
        spacing: height * 0.03
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
                width: parent.width
                height: (parent.height + parent.spacing) / (filteredModel.count) - parent.spacing
                        < width ? (parent.height + parent.spacing)
                                  / (filteredModel.count) - parent.spacing : width
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
            model: filteredModel
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
