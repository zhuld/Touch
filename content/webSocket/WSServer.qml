import QtQuick
import QtWebSockets

WebSocketServer {
    id: server
    port: settings.webSocketServerPort
    listen: settings.webSocketServer

    signal binReceived(var message)
    signal textReceived(var message)

    onClientConnected: (webSocket) =>{
                           webSocket.onTextMessageReceived.connect((message)=> {
                                                                       var msg
                                                                       //console.info("Server","Text Received:", message);
                                                                       if (message.indexOf("PUSH[") === 0){
                                                                           msg = message.replace("PUSH","ON")
                                                                       }else if(message.indexOf("RELEASE[") === 0){
                                                                           msg = message.replace("RELEASE","OFF")
                                                                       }else{
                                                                           msg = message
                                                                       }
                                                                       webSocket.sendTextMessage(msg)
                                                                   });
                           webSocket.onBinaryMessageReceived.connect((message)=> {
                                                                         //console.info("Server","Bin Received:", new Uint8Array(message))
                                                                         binReceived(new Uint8Array(message))

                                                                     });
                           //console.info("Server","Client Connected", webSocket.url)
                       }
    // onErrorStringChanged: {
    //     //console.info("Server","Error: ", errorString);
    // }
}
