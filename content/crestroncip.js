const op_Server_Accept = 0x0F // 服务器接受连接 0F 00 01 02
const op_Client_IPID = 0x01 // 发送IPID 01 00 0B 00 00 00 00 00 XX 40 FF FF F1 01
const op_Server_IPID = 0x02 // 回复 02 00 04 00 00 00 1F ok; 02 00 03 FF FF 02 failed

const op_Join = 0x05 // 发送 Join信息
const op_Join_Digital = 0x00
const op_Join_Analog = 0x01
const op_Join_Serial = 0x02
const op_Join_Request = 0x03

const op_Client_Ping = 0x0D // 定时发送 0D 00 02 00 00
const op_Server_Pong = 0x0E // 回复 0E 00 02 00 00

function clientMessageCheck(message) {
    let index = 0
    while (index < message.length) {
        let payloadType = message[index]
        let payloadLength = message[index + 2]
        let payload = message.slice(index + 3, index + 3 + payloadLength)
        //连接消息
        switch (payloadType) {
        case op_Server_Accept:
            if (payload.length === 1 && payload[0] === 0x02) {
                return cipmessage(
                            op_Client_IPID,
                            new Uint8Array([0x00, 0x00, 0x00, 0x00, 0x00, settings.ipId, 0x40, 0xFF, 0xFF, 0xF1, 0x01]))
            }
            break
        case op_Server_IPID:
            if (toHexString(payload) === "0000200F") {
                //"0000001F",0000200F
                return cipmessage(
                            op_Join,
                            new Uint8Array([0x00, 0x00, 0x02, op_Join_Request, 0x00]))
            } else if (toHexString(payload) === "FFFF02") {
                console.log("registration failed")
            }
            break
        case op_Join:
            //Join事件
            switch (payload[3]) {
            case op_Join_Digital:
                //digital
                let channelD = payload[4] + (payload[5] & 0x7F) * 0x100 + 1
                if (isNaN(channelD) === false) {
                    let tmpD = root.digital
                    tmpD[channelD] = !(payload[5] & 0x80)
                    root.digital = tmpD
                }
                break
            case op_Join_Analog:
                //analog
                let channelA
                let tmpA = root.analog
                if (payloadLength === 8) {
                    channelA = payload[4] * 0x100 + payload[5] + 1
                } else if (payloadLength === 7) {
                    channelA = payload[4] + 1
                }
                if (isNaN(channelA) === false) {
                    if (channelA > 0x100) {
                        tmpA[channelA] = payload[6] * 0x100 + payload[7]
                    } else {
                        tmpA[channelA] = payload[5] * 0x100 + payload[6]
                    }
                    root.analog = tmpA
                }
                break
            }
            break
        }
        index = index + payloadLength + 3
    }
}

function serverMessageCheck(message) {
    let index = 0
    while (index < message.length) {
        let payloadType = message[index]
        let payloadLength = message[index + 2]
        let payload = message.slice(index + 3, index + 3 + payloadLength)
        switch (payloadType) {
        case op_Client_IPID:
            // 收到IPID信息
            if (payloadLength === 11 & payload[5] === settings.ipId) {
                return cipmessage(
                            op_Server_IPID,
                            new Uint8Array([0x00, 0x00, 0x20, 0x0F])) //0000200f
            } else {
                return cipmessage(op_Server_IPID,
                                  new Uint8Array([0xFF, 0xFF, 0x02]))
            }
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
                return cipmessage(op_Join, payload)
            case op_Join_Analog:
                if (payloadLength === 8) {
                    if (payload[4] === 0x00) {
                        return cipmessage(
                                    op_Join,
                                    new Uint8Array([0x00, 0x00, 0x04, op_Join_Analog, payload[5], payload[6], payload[7]]))
                    } else {
                        return cipmessage(
                                    op_Join,
                                    new Uint8Array([0x00, 0x00, 0x04, op_Join_Analog, message[4], payload[5], payload[6], payload[7]]))
                    }
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

//client
function push(channel) {
    if (channel > 0 & channel < 32767) {
        channel = channel - 1
        return cipmessage(
                    op_Join,
                    new Uint8Array([0x00, 0x00, 0x03, op_Join_Digital, channel
                                    % 0x100, channel / 0x100]))
    }
}
function release(channel) {
    if (channel > 0 & channel < 32767) {
        channel = channel - 1
        return cipmessage(
                    op_Join,
                    new Uint8Array([0x00, 0x00, 0x03, op_Join_Digital, channel
                                    % 0x100, (channel / 0x100) | 0x80]))
    }
}
function level(channel, value) {
    if (channel > 0 & channel < 65536) {
        channel = channel - 1
        return cipmessage(
                    op_Join,
                    new Uint8Array([0x00, 0x00, 0x05, op_Join_Analog, channel
                                    / 0x100, channel % 0x100, value / 0x100, value % 0x100]))
    }
}
function ping() {
    return cipmessage(op_Client_Ping, new Uint8Array([0x00, 0x00]))
}

//Server
function pong() {
    return cipmessage(op_Server_Pong, new Uint8Array([0x00, 0x00]))
}

function accept() {
    return cipmessage(op_Server_Accept, new Uint8Array([0x02]))
}

function toHexString(data) {
    let hexMessage = ""
    for (var i = 0; i < data.length; i++) {
        let hex = data[i].toString(16)
        // 将字节转换为十六进制
        if (hex.length < 2) {
            hex = "0" + hex // 补齐两位
        }
        hexMessage += hex
    }
    return hexMessage.toUpperCase()
}
