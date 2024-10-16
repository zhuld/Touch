import QtQuick
import QtQuick.Controls
import QtCore

import "../Custom/"

Dialog {
    id: rootSetting
    anchors.centerIn: parent
    implicitWidth: parent.width * 0.9
    implicitHeight: parent.height * 0.9

    modal: true

    closePolicy: Popup.NoAutoClose

    property alias settings: settings

    Settings {
        id: settings
        property string ipAddress: "192.168.1.10"
        property int ipPort: 41794
        property int ipId: 3
        property bool fullscreen: true
        property string settingPassword: "123"
        property bool webSocketServer: false
        property int webSocketServerPort: 9880
        property bool showChannel: false
        property bool darkTheme: false
        property int windowWidth: 1280
        property int windowHeight: 800
    }

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

    background: Background {}

    Column {
        anchors.fill: parent
        anchors.margins: height * 0.05
        spacing: height * 0.05

        Row {
            id: settingButtons
            width: parent.width
            height: parent.height * 0.12
            spacing: width * 0.02
            layoutDirection: Qt.RightToLeft

            ColorButton {
                id: settingApply
                width: parent.width * 0.16
                height: parent.height
                text: "应用"
                font.pixelSize: height * 0.4
                onClicked: apply()
            }
            ColorButton {
                id: settingCancel
                width: parent.width * 0.16
                height: parent.height
                text: "取消"
                font.pixelSize: height * 0.4
                onClicked: rootSetting.reject()
            }
            ColorButton {
                id: settingOK
                width: parent.width * 0.16
                height: parent.height
                text: "确定"
                font.pixelSize: height * 0.4
                onClicked: rootSetting.accept()
            }
            Text {
                width: parent.width * 0.46
                height: parent.height
                text: "系统设置 V" + config.version
                font.pixelSize: height * 0.5
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignLeft
                color: buttonTextColor
            }
        }
        ScrollView {
            id: scrollView
            width: parent.width
            height: parent.height * 0.88
            contentWidth: parent.width * 0.9
            contentHeight: Grid.height
            anchors.margins: height / 20

            Behavior on ScrollBar.vertical.position {
                NumberAnimation {
                    duration: 250
                }
            }

            Grid {
                width: parent.width
                columns: 2
                spacing: parent.parent.height * 0.05

                Text {
                    text: "中控IP地址"
                    width: parent.width * 0.5
                    height: settingDialog.height / 12
                    font.pixelSize: height * 0.7
                    color: buttonTextColor
                }

                TextField {
                    id: ipAddress
                    width: parent.width * 0.5
                    height: settingDialog.height / 12
                    font.pixelSize: height * 0.7
                    text: settings.ipAddress
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: RegularExpressionValidator {
                        regularExpression: /(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}/
                    }
                    color: acceptableInput ? buttonTextColor : buttonTextRedColor
                    onFocusChanged: {
                        if (focus) {
                            scrollView.ScrollBar.vertical.position = y / scrollView.contentHeight
                        }
                    }
                }
                Text {
                    text: "中控端口"
                    width: parent.width * 0.5
                    height: settingDialog.height / 12
                    font.pixelSize: height * 0.7
                    color: buttonTextColor
                }

                TextField {
                    id: ipPort
                    width: parent.width * 0.5
                    height: settingDialog.height / 12
                    font.pixelSize: height * 0.7
                    text: settings.ipPort
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator {
                        bottom: 1024
                        top: 49151
                    }
                    color: acceptableInput ? buttonTextColor : buttonTextRedColor
                    onFocusChanged: {
                        if (focus) {
                            scrollView.ScrollBar.vertical.position = y / scrollView.contentHeight
                        }
                    }
                }

                Text {
                    text: "程序IPID"
                    width: parent.width * 0.5
                    height: settingDialog.height / 12
                    font.pixelSize: height * 0.7
                    color: buttonTextColor
                }

                TextField {
                    id: ipId
                    width: parent.width * 0.5
                    height: settingDialog.height / 12
                    font.pixelSize: height * 0.7
                    text: settings.ipId
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator {
                        bottom: 1
                        top: 255
                    }
                    color: acceptableInput ? buttonTextColor : buttonTextRedColor
                    onFocusChanged: {
                        if (focus) {
                            scrollView.ScrollBar.vertical.position = y / scrollView.contentHeight
                        }
                    }
                }

                Text {
                    text: "全屏显示"
                    width: parent.width * 0.5
                    height: settingDialog.height / 12
                    font.pixelSize: height * 0.7
                    color: buttonTextColor
                }
                ColorSwitch {
                    height: settingDialog.height / 15
                    width: height * 2
                    id: fullscreen
                    checked: settings.fullscreen
                }

                Text {
                    text: "系统设置密码"
                    width: parent.width * 0.5
                    height: settingDialog.height / 12
                    font.pixelSize: height * 0.7
                    color: buttonTextColor
                }

                TextField {
                    id: settingPassword
                    width: parent.width * 0.5
                    height: settingDialog.height / 12
                    font.pixelSize: height * 0.7
                    text: settings.settingPassword
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator {
                        bottom: 0
                        top: 999999
                    }
                    color: acceptableInput ? buttonTextColor : buttonTextRedColor
                    onFocusChanged: {
                        if (focus) {
                            scrollView.ScrollBar.vertical.position = y / scrollView.contentHeight
                        }
                    }
                }
                Text {
                    text: "显示通道号码"
                    width: parent.width * 0.5
                    height: settingDialog.height / 12
                    font.pixelSize: height * 0.7
                    color: buttonTextColor
                }
                ColorSwitch {
                    height: settingDialog.height / 15
                    width: height * 2
                    id: showChannel
                    checked: settings.showChannel
                }
                Text {
                    text: "暗色主题"
                    width: parent.width * 0.5
                    height: settingDialog.height / 12
                    font.pixelSize: height * 0.7
                    color: buttonTextColor
                }
                ColorSwitch {
                    height: settingDialog.height / 15
                    width: height * 2
                    id: darkTheme
                    checked: settings.darkTheme
                }
            }
        }
    }

    onAccepted: {
        apply()
    }

    onRejected: {
        ipAddress.text = settings.ipAddress
        ipPort.text = settings.ipPort
        ipId.text = settings.ipId
        fullscreen.checked = settings.fullscreen
        settingPassword.text = settings.settingPassword
        showChannel.checked = settings.showChannel
        darkTheme.checked = settings.darkTheme
        settings.sync()
    }
    function apply() {
        settings.ipAddress = ipAddress.text
        settings.ipPort = ipPort.text
        settings.ipId = ipId.text
        settings.fullscreen = fullscreen.checked
        settings.settingPassword = settingPassword.text
        settings.showChannel = showChannel.checked
        settings.darkTheme = darkTheme.checked
        settings.sync()
    }
}
