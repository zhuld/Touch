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
        cursorShape: Global.settings.fullscreen ? Qt.ArrowCursor : Qt.SizeAllCursor
        onPositionChanged: {
            if (!pressed || Global.settings.fullscreen)
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
        text: Global.config.logoName
        height: parent.height
        anchors.left: parent.left
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: height * 0.5
        color: Global.buttonTextColor
        font.family: Global.alibabaPuHuiTi.font.family
    }

    Text {
        id: titleName
        text: Global.config.titleName + (Global.settings.demoMode ? "-演示" : "")
        height: parent.height
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: height * 0.5
        color: Global.buttonTextColor
        font.family: Global.alibabaPuHuiTi.font.family
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
            color: Global.buttonTextColor
            font.family: Global.alibabaPuHuiTi.font.family
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
        ColorSwitch {
            id: themeSwtich
            height: parent.height * 0.6
            width: height * 1.2
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                Global.settings.darkTheme = !Global.settings.darkTheme
            }
            checked: Global.settings.darkTheme
            visible: Qt.platform.os === "windows" ? true : false
        }
        ColorButton {
            id: setup
            height: parent.height
            width: height
            source: "qrc:/content/icons/config.png"
            onClicked: {
                passwordDialog.open()
            }
            btnColor: "transparent"
        }
        ColorButton {
            id: close
            height: parent.height
            width: height
            source: "qrc:/content/icons/close.png"
            btnColor: "transparent"
            onClicked: {
                closeDialog.open()
            }
            visible: Qt.platform.os === "windows" ? true : false
        }
    }
}
