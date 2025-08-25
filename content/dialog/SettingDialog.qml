pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

Dialog {
    id: rootSetting
    anchors.centerIn: parent
    implicitWidth: parent.width * 0.9
    implicitHeight: parent.height * 0.9

    modal: true

    closePolicy: Popup.NoAutoClose

    signal showChannelChanged

    enter: Transition {
        NumberAnimation {
            from: 0
            to: 1
            property: "opacity"
            duration: Global.durationDelay
        }
    }
    exit: Transition {
        NumberAnimation {
            from: 1
            to: 0
            property: "opacity"
            duration: Global.durationDelay
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
                id: settingOK
                width: parent.width * 0.2
                height: parent.height * 0.6
                text: "确定"
                onClicked: rootSetting.accept()
                btnColor: Global.buttonColor
            }
            ColorButton {
                id: settingApply
                width: parent.width * 0.2
                height: parent.height * 0.6
                text: "应用"
                onClicked: rootSetting.apply()
            }
            ColorButton {
                id: settingCancel
                width: parent.width * 0.2
                height: parent.height * 0.6
                text: "取消"
                onClicked: rootSetting.reject()
            }
            Text {
                width: parent.width * 0.34
                height: parent.height * 0.6
                text: "系统设置\n请勿随意修改\nV" + Global.config.version
                font.pixelSize: height * 0.35
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
            Behavior on ScrollBar.vertical.position {
                NumberAnimation {
                    duration: Global.durationDelay
                }
            }
            Grid {
                width: parent.width
                columns: 2
                spacing: rootSetting.height * 0.01
                Text {
                    text: "配置选择"
                    width: parent.width * 0.3
                    height: rootSetting.height / 15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                ComboBox {
                    id: configComboBox
                    width: parent.width * 0.7
                    height: rootSetting.height / 15
                    font.pixelSize: height * 0.6
                    font.family: Global.alibabaPuHuiTi.font.family
                    model: Global.configListModel
                    currentIndex: Global.settings.configSetting
                    delegate: ItemDelegate {
                        id: item
                        required property string modelData
                        contentItem: Text {
                            text: item.modelData
                            font: configComboBox.font
                            height: configComboBox.height
                            width: configComboBox.width
                            color: Global.buttonTextColor
                        }
                    }
                    contentItem: Text {
                        leftPadding: 15
                        text: configComboBox.displayText
                        font: configComboBox.font
                        anchors.fill: parent
                        color: Global.buttonTextColor
                    }

                    indicator: MyIconLabel {
                        icon.source: configComboBox.down ? "qrc:/content/icons/down2.png" : "qrc:/content/icons/down.png"
                        icon.color: Global.buttonTextColor
                        width: parent.height
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                    }

                    background: Rectangle {
                        color: "transparent"
                        border.color: Global.buttonTextColor
                        radius: height / 10
                    }

                    popup: Popup {
                        y: configComboBox.height
                        width: configComboBox.width
                        implicitHeight: contentItem.implicitHeight
                        padding: 1

                        contentItem: ListView {
                            spacing: configComboBox.height / 5
                            clip: true
                            implicitHeight: contentHeight
                            model: configComboBox.popup.visible ? configComboBox.delegateModel : null
                            currentIndex: configComboBox.highlightedIndex
                        }

                        background: Rectangle {
                            color: Global.buttonColor
                        }
                    }
                }
                Text {
                    text: "中控IP地址"
                    width: parent.width * 0.3
                    height: rootSetting.height / 15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                }

                TextField {
                    id: ipAddress
                    width: parent.width * 0.7
                    height: rootSetting.height / 15
                    font.pixelSize: height * 0.6
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
                    font.family: Global.alibabaPuHuiTi.font.family
                    background: Rectangle {
                        color: "transparent"
                        border.color: Global.buttonTextColor
                        radius: height / 10
                    }
                }

                Text {
                    text: "中控端口"
                    width: parent.width * 0.3
                    height: rootSetting.height / 15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                TextField {
                    id: ipPort
                    width: parent.width * 0.7
                    height: rootSetting.height / 15
                    font.pixelSize: height * 0.6
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
                    font.family: Global.alibabaPuHuiTi.font.family
                    background: Rectangle {
                        color: "transparent"
                        border.color: Global.buttonTextColor
                        radius: height / 10
                    }
                }

                Text {
                    text: "程序IPID"
                    width: parent.width * 0.3
                    height: rootSetting.height / 15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                TextField {
                    id: ipId
                    width: parent.width * 0.7
                    height: rootSetting.height / 15
                    font.pixelSize: height * 0.6
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
                    background: Rectangle {
                        color: "transparent"
                        border.color: Global.buttonTextColor
                        radius: height / 10
                    }
                }

                Text {
                    text: "系统设置密码"
                    width: parent.width * 0.3
                    height: rootSetting.height / 15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                }

                TextField {
                    id: settingPassword
                    width: parent.width * 0.7
                    height: rootSetting.height / 15
                    font.pixelSize: height * 0.6
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
                    background: Rectangle {
                        color: "transparent"
                        border.color: Global.buttonTextColor
                        radius: height / 10
                    }
                }

                Text {
                    text: "模式"
                    width: parent.width * 0.4
                    height: rootSetting.height / 15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                ColorSwitch {
                    height: rootSetting.height / 15
                    width: height * 3
                    id: demoMode
                    checked: Global.settings.demoMode
                    text: checked ? "演示模式" : "连接中控"
                }
                Text {
                    text: "显示"
                    width: parent.width * 0.4
                    height: rootSetting.height / 15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                    visible: Qt.platform.os === "windows"
                }
                ColorSwitch {
                    height: rootSetting.height / 15
                    width: height * 1.6
                    id: fullscreen
                    checked: Global.settings.fullscreen
                    visible: Qt.platform.os === "windows"
                    text: checked ? "全屏" : "窗口"
                }
                Text {
                    text: "调试信息"
                    width: parent.width * 0.4
                    height: rootSetting.height / 15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                ColorSwitch {
                    height: rootSetting.height / 15
                    width: height * 1.6
                    id: showChannel
                    checked: Global.settings.showChannel
                    text: checked ? "显示调试信息" : "隐藏调试信息"
                }
                Text {
                    text: "主题"
                    width: parent.width * 0.4
                    height: rootSetting.height / 15
                    font.pixelSize: height * 0.7
                    color: Global.buttonTextColor
                    font.family: Global.alibabaPuHuiTi.font.family
                }
                ColorSwitch {
                    height: rootSetting.height / 15
                    width: height * 1.6
                    id: darkTheme
                    checked: Global.settings.darkTheme
                    text: checked ? "深色主题" : "浅色主题"
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
        configComboBox.currentIndex = Global.settings.configSetting
        ipAddress.text = Global.settings.ipAddress
        ipPort.text = Global.settings.ipPort
        ipId.text = Global.settings.ipId
        fullscreen.checked = Global.settings.fullscreen
        demoMode.checked = Global.settings.demoMode
        settingPassword.text = Global.settings.settingPassword
        showChannel.checked = Global.settings.showChannel
        darkTheme.checked = Global.settings.darkTheme
        Global.settings.sync()
    }

    function apply() {
        if (Global.settings.configSetting !== configComboBox.currentIndex) {
            Global.settings.configSetting = configComboBox.currentIndex
            Global.config = Global.configList[Global.settings.configSetting]
            root.running = false
        }
        Global.settings.ipAddress = ipAddress.text
        Global.settings.ipPort = ipPort.text
        Global.settings.ipId = ipId.text
        Global.settings.fullscreen = fullscreen.checked
        if (Global.settings.demoMode !== demoMode.checked) {
            tcpClient.disconnectFromServer()
            for (var i = 0; i <= 300; i++) {
                Global.digital[i] = false
                Global.analog[i] = 0
            }
            Global.settings.demoMode = demoMode.checked
        }
        Global.settings.settingPassword = settingPassword.text
        if (Global.settings.showChannel !== showChannel.checked) {
            Global.settings.showChannel = showChannel.checked
            showChannelChanged()
        }
        Global.settings.darkTheme = darkTheme.checked
        Global.settings.sync()
    }
}
