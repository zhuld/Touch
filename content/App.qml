// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick
import QtQuick.Controls
import Touch
import QtQuick.Shapes
import QtWebSockets

import "./dialog"
import "./Pages"
import "./webSocket"

import "qrc:/qt/qml/content/ws.js" as WS

Window {
    id: root

    property alias pageLoader: pageLoader
    property alias wsClient: wsClient
    property alias settings: settingDialog.settings
    property alias pageList: config.pageList

    property bool connectPage: true

    property var digital:[500]
    property var analog:[100]
    property var text:[100]

    property color backgroundColor:"#030A1D"
    property color buttonTextColor: "azure"
    property color textColor: "lightskyblue"
    property color buttonColor: "#1B2A4B"
    property color buttonCheckedColor: "#124373"

    property color buttonTextRedColor: "red"
    property color borderColor: "#3685FE"

    property color volumeBlueColor: "#3685FE"
    property color volumeRedColor: "#880015"

    property int usedIndex: 0

    TestModel {
        id: config
    }


    width: 1280
    height: 800
    minimumWidth: 800
    minimumHeight: 480

    title: Application.name+" - "+config.version

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
            opacity: connectPage? 0.9:0.4
            Behavior on opacity {
                OpacityAnimator{
                    duration: 1500
                }
            }
        }
    }

    Rectangle{
        id: titleBar
        width: parent.width*0.96
        height: parent.height*0.08
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        visible: !root.connectPage
        Text {
            id: titleLogo
            text: qsTr(config.logoName)
            height: parent.height
            anchors.left: parent.left
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: height*0.4
            color: textColor
        }
        Text {
            id: titleName
            text: qsTr(config.titleName) + (settings.webSocketServer ? "-演示":"")
            height: parent.height
            anchors.centerIn: parent
            //verticalAlignment: Text.AlignVCenter
            font.pixelSize: height*0.6
            color: textColor
        }
        Text {
            id: titleTime
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            anchors.right: parent.right
            anchors.rightMargin: styleSwitch.visible? parent.width*0.1 : 0
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
        Switch{
            id:styleSwitch
            height: parent.height/2
            width: height*2
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            indicator: Rectangle {
                anchors.fill: parent
                radius: height/2
                color: buttonColor
                border.color: "black"
                Behavior on color {
                    ColorAnimation {
                        duration: 300
                    }
                }
                Rectangle {
                    x: parent.parent.checked ? parent.width - parent.height*0.9 : parent.height*0.1
                    width: height
                    height: parent.height*0.8
                    y:parent.height*0.1
                    radius: height/2
                    color: buttonTextColor
                    border.color: "black"
                    Behavior on x{
                        NumberAnimation{
                            duration: 300
                        }
                    }
                }
            }
            checked: true
            visible: false

            state: checked? "dark": "light"
            states: [
                State {
                    name: "dark"
                    PropertyChanges {
                        target: root
                    }
                },
                State {
                    name: "light"
                    PropertyChanges {
                        target: root
                    }
                }
            ]
        }
        Shape{
            anchors.fill: parent
            ShapePath{
                strokeColor: borderColor
                strokeStyle: ShapePath.SolidLine
                strokeWidth: 2
                startX: 0
                startY: titleBar.height
                PathLine{
                    x:titleBar.width
                    y:titleBar.height
                }
            }
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
                                   pageLoader.setSource("qrc:/qt/qml/content/Main.qml")
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
                              WS.checkMessage(message)
                          }
    }
}

