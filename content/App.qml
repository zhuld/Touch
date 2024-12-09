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

    property alias settings: settingDialog.settings
    property var digital: []
    property var analog: []

    //property var text: [] // not support yet
    property ListModel listModel: ListModel {}

    property color backgroundColor: settings.darkTheme ? "#02112C" : "lightgray"
    property color buttonTextColor: settings.darkTheme ? "whitesmoke" : "#0B1A38"
    property color textColor: settings.darkTheme ? "lightskyblue" : "#0B1A38" //文字颜色
    property color buttonColor: settings.darkTheme ? "#16417C" : "lightgray"
    property color buttonShadowColor: settings.darkTheme ? "#E0262626" : "#E0262626"
    property color buttonRedColor: settings.darkTheme ? "darkred" : "lightpink"
    property color buttonGreenColor: settings.darkTheme ? "darkgreen" : "lightgreen"
    property color catagoryColor: settings.darkTheme ? "#1A5A94" : "gainsboro"
    property color buttonCheckedColor: settings.darkTheme ? "#E0589BAB" : "#E0589BAB"

    property color buttonTextRedColor: "red"

    property color volumeBlueColor: settings.darkTheme ? "whitesmoke" : "#0B1A38"
    property color volumeRedColor: "red"

    property string logoImage: config.logoImage

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
    minimumWidth: 1280
    minimumHeight: 720

    title: config.logoName + config.titleName

    visibility: settings.fullscreen ? Window.FullScreen : Window.Windowed
    flags: Qt.FramelessWindowHint | Qt.Window

    //visible: true
    color: "transparent"
    Rectangle {
        id: background
        anchors.fill: parent
        color: backgroundColor
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
    ProcessDialog {
        id: processDialog
        dialogInfomation: "正在执行指令，请稍后..."
        dialogTitle: "提示"
        channel: config.processDialogChannel
        autoClose: 50
    }
    Timer {
        id: ping
        interval: 15000
        repeat: true
        onTriggered: CrestronCIP.ping()
    }

    Connections {
        target: tcpClient
        onStateChanged: state => {
                            //console.log("state", state)
                            switch (state) {
                                case 0:
                                //case 2:
                                //case 1:
                                //disconneted
                                if (ping.running) {
                                    pageLoader.setSource(
                                        "qrc:/qt/qml/content/Connect.qml")
                                    ping.running = false
                                } else {
                                    pageLoader.item.socketAnimation.start()
                                }
                                break
                                case 3:
                                //connected
                                pageLoader.setSource(
                                    "qrc:/qt/qml/content/Content.qml")
                                ping.running = true
                                break
                            }
                        }
        onDataReceived: data => {
                            CrestronCIP.clientMessageCheck(new Uint8Array(data))
                        }
    }

    Connections {
        target: tcpServer // 监听 TCPServer 的信号
        onDataReceived: data => {
                            CrestronCIP.serverMessageCheck(new Uint8Array(data))
                        }
        onClientConnected: {
            CrestronCIP.accept()
        }
    }
    Component.onCompleted: {
        pageLoader.setSource("qrc:/qt/qml/content/Connect.qml")
        if (settings.demoMode) {
            tcpServer.startServer(41793, "127.0.0.1")
            tcpClient.connectToServer("127.0.0.1", 41793)
        } else {
            tcpServer.stopServer()
            tcpClient.connectToServer(settings.ipAddress, settings.ipPort)
        }
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
        //digital[11] = true
    }
}
