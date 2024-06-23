import QtQuick
import QtQuick.Shapes
import QtQuick.Controls

import "qrc:/qt/qml/content/ws.js" as WS

Rectangle {
    id:control

    property string output
    property alias textOutput: textOutput.text
    property alias textInput: textInput.text
    property color tColor: buttonTextColor
    property color btnColor: buttonColor

    readonly property var input: root.analog[output]

    color: Qt.darker(btnColor,1.4)
    radius: height/10

    Column{
        id:column
        anchors.fill: parent
        spacing:height/40
        Text {
            id: textOutput
            width: parent.width
            height: parent.height*0.5
            font.pixelSize: height*0.5
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "Output"
            color: tColor
        }
        IconLabel{
            id:textInput
            width: parent.width
            height: parent.height*0.5 - parent.spacing
            font.pixelSize: height*0.45
            color: tColor
            icon.height: height*0.4
            icon.color: tColor
            spacing: width*0.05
        }
    }
    Shape{
        anchors.fill: parent
        ShapePath{
            strokeColor: buttonColor
            strokeStyle: ShapePath.SolidLine
            strokeWidth: column.spacing
            startX: 0
            startY: column.height*0.5
            PathLine{
                x:column.width
                y:column.height*0.5
            }
        }
    }
    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel? "A"+control.output : ""
        color: textColor
        font.pixelSize: height*0.3
    }
    Text {
        id: outputText
        anchors.fill: parent
        anchors.margins: height*0.1
        text: output
        font.pixelSize: height*0.3
        color: tColor
        horizontalAlignment: Text.AlignRight
    }
    Text {
        id: inputText
        anchors.fill: parent
        anchors.margins: height*0.1
        text: input? input:""
        font.pixelSize: height*0.3
        color: tColor
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignBottom
    }

    DropArea{
        id:dropContainer
        anchors.fill: parent
        Connections{
            onDropped: (drop)=>{
                           WS.level(output,drop.keys[0])
                           control.opacity = 1
                       }
            onEntered:control.opacity = 0.7
            onExited: control.opacity = 1
        }
    }
    Component.onCompleted: {
        update(input)
    }

    onInputChanged: {
        update(input)
    }

    Behavior on color {
        ColorAnimation {
            duration: 400
        }
    }

    function update(inputChannel){
        if(inputChannel>0){
            control.color = Qt.darker(inputModel.get(inputChannel-1).bgColor,1.2)
            textInput.text = inputModel.get(inputChannel-1).name
            textInput.icon.source = inputModel.get(inputChannel-1).iconSource
        }
    }

}
