import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Shapes

import "../Custom"
import "../Dialog"

Item {
    id: control

    MouseArea {
        property var clickPosition: Qt.point(0, 0)
        anchors.fill: parent
        cursorShape: settings.fullscreen ? Qt.ArrowCursor : Qt.SizeAllCursor
        onPositionChanged: {
            if (!pressed || settings.fullscreen)
                return
            root.x += mouseX - clickPosition.x
            root.y += mouseY - clickPosition.y
        }
        onPressedChanged: {
            clickPosition = Qt.point(mouseX, mouseY)
        }
    }
    Text {
        id: titleLogo
        text: config.logoName
        height: parent.height
        anchors.left: parent.left
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: height * 0.5
        color: config.textColor
        font.family: alibabaPuHuiTi.font.family
    }

    Text {
        id: titleName
        text: config.titleName + (settings.demoMode ? "-演示" : "")
        height: parent.height
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: height * 0.5
        color: config.textColor
        font.family: alibabaPuHuiTi.font.family
    }
    Row {
        height: parent.height
        anchors.right: parent.right
        spacing: parent.width * 0.01
        Text {
            id: titleTime
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: height * 0.5
            color: config.textColor
            font.family: alibabaPuHuiTi.font.family
            Timer {
                id: timer
                interval: 1000
                repeat: true
                running: true
                triggeredOnStart: true
                onTriggered: {
                    titleTime.text = new Date().toLocaleDateString(
                                Qt.locale("zh_CN"),
                                "MM月dd日 dddd") + new Date().toLocaleTimeString(
                                Qt.locale("zh_CN"), " hh:mm")
                }
            }
        }
        Switch {
            id: themeSwtich
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                settings.darkTheme = !settings.darkTheme
                if (settings.darkTheme) {
                    root.Material.theme = Material.Dark
                } else {
                    root.Material.theme = Material.Light
                }
            }
            checked: settings.darkTheme
            Material.accent: config.buttonCheckedColor
            visible: Qt.platform.os === "windows" ? true : false
        }
        IconButton {
            id: setup
            height: parent.height
            width: height
            //anchors.verticalCenter: parent.verticalCenter
            icon.source: "qrc:/content/icons/config.png"
            onClicked: {
                passwordDialog.open()
            }
        }
        IconButton {
            id: close
            height: parent.height
            width: height
            //anchors.verticalCenter: parent.verticalCenter
            icon.source: "qrc:/content/icons/close.png"
            backColor: config.buttonRedColor
            onClicked: {
                closeDialog.open()
            }
            visible: Qt.platform.os === "windows" ? true : false
        }
    }
}
