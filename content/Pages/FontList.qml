import QtQuick
import QtQuick.Controls

import "../Custom"

Item {
    implicitWidth: parent.width
    implicitHeight: parent.height
    Row {
        id: row
        anchors.fill: parent
        spacing: width * 0.02
        Category {
            Column {
                anchors.fill: parent
                anchors.margins: item.width * 0.02
                spacing: height * 0.04
                MyLable {
                    id: label
                    text: qsTr("字体列表")
                    height: parent.height * 0.1
                }
                ScrollView {
                    id: scrollView
                    width: parent.width
                    height: parent.height * 0.86
                    clip: true
                    ListView {
                        id: fonts
                        width: parent.width
                        height: parent.height * 0.86
                        model: Qt.fontFamilies()
                        delegate: Text {
                            height: fonts.height / 20
                            width: fonts.width
                            color: textColor
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
