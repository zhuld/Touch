import QtQuick
import QtWebSockets


WebSocket {
    id: socket
    url: settings.webSocketServer ? "ws://127.0.0.1:"+settings.webSocketServerPort : "ws://"+root.settings.ipAddress+":"+root.settings.ipPort

    signal wsStatusChanged(var status)
    signal wsTextReceived(var message)

    onTextMessageReceived: (message)=> {
                               console.info("Client","Text Received:", message)
                               wsTextReceived(message)
                           }
    onBinaryMessageReceived: (message)=> {
                                 console.info("Client","Bin Received:", new Uint8Array(message))
                             }
    onStatusChanged: {
        wsStatusChanged(socket.status)
    }
    active: false
}
