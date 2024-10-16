import QtQuick
import QtQuick.Controls

import "../Custom/"

Dialog {
    id: rootPassword

    readonly property real ratio: 0.9

    property int during: 30

    implicitWidth: parent.width / parent.height
                   < ratio ? parent.width * 0.9 : parent.height * 0.9 * ratio
    implicitHeight: implicitWidth / ratio

    signal okPressed(var password)

    anchors.centerIn: parent

    modal: true
    closePolicy: Popup.CloseOnPressOutside

    Overlay.modal: Rectangle {
        color: "#A0000000"
    }

    enter: Transition {
        NumberAnimation {
            from: 0
            to: 1
            property: "opacity"
            duration: 200
        }
    }
    exit: Transition {
        NumberAnimation {
            from: 1
            to: 0
            property: "opacity"
            duration: 200
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
    onOpened: countDownTimer.start()

    onClosed: {
        password.text = ""
        countDownTimer.stop()
        during = 30
    }
    background: Background {}

    Column {
        id: base
        anchors.fill: parent
        anchors.margins: width * 0.02

        Text {
            id: passwordTitle
            width: parent.width
            height: parent.height * 0.08
            text: "请输入密码"
            font.pixelSize: height * 0.7
            wrapMode: Text.Wrap
            horizontalAlignment: Text.AlignLeft
            color: textColor
            IconButton {
                id: close
                height: parent.height
                width: height
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                icon.source: "qrc:/content/icons/close.png"
                onClicked: {
                    rootPassword.close()
                }
                visible: during < 20
            }
        }

        TextInput {
            id: password
            x: parent.width * 0.03
            width: parent.width
            height: parent.height * 0.18
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: height * 0.5
            font.letterSpacing: parent.width * 0.06
            color: textColor
            enabled: false
            focus: true
            echoMode: TextInput.Password
            passwordMaskDelay: 500
        }

        Grid {
            id: numberPad
            width: parent.width * 0.6
            height: width * 1.33
            anchors.margins: parent.width * 0.1
            anchors.horizontalCenter: parent.horizontalCenter

            columns: 3
            spacing: width * 0.02
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
                    btnRadius: width / 2
                    font.pixelSize: width * 0.5
                    text: name
                    onClicked: {
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
                            okPressed(password.text)
                            password.text = ""
                            break
                        }
                    }
                }
            }
        }
    }
}
