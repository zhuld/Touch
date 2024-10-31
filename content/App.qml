// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only
import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import QtWebSockets
import QtQuick.Effects
import Qt.labs.platform

import "./dialog"
import "./Pages"
import "./Custom"
import "qrc:/qt/qml/content/crestroncip.js" as CrestronCIP

Window {
    id: root

    property alias pageLoader: pageLoader
    property alias settings: settingDialog.settings
    property alias pageList: config.pageList

    property bool connectPage: false

    property var digital: [500]
    property var analog: [100]
    property var text: [100]

    property color backgroundColor: settings.darkTheme ? "#030A1D" : "lightgray"

    property color buttonTextColor: settings.darkTheme ? "whitesmoke" : "#0B1A38"
    property color textColor: settings.darkTheme ? "lightskyblue" : "dark" //文字颜色
    property color buttonColor: settings.darkTheme ? "#E01B2A4B" : "#E0FAFAFA"
    property color buttonRedColor: settings.darkTheme ? "#DD880015" : "#A0F08784"
    property color catagoryColor: settings.darkTheme ? "#1B4F96" : "#D7DBE4"
    property color buttonCheckedColor: settings.darkTheme ? "#E0589BAB" : "#E0589BAB"

    property color buttonTextRedColor: "red"

    property color volumeBlueColor: settings.darkTheme ? "whitesmoke" : "#0B1A38"
    property color volumeRedColor: "red"

    property string logoImage: config.logoImage

    Config {
        id: config
    }

    FontLoader {
        id: lcdFont
        source: "qrc:/content/fonts/TP-LCD.TTF"
    }

    width: settings.windowWidth
    height: settings.windowHeight
    minimumWidth: 1280
    minimumHeight: 800

    title: config.logoName + config.titleName

    visibility: settings.fullscreen ? Window.FullScreen : Window.Windowed
    flags: Qt.FramelessWindowHint | Qt.Window

    visible: true
    color: "transparent"

    Rectangle {
        id: background
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: backgroundColor
            }
            GradientStop {
                position: 0.4
                color: Qt.darker(backgroundColor, 1.2)
            }
            GradientStop {
                position: 1.0
                color: Qt.darker(backgroundColor, 1.6)
            }
        }

        Image {
            anchors.fill: parent
            source: config.background
            opacity: connectPage ? 0.6 : 0.3
            Behavior on opacity {
                OpacityAnimator {
                    duration: 1000
                }
            }
        }
        radius: settings.fullscreen
                || root.visibility == Window.Maximized ? 0 : width * 0.01
    }
    TitleBar {
        id: titleBar
        width: parent.width * 0.96
        height: parent.height * 0.08
        x: parent.width * 0.02
        Text {
            id: titleRecive
            visible: settings.showChannel
            height: parent.height * 0.4
            anchors.left: parent.left
            y: parent.height * 0.8
            font.pixelSize: height
            color: textColor
        }
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
            titleRecive.text = "Window Width: " + root.width
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
            titleRecive.text = "Window Height: " + root.height
        }
        onPressedChanged: {
            settings.windowHeight = root.height
        }
    }
    Loader {
        id: pageLoader
        anchors.top: titleBar.bottom
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
    MsgDialog {
        id: closeDialog
        dialogIcon.source: "qrc:/content/icons/warn.png"
        dialogInfomation: "确定关闭程序？"
        dialogTitle: "提示"
        onOkPress: {
            root.close()
        }
    }
    Timer {
        id: ping
        interval: 15000
        repeat: true
        onTriggered: {
            tcpClient.sendData(CrestronCIP.ping())
        }
    }
    Connections {
        target: tcpClient
        onStateChanged: state => {
                            if (state === 3) {
                                pageLoader.setSource(
                                    "qrc:/qt/qml/content/Content.qml")
                                connectPage = false
                                ping.running = true
                            } else if (state === 0) {
                                if (connectPage) {
                                    pageLoader.item.socketAnimation.start()
                                } else {
                                    pageLoader.setSource(
                                        "qrc:/qt/qml/content/Connect.qml")
                                    connectPage = true
                                    ping.running = false
                                }
                            }
                        }
        onDataReceived: data => {
                            titleRecive.text = "Recived: " + CrestronCIP.toHexString(
                                new Uint8Array(data))
                            //let mdata = CrestronCIP.clientMessageCheck(
                            //    new Uint8Array(data))
                            //if (mdata !== null) {
                            tcpClient.sendData(CrestronCIP.clientMessageCheck(
                                                   new Uint8Array(data)))
                            // }
                        }
    }

    Connections {
        target: tcpServer // 监听 TCPServer 的信号
        onDataReceived: data => {
                            // 显示收到的消息
                            titleRecive.text = "Sended: " + CrestronCIP.toHexString(
                                new Uint8Array(data))
                            let mdata = CrestronCIP.serverMessageCheck(
                                new Uint8Array(data))
                            if (mdata !== null) {
                                tcpServer.sendData(mdata)
                            }
                        }
        onClientConnected: {
            tcpServer.sendData(CrestronCIP.accept())
        }
    }
    Component.onCompleted: {
        pageLoader.setSource("qrc:/qt/qml/content/Connect.qml")
        connectPage = true
        if (root.settings.demoMode) {
            tcpServer.startServer(41793, "127.0.0.1")
            tcpClient.connectToServer("127.0.0.1", 41793)
        } else {
            tcpServer.stopServer()
            tcpClient.connectToServer(settings.ipAddress, settings.ipPort)
        }
    }
}
