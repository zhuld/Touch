import QtQuick
import QtQuick.Controls
import Qt.labs.qmlmodels

import "../Custom"

Item {
    id: dataList
    implicitWidth: parent.width
    implicitHeight: parent.height

    Row {
        id: row
        anchors.fill: parent
        spacing: width * 0.02
        Category {
            lable: qsTr("收发数据")
            ColorButton {
                text: "清除"
                anchors.top: parent.top
                anchors.topMargin: height * 0.4
                anchors.right: parent.right
                width: parent.width * 0.1
                height: parent.height * 0.06
                onClicked: {
                    root.listModel.clear()
                }
            }
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.05
                ScrollView {
                    id: scrollView
                    width: parent.width
                    height: parent.height
                    clip: true
                    ListView {
                        width: scrollView.width
                        model: root.listModel
                        delegate: Rectangle {
                            id: dataRect
                            width: scrollView.width
                            height: scrollView.height * 0.05
                            color: model.direction === "发" ? buttonColor : buttonCheckedColor
                            Row {
                                width: scrollView.width
                                spacing: width * 0.01
                                Text {
                                    text: model.time
                                    width: parent.width * 0.09
                                    height: dataRect.height * 0.8
                                    color: buttonTextColor
                                    font.pixelSize: height
                                    font.family: alibabaPuHuiTi.font.family
                                }

                                Text {
                                    text: model.direction
                                    width: parent.width * 0.02
                                    height: dataRect.height * 0.8
                                    color: buttonTextColor
                                    font.pixelSize: height
                                    font.family: alibabaPuHuiTi.font.family
                                }

                                Text {
                                    text: model.data
                                    width: parent.width * 0.56
                                    height: dataRect.height * 0.8
                                    color: buttonTextColor
                                    font.pixelSize: height
                                    font.family: sourceCodePro.font.family
                                }
                                Text {
                                    text: model.detail
                                    width: parent.width * 0.30
                                    height: dataRect.height * 0.8
                                    color: buttonTextColor
                                    font.pixelSize: height
                                    font.family: alibabaPuHuiTi.font.family
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
