import QtQuick
import QtQuick.Controls
import "qrc:/qt/qml/content/ws.js" as WS

Item {
    id:control

    property int channel
    property color btnColor: buttonCheckedColor
    property color iconColor:buttonTextColor
    implicitWidth: 100
    implicitHeight: 130
    Rectangle{
        width: parent.width
        height: width
        color: Qt.darker(btnColor,1.2)
        border.color: btnColor
        border.width: 2
        radius: width/2
    }

    Grid{
        id:dpadBackground
        width: parent.width
        height: width
        columns:3
        spacing: -width/20
        Repeater{
            model: ListModel{
                id:dpadModel
                ListElement { name: "1" ; enable: false ; dPadIcon :"";iconUrl:""}
                ListElement { name: "2" ; enable: true ; dPadIcon :"qrc:/qt/qml/content/icons/dpad-up.png";iconUrl:"qrc:/qt/qml/content/icons/up.png"}
                ListElement { name: "3" ; enable: false ; dPadIcon :"";iconUrl:""}
                ListElement { name: "4" ; enable: true ; dPadIcon :"qrc:/qt/qml/content/icons/dpad-left.png";iconUrl:"qrc:/qt/qml/content/icons/left.png"}
                ListElement { name: "5" ; enable: false ; dPadIcon :"";iconUrl:""}
                ListElement { name: "6" ; enable: true ; dPadIcon :"qrc:/qt/qml/content/icons/dpad-right.png";iconUrl:"qrc:/qt/qml/content/icons/right.png"}
                ListElement { name: "7" ; enable: false ; dPadIcon :"";iconUrl:""}
                ListElement { name: "8" ; enable: true ; dPadIcon :"qrc:/qt/qml/content/icons/dpad-down.png";iconUrl:"qrc:/qt/qml/content/icons/down.png"}
                ListElement { name: "9" ; enable: false ; dPadIcon :"";iconUrl:""}
            }
            delegate: Rectangle {
                id: dpadDrog
                required property string name
                required property bool enable
                required property int index
                required property string dPadIcon
                required property string iconUrl

                width: (parent.width+parent.spacing)/parent.columns-parent.spacing
                height:  (parent.height+parent.spacing)/dpadModel.count*parent.columns-parent.spacing
                color: "transparent"
                radius: width/2
                IconLabel {
                    id:icon
                    anchors.fill: parent
                    icon.height: height*0.5
                    icon.color: iconColor
                    icon.source: iconUrl
                    Behavior on icon.height {
                        NumberAnimation{
                            duration: 200
                        }
                    }
                }

                Text {
                    id: channel
                    height: parent.height
                    text: root.settings.showChannel&enable? "D"+(control.channel+index) : ""
                    color: iconColor
                    font.pixelSize: height*0.3
                }
                DropArea{
                    id:dropContainer
                    enabled: enable
                    anchors.fill: parent
                    Connections{
                        onEntered:{
                            icon.icon.height = height*0.9
                            //iconDpad.icon.source = dPadIcon
                            WS.push(control.channel+index)
                        }
                        onExited:{
                            icon.icon.height = height*0.5
                            //iconDpad.icon.source = "qrc:/qt/qml/content/icons/dpad.png"
                            WS.release(control.channel+index)
                        }
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed:{
                        if(enable){
                            icon.icon.height = height*0.9
                            //iconDpad.icon.source = dPadIcon
                            WS.push(control.channel+index)
                        }
                    }
                    onReleased:{
                        if(enable){
                            icon.icon.height = height*0.5
                            //iconDpad.icon.source = "qrc:/qt/qml/content/icons/dpad.png"
                            WS.release(control.channel+index)
                        }
                    }
                }
            }
        }
    }

    MouseArea {
        id: mouseArea

        width: dpadBackground.width*0.3
        height: width

        anchors.centerIn: dpadBackground

        onReleased: dragButtonAnimation.start()

        ParallelAnimation{
            id: dragButtonAnimation
            NumberAnimation {
                target: pad
                property: "x"
                duration: 300
                to:0
                easing.type: Easing.OutBack
            }
            NumberAnimation {
                target: pad
                property: "y"
                duration: 300
                to:0
                easing.type: Easing.OutBack
            }
        }

        drag.target: pad
        drag.minimumX: -dpadBackground.width/2+width/2
        drag.maximumX: dpadBackground.width/2-width/2
        drag.minimumY: -dpadBackground.height/2+height/2
        drag.maximumY: dpadBackground.height/2-height/2

        Rectangle{
            id:pad
            width: parent.width
            height: width
            radius: width/2
            color: mouseArea.pressed ? Qt.alpha(btnColor,0.7):Qt.darker(btnColor,1.6)
            border.color: btnColor
            border.width: 2

            Drag.active: mouseArea.drag.active

            Drag.hotSpot.x: width/2
            Drag.hotSpot.y: height/2

            IconLabel {
                id:iconDpad
                anchors.fill: parent
                icon.height: height*0.6
                icon.color: iconColor
                icon.source: "qrc:/qt/qml/content/icons/yuan.png"
            }
        }
    }

    MyRoundButton{
        height: dpadBackground.height*0.3
        width: height
        anchors.top : dpadBackground.bottom
        icon.source:  "qrc:/qt/qml/content/icons/fangda.png"
        icon.color: iconColor
        channel: control.channel+9
    }
    MyRoundButton{
        height: dpadBackground.height*0.3
        width: height
        anchors.top : dpadBackground.bottom
        anchors.right: dpadBackground.right
        icon.source:  "qrc:/qt/qml/content/icons/suoxiao.png"
        icon.color: iconColor
        channel: control.channel+10
    }
}
