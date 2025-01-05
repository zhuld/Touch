const op_Server_Accept = 0x0F // 服务器接受连接 0F 00 01 02
const op_Client_IPID = 0x01 // 发送IPID 01 00 0B 00 00 00 00 00 XX 40 FF FF F1 01
const op_Server_IPID = 0x02 // 回复 02 00 04 00 00 00 1F ok; 02 00 03 FF FF 02 failed

const op_Join = 0x05 // 发送 Join信息
const op_Join_Digital = 0x00
const op_Join_Analog1 = 0x01
const op_Join_Analog2 = 0x14
const op_Join_Serial = 0x02
const op_Join_Request = 0x03

const op_Client_Ping = 0x0D // 定时发送 0D 00 02 00 00
const op_Server_Pong = 0x0E // 回复 0E 00 02 00 00

function clientMessageCheck(message) {
    let index = 0
    //console.log("client: ", toHexString(message, " "))
    while (index < message.length) {
        let payloadType = message[index]
        let payloadLength = message[index + 2]
        let payload = message.slice(index + 3, index + 3 + payloadLength)
        switch (payloadType) {
        case op_Server_Accept:
            if (payload.length === 1 && payload[0] === 0x02) {
                recivedAppendList(message, index, payloadLength, "连接后，服务器确认")
                tcpClient.sendData(
                            cipmessage(
                                op_Client_IPID,
                                new Uint8Array([0x00, 0x00, 0x00, 0x00, 0x00, Global.settings.ipId, 0x40, 0xFF, 0xFF, 0xF1, 0x01])))
                sendAppendList(
                            cipmessage2(
                                op_Client_IPID,
                                new Uint8Array([0x00, 0x00, 0x00, 0x00, 0x00, Global.settings.ipId, 0x40, 0xFF, 0xFF, 0xF1, 0x01])),
                            "发送IPID：" + Global.settings.ipId + "，注册到服务器")
            }
            break
        case op_Server_IPID:
            if (toHexString(payload, "") === "0000001F" || toHexString(
                        payload, "") === "00000003") {
                recivedAppendList(message, index, payloadLength,
                                  "服务器确认IPID：" + Global.settings.ipId + "，注册成功")
                tcpClient.sendData(
                            cipmessage(
                                op_Join,
                                new Uint8Array([0x00, 0x00, 0x02, op_Join_Request, 0x00])))
                sendAppendList(
                            cipmessage2(
                                op_Join,
                                new Uint8Array([0x00, 0x00, 0x02, op_Join_Request, 0x00])),
                            "发送查询指令")
                root.running = true
            } else if (toHexString(payload, "") === "FFFF02") {
                recivedAppendList(message, index, payloadLength, "服务器注册失败")
                //console.log("registration failed")
            }
            break
        case op_Join:
            //Join事件
            switch (payload[3]) {
            case op_Join_Digital:
                //digital
                let channelD = payload[4] + (payload[5] & 0x7F) * 0x100 + 1
                if (isNaN(channelD) === false) {
                    let tmpD = Global.digital
                    tmpD[channelD] = !(payload[5] & 0x80)
                    Global.digital = tmpD
                }
                recivedAppendList(message, index, payloadLength,
                                  "Digital:" + channelD + " -> "
                                  + (Global.digital[channelD] ? "High" : "Low"))
                break
            case op_Join_Analog1:
            case op_Join_Analog2:
                //analog
                let channelA
                let tmpA = Global.analog
                if (payloadLength === 8) {
                    channelA = payload[4] * 0x100 + payload[5] + 1
                    if (isNaN(channelA) === false) {
                        tmpA[channelA] = payload[6] * 0x100 + payload[7]
                        Global.analog = tmpA
                    }
                } else if (payloadLength === 7) {
                    channelA = payload[4] + 1
                    if (isNaN(channelA) === false) {
                        tmpA[channelA] = payload[5] * 0x100 + payload[6]
                        Global.analog = tmpA
                    }
                }
                recivedAppendList(
                            message, index, payloadLength,
                            "Analog:" + channelA + " -> " + Global.analog[channelA])
                break
            default:
                recivedAppendList(message, index, payloadLength, "其他Join事件")
                break
            }
            break
        case op_Server_Pong:
            //recivedAppendList(message, index, payloadLength, "服务器回复Pong")
            break
        default:
            recivedAppendList(message, index, payloadLength, "其他未知事件")
            break
        }
        index = index + payloadLength + 3
    }
}

