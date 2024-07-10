// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick
import QtQuick.Controls
//import Touch
import QtQuick.Shapes
import QtWebSockets

import "./dialog"
import "./Pages"
import "./Custom"
import "./webSocket"

import "qrc:/qt/qml/content/ws.js" as WS

Window {
    id: root

    property alias pageLoader: pageLoader
    property alias wsClient: wsClient
    property alias settings: settingDialog.settings
    property alias pageList: config.pageList

    property bool connectPage: false

    property var digital:[500]
    property var analog:[100]
    property var text:[100]

    property color backgroundColor:settings.darkTheme ? "#030A1D" :"lightgray"

    property color buttonTextColor: settings.darkTheme ? "whitesmoke":"#0B1A38"
    property color textColor: settings.darkTheme ? "lightskyblue" : "dark" //文字颜色
    property color buttonColor: settings.darkTheme?"#DD1B2A4B" : "#A0FAFAFA"
    property color catagoryColor:  settings.darkTheme ? "#263B69":"#D7DBE4"
    property color buttonCheckedColor: settings.darkTheme ? "#B0589BAB":"#C0589BAB"

    property color buttonTextRedColor: "red"

    property color volumeBlueColor: settings.darkTheme ? "whitesmoke":"#0B1A38"
    property color volumeRedColor: "red"

    property int usedIndex: 0

    ConfigModel {
        id: config
    }

    height: 800
    width: 1280
    minimumWidth: 800
    minimumHeight: 480

    title: config.logoName+config.titleName

    visibility:settings.fullscreen? Window.FullScreen : Window.Windowed

    visible: true

    Rectangle{
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: backgroundColor }
            GradientStop { position: 0.4; color: Qt.darker(backgroundColor,1.2) }
            GradientStop { position: 1.0; color: Qt.darker(backgroundColor,1.6) }
        }
        Image {
            anchors.fill: parent
            source: config.background
            opacity: connectPage? 0.6:0.3
            Behavior on opacity {
                OpacityAnimator{
                    duration: 1000
                }
            }
        }
    }

    Rectangle{
        id: titleBar
        width: parent.width*0.96
        height: parent.height*0.08
        anchors.horizontalCenter: parent.horizontalCenter

        gradient: Gradient {
            GradientStop {
                position: 1.0; color: Qt.alpha(catagoryColor,0.5)
                Behavior on color{
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
            GradientStop {
                position: 0.0; color: catagoryColor
                Behavior on color{
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
        }
        radius: height*0.2
        visible: !root.connectPage
        Text {
            id: titleLogo
            text: qsTr(config.logoName)
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: parent.width*0.02
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: height*0.4
            color: textColor
        }
        Text {
            id: titleName
            text: qsTr(config.titleName) + (settings.webSocketServer ? "-演示":"")
            height: parent.height
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: height*0.6
            color: textColor
        }
        Text {
            id: titleTime
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            anchors.right: themeSwitch.left
            anchors.rightMargin: parent.width*0.01
            font.pixelSize: height*0.4
            color: textColor
            Timer{
                id:timer
                interval: 1000
                repeat: true
                running: !root.connectPage
                triggeredOnStart: true
            }
            Connections{
                target: timer
                onTriggered: {
                    titleTime.text = Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm")
                }
            }
        }
        ColorSwitch{
            id:themeSwitch
            height: parent.height*0.5
            width: height*2
            anchors.right: parent.right
            anchors.rightMargin: parent.width*0.02
            anchors.verticalCenter: parent.verticalCenter
            checked: settings.darkTheme
            onCheckedChanged: {
                settings.darkTheme = checked
            }
        }

        Text {
            id: titleRecive
            visible: settings.showChannel
            height: parent.height*0.4
            anchors.left: parent.left
            y:parent.height*0.8
            font.pixelSize: height
            color: textColor
        }
    }

    MouseArea{
        height: titleBar.height
        width: height*2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        onClicked: passwordDialog.open()
    }
    Loader{
        id:pageLoader
        anchors.top: titleBar.bottom
        width: parent.width
        height: parent.height - titleBar.height
        source: "qrc:/qt/qml/content/Connect.qml"
    }
    PasswordDialog{
        id: passwordDialog
        onOkPressed: (password)=>{
                         if((password === "314159")|(password === settingDialog.settings.settingPassword)){
                             settingDialog.open()
                             passwordDialog.close()
                         }
                     }
    }

    SettingDialog{ id: settingDialog }

    WSClient{
        id:wsClient
        active: true
    }

    WSServer{
        id: wsServer
    }
    Connections{
        target: wsClient
        onWsStatusChanged: (status) =>{
                               if (wsClient.status === WebSocket.Open){
                                   pageLoader.setSource("qrc:/qt/qml/content/Base.qml")
                                   connectPage = false
                               }else if ((wsClient.status === WebSocket.Closed)){
                                   wsClient.active = false
                                   if(connectPage){
                                       pageLoader.item.socketAnimation.start()
                                   }else{
                                       pageLoader.setSource("qrc:/qt/qml/content/Connect.qml")
                                       connectPage = true
                                   }
                               }
                           }
        onWsTextReceived: (message) =>{
                              titleRecive.text = "收到：" + message
                              WS.checkMessage(message)
                          }
    }
}
