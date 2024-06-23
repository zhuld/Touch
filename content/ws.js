function getBoundString(msg, startChar, stopChar)
{
    var response = "";

    if (msg !== null && msg.length > 0)
    {
        var start = msg.indexOf(startChar);

        if (start >= 0)
        {
            start += startChar.length;

            var end = msg.indexOf(stopChar, start);

            if (start < end)
            {
                response = msg.substring(start, end);
            }
        }
    }
    return response;
}

function getBoundString_EndLastIndex(msg, startChar, stopChar)
{
    var response = "";

    if (msg !== null && msg.length > 0)
    {
        var start = msg.indexOf(startChar);

        if (start >= 0)
        {
            start += startChar.length;

            var end = msg.lastIndexOf(stopChar);

            if (start < end)
            {
                response = msg.substring(start, end);
            }
        }
    }

    return response;
}

function checkMessage(message)
{
    if (message !== null)
    {
        var msg = message;
        var channel
        var value
        var txt

        //ON[CHANNEL]
        if (msg.indexOf("ON[") === 0)
        {
            channel = parseInt(getBoundString(msg, "ON[", "]"), 10);

            if (isNaN(channel) === false)
            {
                var tmp1 = root.digital
                tmp1[channel] = true
                root.digital = tmp1
            }
        }
        //OFF[CHANNEL]
        else if (msg.indexOf("OFF[") === 0)
        {
            channel = parseInt(getBoundString(msg, "OFF[", "]"), 10);

            if (isNaN(channel) === false)
            {
                var tmp2 = root.digital
                tmp2[channel] = false
                root.digital = tmp2
            }
        }
        // LEVEL[CHANNEL,VALUE]
        else if (msg.indexOf("LEVEL[") === 0)
        {
            channel = parseInt(getBoundString(msg, "LEVEL[", ","), 10);
            value = parseInt(getBoundString(msg, ",", "]"), 10);

            var tmp3 = root.analog
            tmp3[channel] = value
            root.analog = tmp3

        }
        // STRING[CHANNEL,DATA]
        else if (msg.indexOf("STRING[") === 0)
        {
            channel = parseInt(getBoundString(msg, "STRING[", ","), 10);
            txt = getBoundString_EndLastIndex(msg, ",", "]");

            var tmp4 = root.text
            tmp4[channel] = txt
            root.text = tmp4
        }
    }
}

function push(channel){
    if(channel > 0){

        //wsClient.sendTextMessage(("ON[" + channel + "]"))
        wsClient.sendTextMessage(("PUSH[" + channel + "]"))
    }
}
function release(channel){
    if(channel > 0){
        //wsClient.sendTextMessage(("OFF[" + channel + "]"))
        wsClient.sendTextMessage(("RELEASE[" + channel + "]"))
    }
}
function level(channel,value){
    if(channel > 0){
        wsClient.sendTextMessage(("LEVEL[" + channel + "," + value + "]"))
    }
}
function text(channel,value){
    if(channel > 0){
        wsClient.sendTextMessage(("STRING[" + channel + "," + value + "]"))
    }
}
