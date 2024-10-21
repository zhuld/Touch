import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Shapes

import "../Custom"
import "../dialog"

Rectangle {
    id: control

    color: "transparent"
    Shape {
        anchors.fill: parent
        ShapePath {
            strokeColor: textColor
            strokeStyle: ShapePath.SolidLine
            strokeWidth: parent.height * 0.002
            startX: 0
            startY: control.height
            PathLine {
                x: control.width
                y: control.height
            }
        }
    }

    MouseArea {
        property var clickPosition: Qt.point(0, 0)
        anchors.fill: parent
        cursorShape: settings.fullscreen ? Qt.ArrowCursor : Qt.SizeAllCursor
        onPositionChanged: {
            if (!pressed || settings.fullscreen)
                return
            root.x += mouseX - clickPosition.x
            root.y += mouseY - clickPosition.y

            titleRecive.text = "Window Position： " + root.x + "," + root.y
        }
        onPressedChanged: {
            clickPosition = Qt.point(mouseX, mouseY)
        }
    }
    Text {
        id: titleLogo
        text: qsTr(config.logoName)
        height: parent.height
        anchors.left: parent.left
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: height * 0.4
        color: textColor
    }
    Text {
        id: titleName
        text: qsTr(config.titleName) + (settings.demoMode ? "-演示" : "")
        height: parent.height
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: height * 0.5
        font.weight: Font.Bold
        color: textColor
    }
    Row {
        height: parent.height
        anchors.right: parent.right
        spacing: parent.width * 0.01
        Text {
            id: titleTime
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: height * 0.4
            color: textColor
            Timer {
                id: timer
                interval: 1000
                repeat: true
                running: true
                triggeredOnStart: true
                onTriggered: {
                    titleTime.text = Qt.formatDateTime(new Date(),
                                                       "MM-dd hh:mm")
                }
            }
        }
        ColorSwitch {
            id: themeSwitch
            height: parent.height * 0.5
            width: height * 2
            anchors.verticalCenter: parent.verticalCenter
            checked: settings.darkTheme
            onCheckedChanged: {
                settings.darkTheme = checked
            }
        }
        IconButton {
            id: setup
            height: parent.height * 0.7
            width: height
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "qrc:/content/icons/config.png"
            onClicked: {
                passwordDialog.open()
            }
            tipText: "设置"
        }
        IconButton {
            id: min
            height: parent.height * 0.7
            width: height
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "qrc:/content/icons/MinimizedWindow.png"
            onClicked: {
                root.visibility = Window.Minimized
            }
            visible: settings.fullscreen ? false : true
        }
        IconButton {
            id: close
            height: parent.height * 0.7
            width: height
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "qrc:/content/icons/close.png"
            backColor: buttonRedColor
            onClicked: {
                //root.close()
                closeDialog.open()
            }
        }
    }
}
