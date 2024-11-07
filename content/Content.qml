import QtQuick
import QtQuick.Controls

import "./Custom"
import "./Pages"

Item {
    id: main
    anchors.fill: parent
    anchors.bottomMargin: parent.width * 0.02
    anchors.leftMargin: parent.width * 0.02
    anchors.rightMargin: parent.width * 0.02
    property int usedIndex: 0

    ListModel {
        id: filteredModel
    }

    Column {
        id: tabBar
        width: parent.height / repeater.model.count
        height: parent.height
        anchors.margins: 0
        spacing: height / repeater.model.count * 0.12

        Repeater {
            id: repeater
            model: filteredModel //root.pageList
            delegate: MyTabButton {
                id: tabButton
                required property string name
                required property string iconUrl
                required property string pageUrl
                required property int index
                text: name
                width: parent.width
                height: (parent.height + parent.spacing) / repeater.model.count - parent.spacing
                icon.source: iconUrl
                onClicked: {
                    if (usedIndex !== index) {
                        loader.setSource(pageUrl)
                        usedIndex = index
                    }
                }
                Component.onCompleted: {
                    if (index === usedIndex) {
                        tabButton.checked = true
                        loader.setSource(pageUrl)
                    }
                }
            }
        }
    }
    Loader {
        id: loader
        anchors.right: parent.right
        width: parent.width * 0.98 - tabBar.width
        height: parent.height
    }

    Component.onCompleted: {

        // Clear the filtered model
        filteredModel.clear()

        // Loop through original model and add filtered items to filteredModel
        for (var i = 0; i < root.pageList.count; i++) {
            var item = root.pageList.get(i)
            if (item.name !== "数据" || root.settings.showChannel) {
                filteredModel.append(item)
            }
        }
    }
    Connections {
        target: settingDialog
        onShowChannelChanged: {
            filteredModel.clear()
            for (var i = 0; i < root.pageList.count; i++) {
                var item = root.pageList.get(i)
                if (item.name !== "数据" || root.settings.showChannel) {
                    filteredModel.append(item)
                }
            }
        }
    }
}
