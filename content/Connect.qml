import QtQuick

Item {
    id:connectPage
    anchors.fill: parent
    anchors.margins: width*0.02

    property alias socketAnimation: socketAnimation

    Column{
        width: parent.width
        height: parent.height
        Text {
            id: textLogo
            text: qsTr(config.logoName)
            width: parent.width
            height: parent.height*0.3
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: height*0.25
            color: textColor
        }
        Text {
            id: timerText
            width: parent.width
            height: parent.height*0.5
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: height*0.3
            color: textColor
            Timer{
                id:timer
                interval: 1000
                repeat: true
                running: true
                triggeredOnStart: true
            }
            Connections{
                target: timer
                onTriggered: {
                    timerText.text = Qt.formatDateTime(new Date(), "yyyy-MM-dd \n hh:mm:ss")
                }
            }
        }
        Text {
            text: qsTr("重新连接中控...")
            width: parent.width
            height: parent.height*0.2
            horizontalAlignment: Text.AlignRight
            font.pixelSize: height*0.4
            color: textColor
        }
    }
    Rectangle{
        id: socketStatusProgress
        property real socketValue: 1
        y:parent.height -3
        width: parent.width*socketValue
        height: 3
        color: "red"
        NumberAnimation {
            id: socketAnimation
            target: socketStatusProgress
            property: "socketValue"
            from: 1
            to:0
            duration: 3*1000
        }
        Connections{
            target: socketAnimation
            onFinished: {
                wsClient.active = true
                socketStatusProgress.socketValue = 1
            }
        }
    }

    Connections{
        target: connectPage
        Component.onCompleted: socketAnimation.start()
    }
}
