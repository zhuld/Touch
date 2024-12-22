// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only
import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import QtQuick.Effects
import QtCore
import Qt5Compat.GraphicalEffects

import "./Dialog"
import "./Pages"
import "./Custom"
import "./Config"
import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

Window {
    id: root

    ShiyiMZ {
        id: config
    }

    property real channelSize: height * 0.02
    property real shadowHeight: height * 0.005

    property alias settings: settingDialog.settings
    property var digital: []
    property var analog: []

    //property var text: [] // not support yet
    property ListModel listModel: ListModel {}
    property string logoImage: config.logoImage

    property alias running: ping.running

    FontLoader {
        id: lcdFont
        source: "qrc:/content/fonts/TP-LCD.TTF"
    }
    FontLoader {
        id: alibabaPuHuiTi
        source: "qrc:/content/fonts/AlibabaPuHuiTi-3-55-Regular.ttf"
    }
    FontLoader {
        id: sourceCodePro
        source: "qrc:/content/fonts/SourceCodePro-Regular.ttf"
    }

    width: settings.windowWidth
    height: settings.windowHeight
    minimumWidth: 1200
    minimumHeight: 800

    title: config.logoName + config.titleName

    visibility: settings.fullscreen ? Window.FullScreen : Window.Windowed
    flags: Qt.FramelessWindowHint | Qt.Window
    color: "transparent"

    Rectangle {
        id: background
        anchors.fill: parent
        color: config.backgroundColor
        //clip: true
        Image {
            anchors.fill: parent
            source: config.background
            opacity: ping.running ? 0.3 : 0.6
            Behavior on opacity {
                OpacityAnimator {
                    duration: 100
                }
            }
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Rectangle {
                    width: background.width
                    height: background.height
                    radius: background.radius
                }
            }
        }
        radius: settings.fullscreen
                || root.visibility == Window.Maximized ? 0 : height / 20
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
        cursorShape: settings.fullscreen ? Qt.ArrowCursor : Qt.SizeHorCursor
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        onPositionChanged: {
            if (!pressed || settings.fullscreen)
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
        onPressedChanged: {
            settings.windowWidth = root.width
        }
    }
    MouseArea {
        id: bottomSide
        height: parent.width * 0.01
        width: parent.width * 0.98
        cursorShape: settings.fullscreen ? Qt.ArrowCursor : Qt.SizeVerCursor
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onPositionChanged: {
            if (!pressed || settings.fullscreen)
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
        onPressedChanged: {
            settings.windowHeight = root.height
        }
    }
    Loader {
        id: pageLoader
        y: titleBar.height
        width: parent.width
        height: parent.height - titleBar.height
    }
    PasswordDialog {
        id: passwordDialog
        onOkPressed: password => {
                         if ((password === "314159")
                             | (password === settingDialog.settings.settingPassword)) {
                             settingDialog.open()
                             passwordDialog.close()
                         }
                     }
    }
    SettingDialog {
        id: settingDialog
    }
    ConfirmDialog {
        id: closeDialog
        dialogIcon: "qrc:/content/icons/warn.png"
        dialogInfomation: "确定关闭程序？"
        dialogTitle: "提示"
        onOkPress: {
            closeDialog.close()
            root.close()
        }
    }
    Timer {
        id: ping
        interval: 15000
        repeat: true
        onTriggered: CrestronCIP.ping()
        onRunningChanged: {
            if (running) {
                pageLoader.setSource("qrc:/qt/qml/content/Content.qml")
            } else {
                pageLoader.setSource("qrc:/qt/qml/content/Connect.qml")
            }
        }
    }

    Connections {
        target: tcpClient
        onStateChanged: state => {
                            if (state === 0) {
                                running = false
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
        pageLoader.setSource("qrc:/qt/qml/content/Connect.qml")
        tcpServer.startServer(41793, "127.0.0.1")
        if (settings.darkTheme) {
            root.Material.theme = Material.Dark
        } else {
            root.Material.theme = Material.Light
        }
        //初始化
        for (var i = 0; i <= 300; i++) {
            digital[i] = false
            analog[i] = 0
        }
        //digital[1] = true
    }
}
