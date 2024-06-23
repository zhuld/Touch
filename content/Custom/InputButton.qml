import QtQuick
import QtQuick.Controls

Item {
    id: control

    property string input
    property color btnColor: buttonCheckedColor
    property color textColor: buttonTextColor
    property alias text : label.text
    property alias icon : label.icon

    MouseArea {
        id: mouseArea

        width: parent.width
        height: parent.height

        anchors.centerIn: parent

        drag.target: dragButton

        onReleased: {
            dragButton.Drag.drop()
            dragButtonAnimation.start()
            control.z = 0
        }
        onPressed:{
            dragButton.Drag.hotSpot.x = mouseX
            dragButton.Drag.hotSpot.y = mouseY
            control.z = 1
        }

        ParallelAnimation{
            id: dragButtonAnimation
            NumberAnimation {
                target: dragButton
                property: "x"
                duration: 400
                to:0
                easing.type: Easing.OutBack
            }
            NumberAnimation {
                target: dragButton
                property: "y"
                duration: 400
                to:0
                easing.type: Easing.OutBack
            }
        }

        Rectangle{
            anchors.fill: parent
            radius: height*0.1
            color: Qt.alpha(btnColor,0.2)
        }

        Rectangle {
            id: dragButton
            width: control.width
            height: control.height
            radius: height*0.1
            IconLabel{
                id:label
                anchors.fill: parent
                text: "Input"
                font.pixelSize: height*0.35
                color: textColor
                icon.height: height*0.35
                icon.color: textColor
                spacing: width*0.05
            }
            Text {
                id: inputText
                anchors.fill: parent
                anchors.margins: height*0.3
                text: input
                font.pixelSize: height*0.4
                color: textColor
                horizontalAlignment: Text.AlignRight
            }

            color: mouseArea.pressed ?  Qt.darker(btnColor,2) : btnColor

            Drag.keys: [ input ]
            Drag.active: mouseArea.drag.active

            // states: State {
            //     when: mouseArea.drag.active
            //     AnchorChanges { target: dragButton; anchors.verticalCenter: undefined; anchors.horizontalCenter: undefined }
            // }
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
        }
    }
}
