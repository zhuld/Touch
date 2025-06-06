// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only
import QtQuick
import QtQuick.Controls

import "./Dialog"
import "./Pages"
import "./Custom"
import "./Config"

import "./Js/crestroncip.js" as CrestronCIP

Window {
    id: root

    property real channelSize: height * 0.02
    property real shadowHeight: height * 0.006

    readonly property PasswordDialog passwordDialog: PasswordDialog {
        onPasswordEnter: password => {
                             if ((password === "314159")
                                 | (password === Global.settings.settingPassword)) {
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

    title: Global.config.logoName + Global.config.titleName

    visibility: Global.settings.fullscreen ? Window.FullScreen : Window.Windowed
    flags: Qt.FramelessWindowHint | Qt.Window

    Material.theme: Global.settings.darkTheme ? Material.Dark : Material.Light
    Image {
        anchors.fill: parent
        source: Global.config.background
        opacity: ping.running ? 0.3 : 0.6
    }
    TitleBar {
        id: titleBar
        width: parent.width * 0.96
        height: parent.height * 0.07
        x: parent.width * 0.02
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
        y: titleBar.height
        //asynchronous: true
        width: parent.width
        height: parent.height - titleBar.height
        source: ping.running ? (Global.config.tabOnBottom ? "qrc:/qt/qml/content/ContentRow.qml" : "qrc:/qt/qml/content/ContentColumn.qml") : (Global.settings.configSetting === 0 ? "qrc:/qt/qml/content/ConfigSelect.qml" : "qrc:/qt/qml/content/Connect.qml")
    }

    Connections {
        target: tcpClient
        onStateChanged: state => {
                            //console.log('state', state)
                            if (state === 0) {
                                ping.running = false
                            }
                        }
        onDataReceived: data => CrestronCIP.clientMessageCheck(
                            new Uint8Array(data))
    }

    Connections {
        target: tcpServer // 监听 TCPServer 的信号
        onDataReceived: data => CrestronCIP.serverMessageCheck(
                            new Uint8Array(data))
        onClientConnected: CrestronCIP.serverAccept()
    }
    Component.onCompleted: {
        Global.config = Global.configList[Global.settings.configSetting]
        tcpServer.startServer(41793, "127.0.0.1")
    }
}
