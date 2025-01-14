import QtQuick
import QtQuick.Controls

import "../Custom/"

Dialog {
    id: rootPassword

    readonly property real ratio: 0.9
    property int autoClose: 30
    property int during
    property bool error: false

    implicitWidth: parent.width / parent.height
                   < ratio ? parent.width * 0.9 : parent.height * 0.9 * ratio
    implicitHeight: implicitWidth / ratio

    signal passwordEnter(var password)

    anchors.centerIn: parent

    modal: true
    closePolicy: Popup.CloseOnPressOutside

    Overlay.modal: Rectangle {
        color: "#80000000"
    }

    enter: Transition {
        NumberAnimation {
            from: 0
            to: 1
            property: "opacity"
            duration: 100
        }
    }
    exit: Transition {
        NumberAnimation {
            from: 1
            to: 0
            property: "opacity"
            duration: 100
        }
    }

    Timer {
        id: countDownTimer
        interval: 1000
        repeat: true
        triggeredOnStart: false
        onTriggered: {
            during--
            if (during === 0) {
                rootPassword.close()
            }
        }
    }
    onOpened: {
        during = autoClose
        countDownTimer.start()
    }

    onClosed: {
        password.text = ""
        rootPassword.error = false
        countDownTimer.stop()
    }
    background: Background {}

    Column {
        id: base
        anchors.fill: parent
        anchors.margins: width * 0.02
        spacing: height * 0.02
        MyIconLabel {
            id: passwordTitle
            height: parent.height * 0.06
            color: Global.buttonTextColor
            text: "请输入密码：" + (rootPassword.error ? " 密码错误" : "")
            font.pixelSize: height
        }

        TextInput {
            id: password
            x: parent.width * 0.03
            width: parent.width
            height: parent.height * 0.17
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: height * 0.4
            font.letterSpacing: parent.width * 0.06
            color: Global.buttonTextColor
            enabled: false
            focus: true
            echoMode: TextInput.Password
            passwordMaskDelay: 500
            font.family: Global.alibabaPuHuiTi.font.family
        }

        Grid {
            id: numberPad
            width: parent.width * 0.6
            height: width * 1.33
            anchors.margins: parent.width * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            columns: 3
            spacing: width * 0.05
            Repeater {
                model: ListModel {
                    id: numberModel
                    ListElement {
                        name: "1"
                    }
                    ListElement {
                        name: "2"
                    }
                    ListElement {
                        name: "3"
                    }
                    ListElement {
                        name: "4"
                    }
                    ListElement {
                        name: "5"
                    }
                    ListElement {
                        name: "6"
                    }
                    ListElement {
                        name: "7"
                    }
                    ListElement {
                        name: "8"
                    }
                    ListElement {
                        name: "9"
                    }
                    ListElement {
                        name: "\u21E6"
                    }
                    ListElement {
                        name: "0"
                    }
                    ListElement {
                        name: "\u23CE"
                    }
                }
                delegate: ColorButton {
                    width: (numberPad.width + numberPad.spacing)
                           / numberPad.columns - numberPad.spacing
                    height: width
                    radius: height / 2
                    text: name
                    btnColor: name === "\u23CE" ? Global.buttonColor : Global.backgroundColor
                    onPressedChanged: {
                        if (!pressed) {
                            switch (name) {
                            case "1":
                            case "2":
                            case "3":
                            case "4":
                            case "5":
                            case "6":
                            case "7":
                            case "8":
                            case "9":
                            case "0":
                                if (password.text.length < 6) {
                                    password.text += name
                                }
                                break
                            case "\u21E6":
                                password.text = password.text.slice(
                                            0, password.text.length - 1)
                                break
                            case "\u23CE":
                                passwordEnter(password.text)
                                password.text = ""
                                break
                            }
                        }
                    }
                }
            }
        }
    }
}
