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

    signal showChannelChanged

    property alias settings: settings

    Settings {
        id: settings
        property string ipAddress: config.cipServerIP
        property int ipPort: config.cipPort
        property int ipId: config.ipId
        property bool fullscreen: Qt.platform.os === "windows" ? false : true
        property string settingPassword: "123"
        property bool demoMode: false
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
                radius: height * 0.1
                onClicked: apply()
            }
            ColorButton {
                id: settingCancel
                width: parent.width * 0.16
                height: parent.height
                text: "取消"
                font.pixelSize: height * 0.4
                radius: height * 0.1
                onClicked: rootSetting.reject()
            }
            ColorButton {
                id: settingOK
                width: parent.width * 0.16
                height: parent.height
                text: "确定"
                font.pixelSize: height * 0.4
                radius: height * 0.1
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
                font.family: alibabaPuHuiTi.font.family
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
                    font.family: alibabaPuHuiTi.font.family
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
                    enabled: !demoMode.checked
                    font.family: alibabaPuHuiTi.font.family
                }
                Text {
                    text: "中控端口"
                    width: parent.width * 0.5
                    height: settingDialog.height / 12
                    font.pixelSize: height * 0.7
                    color: buttonTextColor
                    font.family: alibabaPuHuiTi.font.family
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
                    enabled: !demoMode.checked
                    font.family: alibabaPuHuiTi.font.family
                }

                Text {
                    text: "程序IPID"
                    width: parent.width * 0.5
                    height: settingDialog.height / 12
                    font.pixelSize: height * 0.7
                    color: buttonTextColor
                    font.family: alibabaPuHuiTi.font.family
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
                    font.family: alibabaPuHuiTi.font.family
                }
                Text {
                    text: "演示模式"
                    width: parent.width * 0.5
                    height: settingDialog.height / 12
                    font.pixelSize: height * 0.7
                    color: buttonTextColor
                    font.family: alibabaPuHuiTi.font.family
                }
                ColorSwitch {
                    height: settingDialog.height / 15
                    width: height * 2
                    id: demoMode
                    checked: settings.demoMode
                }

                Text {
                    text: "全屏显示"
                    width: parent.width * 0.5
                    height: settingDialog.height / 12
                    font.pixelSize: height * 0.7
                    color: buttonTextColor
                    font.family: alibabaPuHuiTi.font.family
                    visible: Qt.platform.os === "windows"
                }
                ColorSwitch {
                    height: settingDialog.height / 15
                    width: height * 2
                    id: fullscreen
                    checked: settings.fullscreen
                    visible: Qt.platform.os === "windows"
                }

                Text {
                    text: "系统设置密码"
                    width: parent.width * 0.5
                    height: settingDialog.height / 12
                    font.pixelSize: height * 0.7
                    color: buttonTextColor
                    font.family: alibabaPuHuiTi.font.family
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
                    font.family: alibabaPuHuiTi.font.family
                }
                Text {
                    text: "显示调试页面"
                    width: parent.width * 0.5
                    height: settingDialog.height / 12
                    font.pixelSize: height * 0.7
                    color: buttonTextColor
                    font.family: alibabaPuHuiTi.font.family
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
                    font.family: alibabaPuHuiTi.font.family
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
        demoMode.checked = settings.demoMode
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
        if (settings.demoMode !== demoMode.checked) {
            settings.demoMode = demoMode.checked
            tcpClient.disconnectFromServer()
            if (settings.demoMode) {
                tcpServer.startServer(41793, "127.0.0.1")
                tcpClient.connectToServer("127.0.0.1", 41793)
            } else {
                tcpServer.stopServer()
                tcpClient.connectToServer(settings.ipAddress, settings.ipPort)
            }
        }

        settings.settingPassword = settingPassword.text
        if (settings.showChannel !== showChannel.checked) {
            settings.showChannel = showChannel.checked
            showChannelChanged()
        }

        settings.darkTheme = darkTheme.checked
        if (settings.darkTheme) {
            root.Material.theme = Material.Dark
        } else {
            root.Material.theme = Material.Light
        }
        settings.sync()
    }
}
