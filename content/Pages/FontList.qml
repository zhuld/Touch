import QtQuick
import QtQuick.Controls

import "../Custom"

Item {
    implicitWidth: parent.width
    implicitHeight: parent.height
    Row {
        anchors.fill: parent
        spacing: width * 0.02
        Category {
            lable: qsTr("字体列表")
            Rectangle {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                color: "transparent"
                ScrollView {
                    id: scrollView
                    width: parent.width
                    height: parent.height
                    clip: true
                    ListView {
                        id: fonts
                        width: parent.width
                        height: parent.height
                        model: Qt.fontFamilies()
                        delegate: Text {
                            height: fonts.height / 20
                            width: fonts.width
                            color: config.textColor
                            font.pixelSize: height * 0.8
                            font.family: modelData
                            text: index + ": " + modelData
                                  + "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
                        }
                    }
                }
            }
        }
    }
}
