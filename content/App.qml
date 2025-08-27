// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only
pragma ComponentBehavior: Bound

import QtQuick

import "./Js/crestroncip.js" as CrestronCIP

Window {
    id: root
    readonly property PasswordDialog passwordDialog: PasswordDialog {
        onPasswordEnter: password => {
            if ((password === "314159") | (password === Global.settings.settingPassword)) {
                settingDialog.open()
                passwordDialog.close()
            } else {
                passwordDialog.error = true
            }
        }
    }
    readonly property SettingDialog settingDialog: SettingDialog {}
    readonly property ConfirmDialog closeDialog: ConfirmDialog {
        dialogIcon: "qrc:/content/icons/warn.png"
        dialogInfomation: "确定关闭程序？"
        dialogTitle: "提示"
        onConfirm: {
            root.closeDialog.close()
            root.close()
        }
    }

    property alias running: ping.running
    Timer {
        id: ping
        interval: 10000
        repeat: true
        onTriggered: {
            CrestronCIP.ping()
        }
    }

    width: Global.settings.windowWidth
    height: Global.settings.windowHeight
    minimumWidth: 1600
    minimumHeight: 1000
    color: Global.backgroundColor

    title: Global.configList[Global.settings.configSetting].logoName
    + Global.configList[Global.settings.configSetting].titleName

    visibility: Global.settings.fullscreen ? Window.FullScreen : Window.Windowed
    flags: Qt.FramelessWindowHint | Qt.Window

    //Material.theme: Global.settings.darkTheme ? Material.Dark : Material.Light
    Image {
        anchors.fill: parent
        source: Global.configList[Global.settings.configSetting].background
        opacity: ping.running ? 0.3 : 0.6
    }

    //titlebar
    Item {
        id: titleBar
        width: parent.width * 0.96
        height: parent.height * 0.07
        anchors.horizontalCenter: parent.horizontalCenter
        MouseArea {
            property point clickPosition: Qt.point(0, 0)
            anchors.fill: parent
            cursorShape: Global.settings.fullscreen ? Qt.ArrowCursor : Qt.SizeAllCursor
            onPositionChanged: {
                if (!pressed || Global.settings.fullscreen)
                return
                root.x += mouseX - clickPosition.x
                root.y += mouseY - clickPosition.y
            }
            onPressed: clickPosition = Qt.point(mouseX, mouseY)
        }
        Text {
            id: titleLogo
            text: Global.configList[Global.settings.configSetting].logoName
            height: parent.height
            anchors.left: parent.left
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: height * 0.5
            color: Global.buttonTextColor
            font.family: Global.alibabaPuHuiTi.font.family
        }

        Text {
            id: titleName
            text: Global.configList[Global.settings.configSetting].titleName
            height: parent.height
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: height * 0.5
            color: Global.buttonTextColor
            font.family: Global.alibabaPuHuiTi.font.family
        }
        Row {
            height: parent.height
            anchors.right: parent.right
            spacing: parent.width * 0.01
            Text {
                id: titleTime
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.5
                color: Global.buttonTextColor
                font.family: Global.alibabaPuHuiTi.font.family
                Timer {
                    id: timer
                    interval: 1000
                    repeat: true
                    running: true
                    triggeredOnStart: true
                    onTriggered: {
                        titleTime.text = new Date().toLocaleTimeString(
                            Qt.locale("zh_CN"), " hh:mm")
                    }
                }
            }
            ColorSwitch {
                id: themeSwtich
                height: parent.height * 0.6
                width: height
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    Global.settings.darkTheme = !Global.settings.darkTheme
                }
                checked: Global.settings.darkTheme
                visible: Qt.platform.os === "windows" ? true : false
            }
            ColorButton {
                id: setup
                height: parent.height
                width: height
                source: "qrc:/content/icons/config.png"
                onClicked: root.passwordDialog.open()
                btnColor: "transparent"
                btnCheckColor: "transparent"
            }
            ColorButton {
                id: close
                height: parent.height
                width: height
                source: "qrc:/content/icons/close.png"
                btnColor: "transparent"
                btnCheckColor: "transparent"
                onClicked: root.closeDialog.open()
                visible: Qt.platform.os === "windows" ? true : false
            }
        }
    }
    MouseArea {
        id: rightSide
        height: parent.height * 0.96
        width: parent.width * 0.01
        cursorShape: Global.settings.fullscreen ? Qt.ArrowCursor : Qt.SizeHorCursor
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        onPositionChanged: {
            if (!pressed || Global.settings.fullscreen)
            return
            let width = root.width + mouseX
            if (width > root.minimumWidth) {
                root.width = width
            } else {
                root.width = root.minimumWidth
            }
            let height = width / minimumWidth * minimumHeight
            if (height > root.minimumHeight) {
                root.height = height
            } else {
                root.height = root.minimumHeight
            }
        }
        onReleased: {
            Global.settings.windowWidth = root.width
            Global.settings.windowHeight = root.height
        }
    }
    MouseArea {
        id: bottomSide
        height: parent.width * 0.01
        width: parent.width * 0.98
        cursorShape: Global.settings.fullscreen ? Qt.ArrowCursor : Qt.SizeVerCursor
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onPositionChanged: {
            if (!pressed || Global.settings.fullscreen)
            return
            let height = root.height + mouseY
            if (height > root.minimumHeight) {
                root.height = height
            } else {
                root.height = root.minimumHeight
            }
            let width = height * minimumWidth / minimumHeight
            if (width > root.minimumWidth) {
                root.width = width
            } else {
                root.width = root.minimumWidth
            }
        }
        onReleased: {
            Global.settings.windowWidth = root.width
            Global.settings.windowHeight = root.height
        }
    }
    Loader {
        id: pageLoader
        anchors.top: titleBar.bottom
        width: parent.width
        height: parent.height - titleBar.height
        source: ping.running ? (Global.configList[Global.settings.configSetting].tabOnBottom ? "qrc:/qt/qml/content/Pages/ContentRow.qml" : "qrc:/qt/qml/content/Pages/ContentColumn.qml") : (Global.settings.configSetting === 0 ? "qrc:/qt/qml/content/Pages/ConfigSelect.qml" : "qrc:/qt/qml/content/Pages/Connect.qml")
    }

    Connections {
        target: tcpClient
        function onStateChanged(state) {
            if (state === 0) {
                ping.running = false
            }
        }
        function onDataReceived(data) {
            CrestronCIP.clientMessageCheck(new Uint8Array(data))
        }
    }

    Connections {
        target: tcpServer // 监听 TCPServer 的信号
        function onDataReceived(data) {
            CrestronCIP.serverMessageCheck(new Uint8Array(data))
        }
        function onClientConnected() {
            CrestronCIP.serverAccept()
        }
    }
}
