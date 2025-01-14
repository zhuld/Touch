import QtQuick

import "./Custom"

Item {
    id: connectPage
    anchors.fill: parent
    anchors.margins: width * 0.02

    Column {
        width: parent.width
        height: parent.height
        spacing: height * 0.08
        Row {
            width: parent.width
            height: parent.height * 0.1
        }
        Row {
            width: parent.width
            height: parent.height * 0.3
            spacing: width * 0.02
            Text {
                id: timeText
                width: parent.width * 0.65
                height: parent.height
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.8
                color: Global.buttonTextColor
                font.family: Global.alibabaPuHuiTi.font.family
            }
            Rectangle {
                height: parent.height
                width: 2
                color: Global.buttonTextColor
            }
            Text {
                id: dateText
                width: parent.width * 0.35
                height: parent.height
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.2
                color: Global.buttonTextColor
                font.family: Global.alibabaPuHuiTi.font.family
            }
            Timer {
                id: timer
                interval: 1000
                repeat: true
                running: true
                triggeredOnStart: true
                onTriggered: {
                    dateText.text = new Date().toLocaleDateString(
                                Qt.locale("zh_CN"), "yy年MM月dd日\n\rdddd")
                    timeText.text = new Date().toLocaleTimeString(
                                Qt.locale("zh_CN"), "hh:mm:ss")
                }
            }
        }

        MyIconLabel {
            text: qsTr("正在连接中控...  ")
            height: parent.height * 0.2
            color: Global.buttonTextColor
            anchors.horizontalCenter: parent.horizontalCenter
        }
        MyIconLabel {
            text: Global.settings.ipAddress + ":" + Global.settings.ipPort + "@"
                  + Global.settings.ipId
            height: parent.height * 0.08
            color: Global.buttonTextColor
            anchors.right: parent.right
        }

        Rectangle {
            id: socketStatusProgress
            property real socketValue: 1
            width: parent.width * socketValue
            height: 6
            radius: height / 2
            color: Global.buttonCheckedColor
            NumberAnimation {
                id: socketAnimation
                target: socketStatusProgress
                property: "socketValue"
                from: 0
                to: 1
                duration: 5000
                running: true
                onStarted: {
                    tcpClient.disconnectFromServer()
                    switch (Global.settings.configSetting) {
                    case 0:
                        Global.config = Global.haishi
                        break
                    case 1:
                        Global.config = Global.shiyi
                        break
                    }

                    if (Global.settings.demoMode) {
                        tcpClient.connectToServer("127.0.0.1", 41793)
                    } else {
                        tcpClient.connectToServer(Global.settings.ipAddress,
                                                  Global.settings.ipPort)
                    }
                }
                onFinished: {
                    socketAnimation.start()
                }
            }
        }
    }
}
