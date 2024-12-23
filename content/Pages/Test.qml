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
            widthRatio: 0.5
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.05
                IconLabel {
                    height: 100
                    icon.source: "qrc:/content/icons/quankai.png"
                    text: "IconLabel1"
                    display: AbstractButton.TextUnderIcon
                }
            }
        }
        Category {
            lable: qsTr("测试")
            widthRatio: 0.5
        }
    }
}
