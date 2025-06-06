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
            label: qsTr("输出")
            content: Grid {
                id: gridOutput
                rows: 4
                anchors.fill: parent
                columns: Math.ceil(outputList.count / rows)
                spacing: height * 0.05
                Repeater {
                    id: outputRepeater
                    model: ListModel {
                        id: outputList
                        ListElement {
                            name: qsTr("显示屏")
                            outputChannel: 1
                        }
                        ListElement {
                            name: qsTr("华为视频会议辅流")
                            outputChannel: 2
                        }
                        ListElement {
                            name: qsTr("远程视频会议内容")
                            outputChannel: 3
                        }
                        ListElement {
                            name: qsTr("预留输出")
                            outputChannel: 4
                        }
                    }
                    delegate: Output {
                        required property string name
                        required property int outputChannel
                        width: (parent.width + parent.spacing) / parent.columns - parent.spacing
                        height: (parent.height + parent.spacing) / gridOutput.rows - parent.spacing
                        output: outputChannel
                        textOutput: name
                        inputListMode: inputList
                    }
                }
            }
        }
        Category {
            widthRatio: 0.65
            label: qsTr("输入")
            info: MyIconLabel {
                height: parent.height
                icon.source: "qrc:/content/icons/tishi.png"
                text: qsTr("拖拽输入信号到输出")
            }
            content: Grid {
                id: gridInput
                rows: Global.config.tabOnBottom ? 3 : 4
                anchors.fill: parent
                columns: Math.ceil(inputList.count / rows)
                spacing: height * 0.05
                Repeater {
                    model: ListModel {
                        id: inputList
                        ListElement {
                            name: qsTr("外网电脑")
                            inputChannel: 1
                            bgColor: "#4286f4"
                            source: "qrc:/content/icons/zhuji.png"
                            btnChannel: 91
                            disableOut: 3
                        }
                        ListElement {
                            name: qsTr("内网电脑")
                            inputChannel: 2
                            bgColor: "#f5af19"
                            source: "qrc:/content/icons/zhuji.png"
                            btnChannel: 92
                        }
                        ListElement {
                            name: qsTr("华为视频会议")
                            inputChannel: 3
                            bgColor: "#96c93d"
                            source: "qrc:/content/icons/shipinhuiyi.png"
                            btnChannel: 93
                            disableOut: 2
                        }
                        ListElement {
                            name: qsTr("无线投屏")
                            inputChannel: 4
                            bgColor: "#f953c6"
                            source: "qrc:/content/icons/wuxiantouping.png"
                            btnChannel: 94
                        }
                        ListElement {
                            name: qsTr("摄像机")
                            inputChannel: 5
                            bgColor: "#ff4b2b"
                            source: "qrc:/content/icons/shexiangji.png"
                            btnChannel: 95
                            disableOut: 2
                        }
                        ListElement {
                            name: qsTr("预留输入")
                            inputChannel: 6
                            bgColor: "#6dd5ed" //"cadetblue"
                            source: "qrc:/content/icons/HDMIjiekou.png"
                            btnChannel: 96
                            //disableOut: 4
                        }
                        // ListElement {
                        //     name: qsTr("预留输入2")
                        //     inputChannel: 7
                        //     bgColor: "gold"
                        //     source: "qrc:/content/icons/HDMIjiekou.png"
                        //     btnChannel: 97
                        //     disableOut: 5
                        // }
                        // ListElement {
                        //     name: qsTr("预留输入3")
                        //     inputChannel: 8
                        //     bgColor: "#8e9eab" //"lightslategrey"
                        //     source: "qrc:/content/icons/HDMIjiekou.png"
                        //     btnChannel: 98
                        //     disableOut: 6
                        // }
                    }
                    delegate: InputButton {
                        required property string name
                        required property int inputChannel
                        required property color bgColor
                        required property string source
                        required property int index
                        required property int btnChannel
                        required property int disableOut
                        width: (parent.width + parent.spacing) / parent.columns - parent.spacing
                        height: (parent.height + parent.spacing) / gridInput.rows - parent.spacing
                        btnColor: bgColor
                        textInput: name
                        input: inputChannel
                        iconSource: source
                        disableOutput: disableOut
                        onPressedChanged: pressed => {
                                              for (var i = 0; i < outputRepeater.count; ++i) {
                                                  if (outputRepeater.itemAt(
                                                          i).output === disableOutput) {
                                                      outputRepeater.itemAt(
                                                          i).enabled = !pressed
                                                  }
                                              }
                                          }
                    }
                }
            }
        }
    }
}
