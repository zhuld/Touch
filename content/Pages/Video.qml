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
            widthRatio: config.videoOutputRatio
            lable: config.videoOutputName
            Column {
                anchors.fill: parent
                anchors.topMargin: parent.height * 0.15
                anchors.bottomMargin: parent.height * 0.04
                anchors.leftMargin: parent.height * 0.04
                anchors.rightMargin: anchors.leftMargin
                spacing: height * 0.04
                Repeater {
                    id: outputList
                    model: config.videoOutputList
                    delegate: Output {
                        id: output
                        required property string name
                        required property int outputChannel
                        required property int disable
                        width: parent.width
                        height: (parent.height + parent.spacing)
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
            widthRatio: config.videoInputRatio
            lable: config.videoInputName
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
