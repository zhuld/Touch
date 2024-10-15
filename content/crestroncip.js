const op_Server_Accept = 0x0F // 服务器接受连接 0F 00 01 02
const op_Client_IPID = 0x01 // 发送IPID 01 00 0B 7F 00 00 01 00 XX 40
const op_Server_IPID = 0x02 // 回复 02 00 04 00 00 00 03

const op_Join = 0x05 // 发送 Join信息
const op_Join_Digital = 0x00
const op_Join_Analog = 0x01
const op_Join_Serial = 0x02
const op_Join_Request = 0x03

const op_Client_Ping = 0x0D // 定时发送 0D 00 02 00 00
const op_Server_Pong = 0x0E // 回复 0E 00 02 00 00

function messageCheck(message) {
    //连接消息
    if (message[0] === op_Server_Accept) {
        if (message.length === 4 & message[3] === 0x02) {
            return cipmessage(
                        op_Client_IPID,
                        new Uint8Array([0x7F, 0x00, 0x00, 0x01, 0x00, settings.ipId, 0x40])).buffer
            //return cipmessage( op_Client_IPID, new Uint8Array([0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, 0x40, 0xFF, 0xFF, 0xF1, 0x01])).buffer
        }
    }
    if (message[0] === op_Server_IPID) {
        if (message.length === 7 & message[6] === 0x03) {
            return cipmessage(
                        op_Join,
                        new Uint8Array([0x00, 0x00, 0x02, op_Join_Request, 0x00])).buffer
        }
    } else if (message[0] === op_Join) {
        //Join事件
        if (message[6] === op_Join_Digital) {
            //digital
            var channelD = message[7] + (message[8] & 0x7F) * 0x100 + 1
            if (isNaN(channelD) === false) {
                var tmpD = root.digital
                tmpD[channelD] = !(message[8] & 0x80)
                root.digital = tmpD
            }
        } else if (message[6] === op_Join_Analog) {
            //analog
            var channelA
            var tmpA = root.analog
            if (message[2] === 0x08) {
                channelA = message[7] * 0x100 + message[8] + 1
            } else if (message[2] === 0x07) {
                channelA = message[7] + 1
            }

            if (isNaN(channelA) === false) {
                if (channelA > 0x100) {
                    tmpA[channelA] = message[9] * 0x100 + message[10]
                } else {
                    tmpA[channelA] = message[8] * 0x100 + message[9]
                }
                root.analog = tmpA
            }
        }
    }
}

function cipmessage(opCode, message) {
    var m = new Uint8Array(message.length + 3)
    m[0] = opCode
    m[1] = message.length / 0x100
    m[2] = message.length % 0x100
    m.set(message, 3)
    return m
}

function push(channel) {
    if (channel > 0 & channel < 32767) {
        channel = channel - 1
        return cipmessage(
                    op_Join,
                    new Uint8Array([0x00, 0x00, 0x03, op_Join_Digital, channel
                                    % 0x100, channel / 0x100])).buffer
    }
}
function release(channel) {
    if (channel > 0 & channel < 32767) {
        channel = channel - 1
        return cipmessage(
                    op_Join,
                    new Uint8Array([0x00, 0x00, 0x03, op_Join_Digital, channel
                                    % 0x100, (channel / 0x100) | 0x80])).buffer
    }
}
function level(channel, value) {
    if (channel > 0 & channel < 65536) {
        channel = channel - 1
        return cipmessage(
                    op_Join,
                    new Uint8Array([0x00, 0x00, 0x05, op_Join_Analog, channel / 0x100, channel
                                    % 0x100, value / 0x100, value % 0x100])).buffer
    }
}
function ping() {
    return cipmessage(op_Client_Ping, new Uint8Array([0x00, 0x00])).buffer
}
