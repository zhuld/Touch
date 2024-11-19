import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

import "qrc:/qt/qml/content/js/crestroncip.js" as CrestronCIP

import "../Custom"

Item {
    id: test
    implicitWidth: parent.width
    implicitHeight: parent.height

    Row {
        id: row
        anchors.fill: parent
        spacing: width * 0.02
        Category {
            widthRatio: 0.98
            Column {
                anchors.fill: parent
                anchors.margins: item.width * 0.02
                spacing: height * 0.04
                MyLable {
                    id: label
                    text: qsTr("测试")
                    height: parent.height * 0.1
                }
            }
        }
    }
}
