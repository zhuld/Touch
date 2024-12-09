import QtQuick
import QtQuick.Controls

import "../../Custom"

Item {
    implicitWidth: parent.width
    implicitHeight: parent.height

    Row {
        anchors.fill: parent
        spacing: width * 0.02
        Category {
            widthRatio: 0.35
            lable: qsTr("输出")
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.04
                Repeater {
                    id: outputRepeater
                    model: ListModel {
                        id: outputList
                        ListElement {
                            name: qsTr("显示屏")
                            outputChannel: 1
                        }
                        ListElement {
                            name: qsTr("院内会议辅流")
                            outputChannel: 2
                            disable: "3"
                        }
                        ListElement {
                            name: qsTr("远程会议辅流")
                            outputChannel: 3
                            disable: "1"
                        }
                        ListElement {
                            name: qsTr("预留输出")
                            outputChannel: 4
                        }
                    }
                    delegate: Output {
                        required property string name
                        required property int outputChannel
                        required property int disable
                        width: parent.width
                        height: (parent.height + parent.spacing) / outputList.count - parent.spacing
                        output: outputChannel
                        textOutput: name
                        disableInput: disable
                        inputListMode: inputList
                    }
                }
            }
        }

        Category {
            widthRatio: 0.65
            lable: qsTr("输入信号")
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.04
                Grid {
                    width: parent.width
                    height: parent.height * 0.9
                    columns: 2
                    spacing: height * 0.05
                    Repeater {
                        model: ListModel {
                            id: inputList
                            ListElement {
                                name: qsTr("外网电脑")
                                inputChannel: 1
                                bgColor: "deepskyblue"
                                source: "qrc:/content/icons/zhuji.png"
                            }
                            ListElement {
                                name: qsTr("内网电脑")
                                inputChannel: 2
                                bgColor: "darkorange"
                                source: "qrc:/content/icons/zhuji.png"
                            }
                            ListElement {
                                name: qsTr("视频会议")
                                inputChannel: 3
                                bgColor: "forestgreen"
                                source: "qrc:/content/icons/shipinhuiyi.png"
                            }
                            ListElement {
                                name: qsTr("无线投屏")
                                inputChannel: 4
                                bgColor: "violet"
                                source: "qrc:/content/icons/wuxiantouping.png"
                            }
                            ListElement {
                                name: qsTr("摄像机")
                                inputChannel: 5
                                bgColor: "indianred"
                                source: "qrc:/content/icons/shexiangji.png"
                            }
                            ListElement {
                                name: qsTr("预留输入1")
                                inputChannel: 6
                                bgColor: "cadetblue"
                                source: "qrc:/content/icons/HDMIjiekou.png"
                            }
                            ListElement {
                                name: qsTr("预留输入2")
                                inputChannel: 7
                                bgColor: "slateblue"
                                source: "qrc:/content/icons/HDMIjiekou.png"
                            }
                            ListElement {
                                name: qsTr("预留输入3")
                                inputChannel: 8
                                bgColor: "royalblue"
                                source: "qrc:/content/icons/HDMIjiekou.png"
                            }
                        }
                        delegate: InputButton {
                            required property string name
                            required property int inputChannel
                            required property color bgColor
                            required property string source
                            required property int index

                            width: (parent.width + parent.spacing) / parent.columns - parent.spacing
                            height: (parent.height + parent.spacing) / inputList.count
                                    * parent.columns - parent.spacing
                            btnColor: bgColor
                            textInput: name
                            input: inputChannel
                            iconSource: source
                            onPressedChanged: pressed => {
                                                  for (var i = 0; i < outputList.count; ++i) {
                                                      if (outputRepeater.itemAt(
                                                              i).disable === inputChannel) {
                                                          outputRepeater.itemAt(
                                                              i).enabled = !pressed
                                                      }
                                                  }
                                              }
                        }
                    }
                }
                Text {
                    width: parent.width
                    height: parent.height * 0.05
                    font.pixelSize: height
                    color: catagoryColor
                    horizontalAlignment: Text.AlignRight
                    text: qsTr("拖拽输入信号到输出")
                    font.family: alibabaPuHuiTi.font.family
                }
            }
        }
    }
}
