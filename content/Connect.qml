import QtQuick

Item {
    id: connectPage
    anchors.fill: parent
    anchors.margins: width * 0.02
    property alias socketAnimation: socketAnimation

    Column {
        width: parent.width
        height: parent.height
        spacing: parent.height * 0.05
        Item {
            height: parent.height * 0.1
            width: parent.width
        }
        Text {
            id: timeText
            width: parent.width
            height: parent.height * 0.4
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: height * 0.8
            color: textColor
            font.family: alibabaPuHuiTi.font.family
        }
        Text {
            id: dateText
            width: parent.width
            height: parent.height * 0.1
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: height * 0.5
            color: textColor
            font.family: alibabaPuHuiTi.font.family
        }
        Timer {
            id: timer
            interval: 1000
            repeat: true
            running: true
            triggeredOnStart: true
            onTriggered: {
                dateText.text = new Date().toLocaleDateString(
                            Qt.locale("zh_CN"), "yyyy年MM月dd日 dddd")
                timeText.text = new Date().toLocaleTimeString(
                            Qt.locale("zh_CN"), "hh:mm")
            }
        }
        Text {
            text: qsTr("正在连接中控...  ")
            width: parent.width
            height: parent.height * 0.15
            horizontalAlignment: Text.AlignRight
            font.pixelSize: height * 0.6
            color: textColor
            font.family: alibabaPuHuiTi.font.family
        }
        Text {
            text: qsTr("隽捷信息")
            width: parent.width
            height: parent.height * 0.05
            horizontalAlignment: Text.AlignRight
            font.pixelSize: height * 0.6
            color: textColor
            font.family: alibabaPuHuiTi.font.family
        }
    }
    Rectangle {
        id: socketStatusProgress
        property real socketValue: 1
        y: parent.height - 3
        width: parent.width * socketValue
        height: 3
        color: "red"
        NumberAnimation {
            id: socketAnimation
            target: socketStatusProgress
            property: "socketValue"
            from: 1
            to: 0
            duration: 3 * 1000
        }
        Connections {
            target: socketAnimation
            onFinished: {
                if (root.settings.demoMode) {
                    tcpClient.connectToServer("127.0.0.1", 41793)
                } else {
                    tcpClient.connectToServer(settings.ipAddress,
                                              settings.ipPort)
                }
                socketStatusProgress.socketValue = 1
            }
        }
    }

    Component.onCompleted: socketAnimation.start()
}
