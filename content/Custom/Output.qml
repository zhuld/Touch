import QtQuick
import QtQuick.Shapes
import QtQuick.Controls

import "qrc:/qt/qml/content/ws.js" as WS

Rectangle {
    id:control

    property string output
    property alias textOutput: textOutput.text
    property alias textInput: textInput.text

    readonly property var input: root.analog[output]

    gradient: Gradient {
        GradientStop {
            id:downColor
            position: 1.0; color: buttonColor
            Behavior on color{
                ColorAnimation {
                    duration: 300
                }
            }
        }
        GradientStop {
            position: 0.3; color: Qt.darker(buttonColor,1.4)
        }
    }

    radius: height/10

    Text {
        id: textOutput
        height: parent.height*0.5
        font.pixelSize: height*0.5
        x: outputText.width
        verticalAlignment: Text.AlignVCenter
        text: "Output"
        color: buttonTextColor
    }

    Text {
        id: outputText
        height: parent.height
        font.pixelSize: height*0.6
        anchors.margins: height*0.1
        anchors.left: parent.left
        text: output
        color: buttonTextColor
        font.bold: true
        opacity: 0.1
    }
    IconLabel{
        id:textInput
        height: parent.height*0.5
        font.pixelSize: height*0.5
        x:parent.width-width-inputText.width
        anchors.margins: height*0.1
        anchors.bottom: parent.bottom
        color: buttonTextColor
        icon.height: height*0.5
        icon.color: buttonTextColor
        spacing: width*0.05

    }
    Text {
        id: inputText
        height: parent.height*0.5
        font.pixelSize: height
        anchors.margins: height*0.1
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        text: input? input: ""
        color: buttonTextColor
        font.bold: true
        opacity: 0.1
    }
    Text {
        id: channel
        height: parent.height
        width: parent.width
        horizontalAlignment: Text.AlignRight
        text: root.settings.showChannel? "A"+control.output : ""
        color: buttonTextColor
        font.pixelSize: height*0.3
    }
    DropArea{
        id:dropContainer
        anchors.fill: parent
        Connections{
            onDropped: (drop)=>{
                           WS.level(output,drop.keys[0])
                           control.opacity = 1
                       }
            onEntered:{
                control.opacity = 0.6
            }
            onExited: {
                control.opacity = 1
            }
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

    onWidthChanged: {
        update(input)
    }

    function update(inputChannel){
        if(inputChannel>0){
            downColor.color = inputModel.get(inputChannel-1).bgColor
            textInput.text = inputModel.get(inputChannel-1).name
            textInput.icon.source = inputModel.get(inputChannel-1).iconSource
        }
    }
}
