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
                spacing: height*0.05
                MyLable{
                    text: qsTr("会议模式")
                    height: parent.height*0.1
                }
                Repeater{
                    id:listMode
                    model: ListModel{
                        ListElement{name: "大屏会议"; btnchannel: 6; sizeRatio : 1; buttonDarkColor : "green"; buttonLightColor : "lightgreen"; iconUrl: "qrc:/qt/qml/content/icons/pingmugongxiang.png"}
                        ListElement{name: "普通会议"; btnchannel: 7; sizeRatio : 1; buttonDarkColor : "green"; buttonLightColor : "lightgreen"; iconUrl: "qrc:/qt/qml/content/icons/huiyizanzhuyantao.png"}
                        ListElement{name: "会议结束"; btnchannel: 8; sizeRatio : 1; buttonDarkColor : "red"; buttonLightColor : "tomato"; iconUrl: "qrc:/qt/qml/content/icons/guanji.png"}
                    }
                    delegate:MyDelayButton{
                        required property string name
                        required property int btnchannel
                        required property real sizeRatio
                        required property color buttonDarkColor
                        required property color buttonLightColor
                        required property string iconUrl
                        width: parent.width
                        height: parent.height*0.2*sizeRatio
                        text: name
                        channel: btnchannel
                        btnColor: settings.darkTheme ? buttonDarkColor : buttonLightColor
                        icon.source: iconUrl
                    }
                }
                Text {
                    width: parent.width
                    height: parent.height*0.05
                    font.pixelSize: height
                    color: textColor
                    horizontalAlignment: Text.AlignRight
                    text: qsTr("长按2秒启动")
                }
            }
        }

        Category{
            widthRatio: 0.4
            Column{
                anchors.fill: parent
                anchors.margins: item.width*0.02
                spacing: height*0.05
                MyLable{
                    text: qsTr("信号选择")
                    height: parent.height*0.1
                }
                Repeater{
                    model: ListModel {
                        id: buttonModel
                        ListElement { name: qsTr("远程视频会议");  btnchannel: 11; iconUrl: "qrc:/qt/qml/content/icons/shipinhuiyi.png"}
                        ListElement { name: qsTr("院内视频会议");  btnchannel: 12; iconUrl: "qrc:/qt/qml/content/icons/shipinhuiyi.png" }
                        ListElement { name: qsTr("内网电脑");  btnchannel: 13; iconUrl: "qrc:/qt/qml/content/icons/zhuji.png" }
                        ListElement { name: qsTr("无线投屏");  btnchannel: 14; iconUrl: "qrc:/qt/qml/content/icons/wuxiantouping.png" }
                    }
                    delegate: MyButton{
                        id:myButton
                        required property string name
                        required property int btnchannel
                        required property string iconUrl
                        width: parent.width
                        height: parent.height*0.9/buttonModel.count  - parent.spacing
                        text:name
                        channel:btnchannel
                        icon.source: iconUrl
                    }
                }
            }
        }

        Category{
            widthRatio: 0.2
            Column{
                anchors.fill: parent
                anchors.margins: item.width*0.02
                spacing: height*0.05
                MyLable{
                    text: "总音量"
                    height: parent.height*0.1
                }
                VolumeBar{
                    height: parent.height*0.9 - parent.spacing
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    channel: 9
                    muteChannel: 45
                    miniVolume: -40
                    maxVolume: 0
                    input: false
                }

            }
        }
    }
}
