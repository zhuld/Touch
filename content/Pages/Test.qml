import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

import "../Custom"

Item {
    id: test
    implicitWidth: parent.width
    implicitHeight: parent.height
    Row {
        anchors.fill: parent
        spacing: width * 0.02
        Category {
            lable: qsTr("测试")
            Rectangle {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                color: "transparent"
                VButton {
                    width: 600
                    height: 600
                    text: "测试"
                    source: "qrc:/content/icons/huiyizanzhuyantao.png"
                    channel: 33
                    //confirm: true
                }
                VButton {
                    x: 601
                    width: 600
                    height: 600
                    text: "测试2"
                    source: "qrc:/content/icons/huiyizanzhuyantao.png"
                    channel: 34
                    //confirm: true
                }
                MyButton {
                    y: 650
                    width: 600
                    height: 300
                    text: "测试3"
                    source: "qrc:/content/icons/huiyizanzhuyantao.png"
                    channel: 35
                    //confirm: true
                }
            }
        }
    }
}
