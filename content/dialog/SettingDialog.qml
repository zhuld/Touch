import QtQuick
import QtQuick.Controls

import "../Custom/"

Dialog {
    id: rootSetting
    anchors.centerIn: parent
    implicitWidth: parent.width * 0.9
    implicitHeight: parent.height * 0.9

    modal: true

    closePolicy: Popup.NoAutoClose

    signal showChannelChanged

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
        anchors.margins: height * 0.02
        spacing: height * 0.05
        Row {
            id: settingButtons
            width: parent.width
            height: parent.height * 0.22
            spacing: width * 0.02
            layoutDirection: Qt.RightToLeft

            ColorButton {
                id: settingApply
                width: parent.width * 0.16
                height: parent.height * 0.5
                text: "应用"
                onPressedChanged: {
                    if (!pressed) {
                        apply()
                    }
                }
            }
            ColorButton {
                id: settingCancel
                width: parent.width * 0.16
                height: parent.height * 0.5
                text: "取消"
                onPressedChanged: {
                    if (!pressed) {
                        rootSetting.reject()
                    }
                }
            }
            ColorButton {
                id: settingOK
                width: parent.width * 0.16
                height: parent.height * 0.5
                text: "确定"
                onPressedChanged: {
                    if (!pressed) {
                        rootSetting.accept()
                    }
                }
            }
            Text {
                width: parent.width * 0.46
                height: parent.height * 0.6
                text: "系统设置\n\rV" + config.version
                font.pixelSize: height * 0.5
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignLeft
                color: Global.buttonTextColor
                font.family: Global.alibabaPuHuiTi.font.family
            }
        }
        ScrollView {
            id: scrollView
            width: parent.width
            height: parent.height * 0.74
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
                spacing: rootSetting.height * 0.01
                Text {
                    text: "中控IP地址"
                    width: parent.width * 0.5
                    height: rootSetting.height /15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                TextField {
                    id: ipAddress
                    width: parent.width * 0.5
                    height: rootSetting.height /15
                    font.pixelSize: height * 0.7
                    text: Global.settings.ipAddress
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: RegularExpressionValidator {
                        regularExpression: /(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}/
                    }
                    color: acceptableInput ? Global.buttonTextColor : Global.buttonTextRedColor
                    onFocusChanged: {
                        if (focus) {
                            scrollView.ScrollBar.vertical.position = y / scrollView.contentHeight
                        }
                    }
                    enabled: !demoMode.checked
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                Text {
                    text: "中控端口"
                    width: parent.width * 0.5
                    height: rootSetting.height /15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                TextField {
                    id: ipPort
                    width: parent.width * 0.5
                    height: rootSetting.height /15
                    font.pixelSize: height * 0.7
                    text: Global.settings.ipPort
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator {
                        bottom: 1024
                        top: 49151
                    }
                    color: acceptableInput ? Global.buttonTextColor : Global.buttonTextRedColor
                    onFocusChanged: {
                        if (focus) {
                            scrollView.ScrollBar.vertical.position = y / scrollView.contentHeight
                        }
                    }
                    enabled: !demoMode.checked
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                Text {
                    text: "程序IPID"
                    width: parent.width * 0.5
                    height: rootSetting.height /15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                TextField {
                    id: ipId
                    width: parent.width * 0.5
                    height: rootSetting.height /15
                    font.pixelSize: height * 0.7
                    text: Global.settings.ipId
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator {
                        bottom: 1
                        top: 255
                    }
                    color: acceptableInput ? Global.buttonTextColor : Global.buttonTextRedColor
                    onFocusChanged: {
                        if (focus) {
                            scrollView.ScrollBar.vertical.position = y / scrollView.contentHeight
                        }
                    }
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                Text {
                    text: demoMode.checked ? "演示模式" : "连接模式"
                    width: parent.width * 0.5
                    height: rootSetting.height /15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                ColorSwitch {
                    height: rootSetting.height /15
                    width: height * 2
                    id: demoMode
                    checked: Global.settings.demoMode
                }
                Text {
                    text: fullscreen.checked ? "全屏显示" : "窗口模式"
                    width: parent.width * 0.5
                    height: rootSetting.height /15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                    visible: Qt.platform.os === "windows"
                }
                ColorSwitch {
                    height: rootSetting.height /15
                    width: height * 2
                    id: fullscreen
                    checked: Global.settings.fullscreen
                    visible: Qt.platform.os === "windows"
                }
                Text {
                    text: "系统设置密码"
                    width: parent.width * 0.5
                    height: rootSetting.height /15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                TextField {
                    id: settingPassword
                    width: parent.width * 0.5
                    height: rootSetting.height /15
                    font.pixelSize: height * 0.7
                    text: Global.settings.settingPassword
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator {
                        bottom: 0
                        top: 999999
                    }
                    color: acceptableInput ? Global.buttonTextColor : Global.buttonTextRedColor
                    onFocusChanged: {
                        if (focus) {
                            scrollView.ScrollBar.vertical.position = y / scrollView.contentHeight
                        }
                    }
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                Text {
                    text: showChannel.checked ? "显示调试信息" : "隐藏调试信息"
                    width: parent.width * 0.5
                    height: rootSetting.height /15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                ColorSwitch {
                    height: rootSetting.height /15
                    width: height * 2
                    id: showChannel
                    checked: Global.settings.showChannel
                }
                Text {
                    text: darkTheme.checked ? "深色主题" : "浅色主题"
                    width: parent.width * 0.5
                    height: rootSetting.height /15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                ColorSwitch {
                    height: rootSetting.height /15
                    width: height * 2
                    id: darkTheme
                    checked: Global.settings.darkTheme
                }
                Text {
                    text: tabPosition.checked ? "底部导航栏" : "左侧导航栏"
                    width: parent.width * 0.5
                    height: rootSetting.height /15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                ColorSwitch {
                    height: rootSetting.height /15
                    width: height * 2
                    id: tabPosition
                    checked: Global.settings.tabOnBottom
                }
            }
        }
    }

    onAccepted: {
        apply()
    }

    onOpened: {
        darkTheme.checked = Global.settings.darkTheme
    }

    onRejected: {
        ipAddress.text = Global.settings.ipAddress
        ipPort.text = Global.settings.ipPort
        ipId.text = Global.settings.ipId
        fullscreen.checked = Global.settings.fullscreen
        demoMode.checked = Global.settings.demoMode
        settingPassword.text = Global.settings.settingPassword
        showChannel.checked = Global.settings.showChannel
        darkTheme.checked = Global.settings.darkTheme
        tabPosition.checked = Global.settings.tabOnBottom
        Global.settings.sync()
    }
    function apply() {
        Global.settings.ipAddress = ipAddress.text
        Global.settings.ipPort = ipPort.text
        Global.settings.ipId = ipId.text
        Global.settings.fullscreen = fullscreen.checked
        if (Global.settings.demoMode !== demoMode.checked) {
            Global.settings.demoMode = demoMode.checked
            tcpClient.disconnectFromServer()
        }
        Global.settings.settingPassword = settingPassword.text
        if (Global.settings.showChannel !== showChannel.checked) {
            Global.settings.showChannel = showChannel.checked
            showChannelChanged()
        }
        Global.settings.darkTheme = darkTheme.checked
        Global.settings.tabOnBottom = tabPosition.checked
        Global.settings.sync()
    }
}
