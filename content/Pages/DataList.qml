import QtQuick
import QtQuick.Controls

import "../Custom"

Item {
    id: dataList
    implicitWidth: parent.width
    implicitHeight: parent.height

    Row {
        anchors.fill: parent
        spacing: width * 0.02
        Category {
            label: qsTr("收发数据")
            ColorButton {
                text: "清除"
                anchors.top: parent.top
                anchors.topMargin: height * 0.4
                anchors.right: parent.right
                anchors.rightMargin: parent.height * 0.04
                width: parent.width * 0.1
                height: parent.height * 0.06
                onClicked: Global.dataList.clear()
            }
            content: ScrollView {
                id: scrollView
                anchors.fill: parent
                clip: true
                ListView {
                    width: scrollView.width
                    model: Global.dataList
                    delegate: Rectangle {
                        id: dataRect
                        width: scrollView.width
                        height: scrollView.height * 0.04
                        color: model.direction
                               === "发" ? Global.buttonColor : Global.buttonCheckedColor
                        Row {
                            width: scrollView.width
                            spacing: width * 0.01
                            Text {
                                text: model.time
                                width: parent.width * 0.09
                                height: dataRect.height * 0.8
                                color: Global.buttonTextColor
                                font.pixelSize: height
                                font.family: Global.alibabaPuHuiTi.font.family
                            }

                            Text {
                                text: model.direction
                                width: parent.width * 0.02
                                height: dataRect.height * 0.8
                                color: Global.buttonTextColor
                                font.pixelSize: height
                                font.family: Global.alibabaPuHuiTi.font.family
                            }

                            Text {
                                text: model.data
                                width: parent.width * 0.56
                                height: dataRect.height * 0.8
                                color: Global.buttonTextColor
                                font.pixelSize: height
                                font.family: Global.sourceCodePro.font.family
                            }
                            Text {
                                text: model.detail
                                width: parent.width * 0.30
                                height: dataRect.height * 0.8
                                color: Global.buttonTextColor
                                font.pixelSize: height
                                font.family: Global.alibabaPuHuiTi.font.family
                            }
                        }
                    }
                }
            }
        }
    }
}