function serverMessageCheck(message) {
    let index = 0
    //console.log("server: ", toHexString(message," "))
    while (index < message.length) {
        let payloadType = message[index]
        let payloadLength = message[index + 2]
        let payload = message.slice(index + 3, index + 3 + payloadLength)
        switch (payloadType) {
        case op_Client_IPID:
            // 收到IPID信息
            if (payloadLength === 11 & payload[5] === Global.settings.ipId) {
                tcpServer.sendData(
                            cipmessage(
                                op_Server_IPID,
                                new Uint8Array([0x00, 0x00, 0x00, 0x1F]))) //0000001F
            } else {
                tcpServer.sendData(cipmessage(
                                       op_Server_IPID,
                                       new Uint8Array([0xFF, 0xFF, 0x02])))
            }
            break
        case op_Client_Ping:
            // 收到ping，回复pong
            if (payloadLength === 2) {
                return pong()
            }
            break
        case op_Join:
            // 收到Join查询指令，
            switch (payload[3]) {
            case op_Join_Request:
                //Todo:处理查询指令
                console.log("处理查询指令")
                break
            case op_Join_Digital:
                //digital
                tcpServer.sendData(cipmessage(op_Join, payload))
                break
            case op_Join_Analog1:
            case op_Join_Analog2:
                if (payloadLength === 8) {
                    tcpServer.sendData(
                                cipmessage(
                                    op_Join,
                                    new Uint8Array([0x00, 0x00, 0x05, payload[3], message[4], payload[5], payload[6], payload[7]])))
                }
                break
            }
            break
        }
        index = index + payloadLength + 3
    }
}

function cipmessage(opCode, message) {
    let m = new Uint8Array(message.length + 3)
    m[0] = opCode
    m[1] = message.length / 0x100
    m[2] = message.length % 0x100
    m.set(message, 3)
    return m.buffer
}

function cipmessage2(opCode, message) {
    let m = new Uint8Array(message.length + 3)
    m[0] = opCode
    m[1] = message.length / 0x100
    m[2] = message.length % 0x100
    m.set(message, 3)
    return m
}

//client
function push(channel) {
    if (channel > 0 & channel < 32767) {
        channel = channel - 1
        tcpClient.sendData(
                    cipmessage(
                        op_Join,
                        new Uint8Array([0x00, 0x00, 0x03, op_Join_Digital, channel
                                        % 0x100, channel / 0x100])))
        sendAppendList(
                    cipmessage2(
                        op_Join,
                        new Uint8Array([0x00, 0x00, 0x03, op_Join_Digital, channel
                                        % 0x100, channel / 0x100])),
                    "Digital:" + (channel + 1) + " -> " + "Push")
    }
}
function release(channel) {
    if (channel > 0 & channel < 32767) {
        channel = channel - 1
        tcpClient.sendData(
                    cipmessage(
                        op_Join,
                        new Uint8Array([0x00, 0x00, 0x03, op_Join_Digital, channel
                                        % 0x100, (channel / 0x100) | 0x80])))
        sendAppendList(
                    cipmessage2(
                        op_Join,
                        new Uint8Array([0x00, 0x00, 0x03, op_Join_Digital, channel
                                        % 0x100, channel / 0x100 | 0x80])),
                    "Digital:" + (channel + 1) + " -> " + "Release")
    }
}
function level(channel, value) {
    if (channel > 0 & channel < 65536) {
        channel = channel - 1
        tcpClient.sendData(
                    cipmessage(
                        op_Join,
                        new Uint8Array([0x00, 0x00, 0x05, op_Join_Analog2, channel / 0x100, channel
                                        % 0x100, value / 0x100, value % 0x100])))
        sendAppendList(
                    cipmessage2(
                        op_Join,
                        new Uint8Array([0x00, 0x00, 0x05, op_Join_Analog2, channel / 0x100, channel
                                        % 0x100, value / 0x100, value % 0x100])),
                    "Analog:" + (channel + 1) + " -> " + value)
    }
}
function ping() {
    tcpClient.sendData(cipmessage(op_Client_Ping, new Uint8Array([0x00, 0x00])))
    //sendAppendList(cipmessage2(op_Client_Ping,new Uint8Array([0x00, 0x00])), "发送Ping")
}

//Server
function pong() {
    tcpServer.sendData(cipmessage(op_Server_Pong, new Uint8Array([0x00, 0x00])))
}

function serverAccept() {
    tcpServer.sendData(cipmessage(op_Server_Accept, new Uint8Array([0x02])))
}

function toHexString(data, space) {
    let hexMessage = ""
    let s = space
    for (var i = 0; i < data.length; i++) {
        let hex = data[i].toString(16)
        // 将字节转换为十六进制
        if (hex.length < 2) {
            hex = "0" + hex // 补齐两位
        }
        hexMessage += hex
        hexMessage += s
    }
    return hexMessage.toUpperCase()
}

function recivedAppendList(message, index, payloadLength, detail) {
    root.listModel.append({
                              "time": new Date().toLocaleTimeString(
                                          Qt.locale("zh_CN"), " hh:mm:ss"),
                              "direction": "收",
                              "data": toHexString(
                                          message.slice(
                                              index,
                                              index + 3 + payloadLength), " "),
                              "detail": detail
                          })
}
function sendAppendList(data, detail) {
    root.listModel.append({
                              "time": new Date().toLocaleTimeString(
                                          Qt.locale("zh_CN"), " hh:mm:ss"),
                              "direction": "发",
                              "data": toHexString(data, " "),
                              "detail": detail
                          })
}
