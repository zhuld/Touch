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
import "qrc:/qt/qml/content/js/crestroncip.js" as CrestronCIP

Window {
    id: root

    property alias pageLoader: pageLoader
    property alias settings: settingDialog.settings
    property alias pageList: config.pageList

    property var digital: []
    property var analog: []
    property var text: []

    property ListModel listModel: ListModel {}

    property color backgroundColor: settings.darkTheme ? "midnightblue" : "lightgray"

    property color buttonTextColor: settings.darkTheme ? "whitesmoke" : "#0B1A38"
    property color textColor: settings.darkTheme ? "lightskyblue" : "dark" //文字颜色
    property color buttonColor: settings.darkTheme ? "#E01B2A4B" : "whitesmoke"
    property color buttonShadowColor: settings.darkTheme ? "midnightblue" : "grey"
    property color buttonRedColor: settings.darkTheme ? "darkred" : "lightpink"
    property color buttonGreenColor: settings.darkTheme ? "darkgreen" : "lightgreen"
    property color catagoryColor: settings.darkTheme ? "#1B4F96" : "mintcream"
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
    FontLoader {
        id: alibabaPuHuiTi
        source: "qrc:/content/fonts/AlibabaPuHuiTi-3-55-Regular.ttf"
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
            opacity: ping.running ? 0.3 : 0.6
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
            root.close()
        }
    }
    ProcessDialog {
        id: processDialog
        dialogInfomation: "正在执行指令，请稍后..."
        dialogTitle: "提示"
        channel: 1
        autoClose: 50
    }
    Timer {
        id: ping
        interval: 15000
        repeat: true
        onTriggered: CrestronCIP.ping()
    }

    // ListModel {
    //     id: listModel
    // }
    Connections {
        target: tcpClient
        onStateChanged: state => {
                            switch (state) {
                                case 0:
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
                            // listModel.append({
                            //                      "time": new Date().toLocaleTimeString(
                            //                                  ),
                            //                      "direction": "Recived: ",
                            //                      "data": CrestronCIP.toHexString(
                            //                                  new Uint8Array(data))
                            //                  })
                            CrestronCIP.clientMessageCheck(new Uint8Array(data))
                        }
    }

    Connections {
        target: tcpServer // 监听 TCPServer 的信号
        onDataReceived: data => {
                            // listModel.append({
                            //                      "time": new Date().toLocaleTimeString(
                            //                                  ),
                            //                      "direction": "Sended: ",
                            //                      "data": CrestronCIP.toHexString(
                            //                                  new Uint8Array(data))
                            //                  })
                            CrestronCIP.serverMessageCheck(new Uint8Array(data))
                        }
        onClientConnected: {
            CrestronCIP.accept()
        }
    }
    Component.onCompleted: {
        pageLoader.setSource("qrc:/qt/qml/content/Connect.qml")
        if (root.settings.demoMode) {
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
        for (var digitali = 0; digitali <= 500; digitali++) {
            digital[digitali] = false
        }
        for (var analogi = 0; analogi <= 100; analogi++) {
            analog[analogi] = 0
        }
        for (var texti = 0; texti <= 100; texti++) {
            text[texti] = ""
        }
    }
}
