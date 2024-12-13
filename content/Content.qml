import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./Custom"
import "./Pages"

Item {
    id: main
    anchors.fill: parent
    anchors.leftMargin: parent.width * 0.02

    ListModel {
        id: filteredModel
    }

    Column {
        id: tabBar
        //property int currentPage: 10
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
                icon.source: iconUrl
                channel: pageChannel
                onCheckedChanged: {
                    if (checked) {
                        if (stackLayout.currentIndex !== index) {
                            stackLayout.currentIndex = index
                        }
                    }
                }
            }
        }
    }
    StackLayout {
        id: stackLayout
        anchors.right: parent.right
        width: parent.width * 0.98 - tabBar.width
        height: parent.height
        Repeater {
            model: filteredModel
            delegate: Loader {
                required property string pageUrl
                source: pageUrl
            }
        }
    }
    Component.onCompleted: {
        // Clear the filtered model
        filteredModel.clear()
        // Loop through original model and add filtered items to filteredModel
        for (var i = 0; i < config.pageList.count; i++) {
            var item = config.pageList.get(i)
            if (!item.test || root.settings.showChannel) {
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
                if (!item.test || root.settings.showChannel) {
                    filteredModel.append(item)
                }
            }
        }
    }
}
