pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

Item {
    id: main
    anchors.fill: parent
    anchors.bottomMargin: width * 0.02

    ProcessDialog {
        id: processDialog
        dialogInfomation: "正在执行指令，请稍后..."
        dialogTitle: "提示"
        channel: Global.config.processDialogChannel
        autoClose: 50
    }
    ListView {
        id: tabBar
        width: parent.width * 0.96 > (height * 0.85 + spacing)
               * Global.tabList.count ? (height * 0.85 + spacing)
                                        * Global.tabList.count : parent.width * 0.96
        height: parent.height * 0.16
        clip: true
        spacing: height * 0.2
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        orientation: ListView.Horizontal
        interactive: parent.width * 0.96 > (height * 0.85 + spacing)
                     * Global.tabList.count ? false : true
        model: Global.tabList
        delegate: MyTabButton {
            id: tabButton
            required property string name
            required property string iconUrl
            required property int index
            required property int pageChannel
            required property int disableChannel
            disEnableChannel: disableChannel
            text: name
            width: height
            height: tabBar.height * 0.85
            source: iconUrl
            channel: pageChannel
            onCheckedChanged: {
                if (checked & stackLayout.currentIndex !== index) {
                    stackLayout.currentIndex = index
                }
            }
        }
    }
    StackLayout {
        id: stackLayout
        anchors.top: parent.top
        width: parent.width * 0.98
        height: parent.height - tabBar.height
        x: parent.width * 0.02
        Repeater {
            model: Global.tabList
            delegate: Loader {
                required property string pageUrl
                id: pageLoader
                source: pageUrl
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
