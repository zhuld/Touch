import QtQuick
import QtQuick.Controls

import "../Custom"

Item {
    implicitWidth: parent.width
    implicitHeight: parent.height

    Row{
        id:row
        anchors.fill: parent
        spacing: width*0.02

        Category{
            widthRatio: 0.4
            Column{
                anchors.fill: parent
                anchors.margins: item.width*0.02
                spacing: height*0.03
                MyLable{
                    text: qsTr("输出")
                    height: parent.height*0.1
                }
                Repeater{
                    model: ListModel {
                        id: outputModel
                        ListElement { name: qsTr("大屏");  outputChannel: 1 }
                        ListElement { name: qsTr("院内会议辅流");  outputChannel: 2}
                        ListElement { name: qsTr("院外会议辅流");  outputChannel: 3}
                        ListElement { name: qsTr("预留输出");  outputChannel: 4}
                    }
                    delegate: Output{
                        id:output
                        required property string name
                        required property int outputChannel
                        width: parent.width
                        height: (parent.height*0.9)/outputModel.count-parent.spacing
                        output: outputChannel
                        textOutput:name
                    }
                }
            }
        }
        Category{
            widthRatio: 0.6
            Column{
                anchors.fill: parent
                anchors.margins: item.width*0.02
                spacing: height*0.03
                MyLable{
                    text: qsTr("输入信号")
                    height: parent.height*0.1
                }
                Grid{
                    width: parent.width
                    height: parent.height*0.8
                    columns: 2
                    spacing: height*0.08

                    Repeater{
                        model: ListModel {
                            id: inputModel
                            ListElement { name: qsTr("外网电脑");  inputChannel: 1 ; bgColor:"deepskyblue" ; iconSource:"qrc:/qt/qml/content/icons/zhuji.png"}
                            ListElement { name: qsTr("内网电脑");  inputChannel: 2 ; bgColor:"darkorange"; iconSource:"qrc:/qt/qml/content/icons/zhuji.png"}
                            ListElement { name: qsTr("视频会议");  inputChannel: 3 ; bgColor:"forestgreen"; iconSource:"qrc:/qt/qml/content/icons/shipinhuiyi.png"}
                            ListElement { name: qsTr("无线投屏");  inputChannel: 4 ; bgColor:"darkviolet"; iconSource:"qrc:/qt/qml/content/icons/wuxiantouping.png"}
                            ListElement { name: qsTr("预留输入");  inputChannel: 5 ; bgColor:"firebrick"; iconSource:"qrc:/qt/qml/content/icons/HDMIjiekou.png"}
                            ListElement { name: qsTr("预留输入");  inputChannel: 6 ; bgColor:"grey"; iconSource:"qrc:/qt/qml/content/icons/HDMIjiekou.png"}
                            ListElement { name: qsTr("预留输入");  inputChannel: 7 ; bgColor:"#3B48A1"; iconSource:"qrc:/qt/qml/content/icons/HDMIjiekou.png"}
                            ListElement { name: qsTr("摄像机");  inputChannel: 8 ; bgColor:"olive"; iconSource:"qrc:/qt/qml/content/icons/shipinhuiyi.png"}
                        }
                        delegate: InputButton {
                            required property string name
                            required property int inputChannel
                            required property color bgColor
                            required property string iconSource
                            required property int index

                            width: (parent.width+parent.spacing)/parent.columns-parent.spacing
                            height: (parent.height+parent.spacing)/inputModel.count*parent.columns-parent.spacing

                            btnColor: bgColor
                            text:name
                            input: inputChannel
                            icon.source: iconSource
                        }
                    }
                }
                Text {
                    width: parent.width
                    height: parent.height*0.05
                    font.pixelSize: height
                    color: textColor
                    horizontalAlignment: Text.AlignRight
                    text: qsTr("拖拽输入信号到输出")
                }
            }
        }
    }
}
