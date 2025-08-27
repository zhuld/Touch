pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

Item {
    id: main
    anchors.fill: parent
    anchors.leftMargin: width * 0.02

    property ListModel tabList: ListModel {} //tab页面

    ProcessDialog {
        id: processDialog
        dialogInfomation: "正在执行指令，请稍后..."
        dialogTitle: "提示"
        channel: Global.configList[Global.settings.configSetting].processDialogChannel
        autoClose: 50
    }

    ListView {
        id: tabBar
        width: parent.width * 0.11
        height: parent.height * 0.98 > (width * 0.8 + spacing)
                * main.tabList.count ? (width * 0.8 + spacing)
                                       * main.tabList.count : parent.height * 0.98
        clip: true
        spacing: width * 0.2
        anchors.top: parent.top
        interactive: parent.height * 0.98 > (width * 0.8 + spacing)
                     * main.tabList.count ? false : true

        model: main.tabList
        delegate: MyTabButton {
            required property string name
            required property string iconUrl
            required property int index
            required property int pageChannel
            required property string pageUrl
            required property int disableChannel
            disEnableChannel: disableChannel
            text: name
            width: tabBar.width * 0.8
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
    // }
    StackLayout {
        id: stackLayout
        anchors.right: parent.right
        width: parent.width - tabBar.width
        height: parent.height
        Repeater {
            model: main.tabList
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
        main.tabList.clear()
        for (var i = 0; i < Global.configList[Global.settings.configSetting].pageList.count; i++) {
            let item = Global.configList[Global.settings.configSetting].pageList.get(
                i)
            if (!item.test || Global.settings.showChannel) {
                main.tabList.append(item)
            }
        }
    }
}
