import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "./Custom"
import "./Pages"

Item {
    id: main
    anchors.fill: parent
    //anchors.bottomMargin: parent.width * 0.02
    anchors.leftMargin: parent.width * 0.02

    ListModel {
        id: filteredModel
    }

    Column {
        id: tabBar
        property int currentPage: 0
        width: parent.width * 0.1
        height: parent.height - parent.width * 0.02
        anchors.margins: 0
        spacing: height / repeater.model.count * 0.1
        Repeater {
            id: repeater
            model: filteredModel
            delegate: MyTabButton {
                id: tabButton
                required property string name
                required property string iconUrl
                required property int index
                text: name
                width: parent.width
                //height: width
                height: (parent.height + parent.spacing) / repeater.model.count - parent.spacing
                icon.source: iconUrl
                onClicked: {
                    if (tabBar.currentPage !== index) {
                        tabBar.currentPage = index
                    }
                }
                Component.onCompleted: {
                    if (index === tabBar.currentPage) {
                        tabButton.checked = true
                    }
                }
            }
        }
    }
    StackLayout {
        anchors.right: parent.right
        width: parent.width * 0.98 - tabBar.width
        height: parent.height
        clip: true
        currentIndex: tabBar.currentPage
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
            repeater.itemAt(0).checked = true
        }
    }
}
