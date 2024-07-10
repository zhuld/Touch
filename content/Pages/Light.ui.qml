import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

import "../Custom"

Item {
    implicitWidth: parent.width
    implicitHeight: parent.height

    Row{
        id:row
        anchors.fill: parent
        spacing: width*0.02

        Category{
            widthRatio: 0.7
            Column{
                anchors.fill: parent
                anchors.margins: item.width*0.02
                spacing: height*0.05
                MyLable{
                    text: qsTr("单独控制")
                    height: parent.height*0.1
                }
                Grid{
                    id:grid
                    width: parent.width
                    height: parent.height*0.85
                    columns: 3
                    rowSpacing: height*0.02
                    columnSpacing: rowSpacing
                    anchors.margins: rowSpacing
                    Repeater{
                        model: ListModel {
                            id: lightList
                            ListElement{name: "左吸顶灯"}
                            ListElement{name: "右吸顶灯"}
                            ListElement{name: "前筒灯"}
                            ListElement{name: "四周筒灯"}
                            ListElement{name: "灯带"}
                            ListElement{name: "其他"}
                        }
                        delegate: LightButton{
                            required property int index
                            required property string name
                            text:name
                            channel: 50+index
                            width: (grid.width+grid.columnSpacing)/grid.columns-grid.columnSpacing
                            height: (grid.height+grid.rowSpacing)/lightList.count*grid.columns-grid.rowSpacing
                        }
                    }
                }
            }
        }

        Category{
            widthRatio: 0.3
            Column{
                anchors.fill: parent
                anchors.margins: item.width*0.02
                spacing: height*0.05
                MyLable{
                    text: qsTr("灯光模式")
                    height: parent.height*0.1
                }
                Repeater{
                    model: ListModel {
                        id: lightModel
                        ListElement { name: qsTr("全开");  btnchannel: 46; iconUrl: "qrc:/qt/qml/content/icons/quankai.png"}
                        ListElement { name: qsTr("全关");  btnchannel: 47; iconUrl: "qrc:/qt/qml/content/icons/quanguan.png" }
                        ListElement { name: qsTr("会议");  btnchannel: 48; iconUrl: "qrc:/qt/qml/content/icons/huiyizanzhuyantao.png" }
                        ListElement { name: qsTr("节电");  btnchannel: 49; iconUrl: "qrc:/qt/qml/content/icons/jieneng.png" }
                    }
                    delegate: MyButton{
                        id:myButton
                        required property string name
                        required property int btnchannel
                        required property string iconUrl
                        width: parent.width
                        height: parent.height*0.9/lightModel.count  - parent.spacing
                        text:name
                        channel:btnchannel
                        icon.source: iconUrl
                    }
                }
            }
        }
    }
}
