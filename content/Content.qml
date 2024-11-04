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

    Column {
        id: tabBar
        width: parent.width * 0.12
        height: parent.height
        anchors.margins: 0
        spacing: height * 0.03
        Repeater {
            id: repeater
            model: root.pageList
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
    // Row {
    //     id: tabBar
    //     width: parent.width * 0.98
    //     height: parent.height * 0.20
    //     anchors.top: loader.bottom
    //     anchors.topMargin: height * 0.1
    //     spacing: height * 0.03
    //     Repeater {
    //         id: repeater
    //         model: root.pageList
    //         delegate: MyTabButton {
    //             id: tabButton
    //             required property string name
    //             required property string iconUrl
    //             required property string pageUrl
    //             required property int index
    //             text: name
    //             height: parent.height
    //             width: (parent.width + parent.spacing) / repeater.model.count - parent.spacing
    //             icon.source: iconUrl
    //             onClicked: {
    //                 if (usedIndex !== index) {
    //                     loader.setSource(pageUrl)
    //                     usedIndex = index
    //                 }
    //             }
    //             Component.onCompleted: {
    //                 if (index === usedIndex) {
    //                     tabButton.checked = true
    //                     loader.setSource(pageUrl)
    //                 }
    //             }
    //         }
    //     }
    // }
    // Loader {
    //     id: loader
    //     width: parent.width * 0.98
    //     height: parent.height - tabBar.height
    // }
}
