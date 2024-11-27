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
                    text: config.videoOutputName
                    height: parent.height * 0.1
                }
                Repeater {
                    id: outputList
                    model: config.videoOutputList
                    delegate: Output {
                        id: output
                        required property string name
                        required property int outputChannel
                        required property int disable
                        width: parent.width
                        height: (parent.height * 0.9)
                                / config.videoOutputList.count - parent.spacing
                        output: outputChannel
                        textOutput: name
                        disableInput: disable
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
                    text: config.videoInputName
                    height: parent.height * 0.1
                }
                Grid {
                    width: parent.width
                    height: parent.height * 0.78
                    columns: 2
                    spacing: height * 0.05
                    Repeater {
                        model: config.videoInputList
                        delegate: InputButton {
                            required property string name
                            required property int inputChannel
                            required property color bgColor
                            required property string source
                            required property int index

                            width: (parent.width + parent.spacing) / parent.columns - parent.spacing
                            height: (parent.height + parent.spacing) / config.videoInputList.count
                                    * parent.columns - parent.spacing

                            btnColor: bgColor
                            textInput: name
                            input: inputChannel
                            iconSource: source
                            onPressedChanged: pressed => {
                                                  for (var i = 0; i < outputList.count; ++i) {
                                                      if (outputList.itemAt(
                                                              i).disable === inputChannel) {
                                                          outputList.itemAt(
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
