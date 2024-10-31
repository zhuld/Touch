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
            id: outputCategory
            widthRatio: 0.35
            Column {
                anchors.fill: parent
                anchors.margins: item.width * 0.02
                spacing: height * 0.03
                MyLable {
                    text: qsTr("输出")
                    height: parent.height * 0.1
                }
                Repeater {
                    model: ListModel {
                        id: outputModel
                        ListElement {
                            name: qsTr("大屏")
                            outputChannel: 1
                        }
                        ListElement {
                            name: qsTr("院内会议辅流")
                            outputChannel: 2
                        }
                        ListElement {
                            name: qsTr("远程会议辅流")
                            outputChannel: 3
                        }
                        ListElement {
                            name: qsTr("预留输出")
                            outputChannel: 4
                        }
                    }
                    delegate: Output {
                        id: output
                        required property string name
                        required property int outputChannel
                        width: parent.width
                        height: (parent.height * 0.9) / outputModel.count - parent.spacing
                        output: outputChannel
                        textOutput: name
                    }
                }
            }
        }

        Category {
            id: inputCategory
            widthRatio: 0.65
            Column {
                anchors.fill: parent
                anchors.margins: item.width * 0.02
                spacing: height * 0.03
                MyLable {
                    text: qsTr("输入信号")
                    height: parent.height * 0.1
                }
                Grid {
                    width: parent.width
                    height: parent.height * 0.78
                    columns: 2
                    spacing: height * 0.05
                    Repeater {
                        model: ListModel {
                            id: inputModel
                            ListElement {
                                name: qsTr("外网电脑")
                                inputChannel: 1
                                bgColor: "deepskyblue"
                                iconSource: "qrc:/content/icons/zhuji.png"
                            }
                            ListElement {
                                name: qsTr("内网电脑")
                                inputChannel: 2
                                bgColor: "darkorange"
                                iconSource: "qrc:/content/icons/zhuji.png"
                            }
                            ListElement {
                                name: qsTr("视频会议")
                                inputChannel: 3
                                bgColor: "forestgreen"
                                iconSource: "qrc:/content/icons/shipinhuiyi.png"
                            }
                            ListElement {
                                name: qsTr("无线投屏")
                                inputChannel: 4
                                bgColor: "violet"
                                iconSource: "qrc:/content/icons/wuxiantouping.png"
                            }
                            ListElement {
                                name: qsTr("摄像机")
                                inputChannel: 5
                                bgColor: "orangered"
                                iconSource: "qrc:/content/icons/shexiangji.png"
                            }
                            ListElement {
                                name: qsTr("预留输入")
                                inputChannel: 6
                                bgColor: "grey"
                                iconSource: "qrc:/content/icons/HDMIjiekou.png"
                            }
                        }
                        delegate: InputButton {
                            required property string name
                            required property int inputChannel
                            required property color bgColor
                            required property string iconSource
                            required property int index

                            width: (parent.width + parent.spacing) / parent.columns - parent.spacing
                            height: (parent.height + parent.spacing) / inputModel.count
                                    * parent.columns - parent.spacing

                            btnColor: bgColor
                            text: name
                            input: inputChannel
                            icon.source: iconSource
                        }
                    }
                }
                Text {
                    width: parent.width
                    height: parent.height * 0.05
                    font.pixelSize: height
                    color: textColor
                    horizontalAlignment: Text.AlignRight
                    text: qsTr("拖拽输入信号到输出")
                }
            }
        }
    }
}
