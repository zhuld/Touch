import QtQuick

import QtQuick.Controls

import "qrc:/qt/qml/content/crestroncip.js" as CrestronCIP

Item {
    id: crestronPage
    anchors.fill: parent
    anchors.margins: width * 0.02

    Column {
        spacing: 10
        width: parent.width
        anchors.centerIn: parent

        TextField {
            id: serverAddress
            width: parent.width / 2
            height: 80
            font.pixelSize: 60
            text: root.settings.ipAddress
            placeholderText: "Enter Server Address"
        }

        TextField {
            id: serverPort
            width: parent.width / 2
            height: 80
            font.pixelSize: 60
            text: root.settings.ipPort
            placeholderText: "Enter Server Port"
            inputMethodHints: Qt.ImhDigitsOnly
        }

        TextField {
            id: messageField
            width: parent.width / 2
            height: 80
            font.pixelSize: 60
            placeholderText: "Enter message"
        }

        Button {
            text: "Connect"
            height: 80
            font.pixelSize: 60
            onClicked: {
                cipClient.connectToServer(root.settings.ipAddress,
                                          root.settings.ipPort)
            }
        }

        Button {
            text: "62"
            height: 80
            font.pixelSize: 60
            onPressed: {
                var send = new Uint8Array([0x05, 0x00, 0x06, 0x00, 0x00, 0x03, 0x27, 0x3D, 0x00])
                cipClient.sendData(send.buffer)
            }

            onReleased: {
                var send = new Uint8Array([0x05, 0x00, 0x06, 0x00, 0x00, 0x03, 0x27, 0x3D, 0x80])
                cipClient.sendData(send.buffer)
            }
        }

        Button {
            text: "Send Message"
            height: 80
            font.pixelSize: 60
            onClicked: {
                var message = messageField.text
                var byteArray = []
                for (var i = 0; i < message.length; i++) {
                    byteArray.push(message.charCodeAt(i))
                }
                cipClient.sendData(byteArray)
            }
        }

        Button {
            text: "Disconnect"
            height: 80
            font.pixelSize: 60
            onClicked: {
                cipClient.disconnectFromServer()
            }
        }

        Text {
            id: receivedMessage
            text: "Received Message: "
            width: parent.width / 2
            height: 80
            font.pixelSize: 60
        }
        Text {
            id: connectionStatus
            text: "Connection Status: Unconnected"
            width: parent.width / 2
            height: 80
            font.pixelSize: 60
        }
    }

    Connections {
        target: cipClient
        onDataReceived: function (data) {
            var message = new Uint8Array(data)
            receivedMessage.text = "接收 " + Qt.formatDateTime(
                        new Date(), "hh:mm:ss: ") + message
            var mdata = CrestronCIP.messageCheck(message)
            if (mdata !== null) {
                cipClient.sendData(mdata)
            }
        }
        onConnected: {
            console.log("Connected to server")
        }
        onDisconnected: {
            console.log("Disconnected from server")
        }
        onErrorOccurred: error => {
                             console.log("Error: " + error)
                         }
        onStateChanged: function (state) {
            // 更新界面显示连接状态
            switch (state) {
            case 0:
                connectionStatus.text = "0: Connection Status: Unconnected"
                break
            case 1:
                connectionStatus.text = "1: Connection Status: Host Lookup"
                break
            case 2:
                connectionStatus.text = "2: Connection Status: Connecting"
                break
            case 3:
                connectionStatus.text = "3: Connection Status: Connected"
                break
            case 4:
                connectionStatus.text = "4: Connection Status: Bound"
                break
            case 5:
                connectionStatus.text = "5: Connection Status: Listening"
                break
            case 6:
                connectionStatus.text = "6: Connection Status: Closing"
                break
            default:
                connectionStatus.text = "Connection Status: Unknown"
                break
            }
        }
    }
}
