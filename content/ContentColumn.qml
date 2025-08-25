pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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
    ScrollView {
        width: parent.width * 0.12
        height: parent.height - parent.width * 0.02
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.interactive: true
        Column {
            id: tabBar
            width: main.width * 0.12
            spacing: main.height * 0.02
            Repeater {
                id: repeater
                model: Global.tabList
                delegate: MyTabButton {
                    id: tabButton
                    required property string name
                    required property string iconUrl
                    required property int index
                    required property int pageChannel
                    required property string pageUrl
                    required property int disableChannel
                    disEnableChannel: disableChannel
                    text: name
                    width: tabBar.width * 0.8
                    // height: (parent.height + tabBar.spacing) / (Global.tabList.count) - tabBar.spacing
                    //         < width ? (parent.height + tabBar.spacing)
                    //                   / (Global.tabList.count) - tabBar.spacing : width
                    height: width
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
    }
    StackLayout {
        id: stackLayout
        anchors.right: parent.right
        width: parent.width - tabBar.width
        height: parent.height
        Repeater {
            model: Global.tabList
            delegate: Loader {
                required property string pageUrl
                id: pageLoader
                source: pageUrl
                asynchronous: true
            }
        }
        clip: true
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
        function onShowChannelChanged() {
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
