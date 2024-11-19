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
            widthRatio: 0.98
            Column {
                anchors.fill: parent
                anchors.margins: item.width * 0.02
                spacing: height * 0.04
                MyLable {
                    id: label
                    text: qsTr("收发数据")
                    height: parent.height * 0.1
                    ColorButton {
                        text: "清除"
                        anchors.top: parent.top
                        anchors.right: parent.right
                        width: parent.width / 8
                        height: parent.height * 0.7
                        onClicked: {
                            root.listModel.clear()
                        }
                    }
                }
                ScrollView {
                    id: scrollView
                    width: parent.width
                    height: parent.height * 0.86
                    clip: true
                    ListView {
                        readonly property int lines: 20
                        width: scrollView.width
                        model: root.listModel

                        delegate: Rectangle {
                            width: scrollView.width
                            height: scrollView.height * 0.06
                            color: model.direction === "发" ? buttonColor : buttonCheckedColor
                            Row {
                                width: scrollView.width
                                spacing: width * 0.02
                                Text {
                                    text: model.time
                                    width: parent.width * 0.12
                                    height: scrollView.height / 20
                                    color: buttonTextColor
                                    font.pixelSize: height
                                    font.family: alibabaPuHuiTi.font.family
                                }

                                Text {
                                    text: model.direction
                                    width: parent.width * 0.02
                                    height: scrollView.height / 20
                                    color: buttonTextColor
                                    font.pixelSize: height
                                    font.family: alibabaPuHuiTi.font.family
                                }

                                Text {
                                    text: model.data
                                    width: parent.width * 0.4
                                    height: scrollView.height / 20
                                    color: buttonTextColor
                                    font.pixelSize: height
                                    font.family: alibabaPuHuiTi.font.family
                                }
                                Text {
                                    text: model.detail
                                    width: parent.width * 0.4
                                    height: scrollView.height / 20
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
