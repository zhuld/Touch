import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

import "qrc:/qt/qml/content/ws.js" as WS

Item {
    id:control
    implicitHeight: parent.height
    implicitWidth: parent.width

    property int miniVolume: -40
    property int maxVolume: 0

    property int muteChannel
    property int channel
    property int volume : 0

    Slider{
        id:slider
        height: parent.height*0.95
        width: height*0.25
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: -handle.height/4
        orientation: Qt.Vertical

        stepSize: 1/(maxVolume-miniVolume)
        snapMode: Slider.SnapAlways

        value: ((root.analog[control.channel])/(maxVolume- miniVolume))

        enabled: !root.digital[control.muteChannel]
        opacity: enabled? 1 : 0.8

        handle: Rectangle{
            width: parent.width*0.3
            height: parent.width*0.6
            anchors.horizontalCenter: parent.horizontalCenter
            y:parent.visualPosition*(parent.availableHeight-height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#57111B" }
                GradientStop { position: 0.1; color: "#A598CF" }
                GradientStop { position: 0.2; color: "#682632" }
                GradientStop { position: 0.48; color: "#8F4E69" }
                GradientStop { position: 0.49; color: "#FFFFFF" }
                GradientStop { position: 0.51; color: "#FFFFFF" }
                GradientStop { position: 0.52; color: "#885E7E" }
                GradientStop { position: 0.90; color: "#8F6C94" }
                GradientStop { position: 1.0; color: "#57111B" }
            }
            radius: width*0.2
            Behavior on y{
                enabled: !slider.pressed
                NumberAnimation{
                    easing.type: Easing.OutBack
                    duration: 500}
            }
            opacity: slider.pressed? 0.6:1
            Behavior on opacity {
                NumberAnimation{
                    duration: 200
                }
            }
        }

        background: Rectangle {
            //anchors.centerIn: parent
            implicitWidth: 4
            implicitHeight: 200
            height: parent.availableHeight -parent.handle.height+2
            width: parent.width*0.1
            y: parent.handle.height/2-1
            anchors.horizontalCenter: parent.horizontalCenter
            //radius: width*0.5
            gradient: Gradient {
                //orientation: Gradient.Horizontal
                GradientStop { position: 1; color: buttonCheckedColor}
                GradientStop { position: maxVolume/(maxVolume- miniVolume); color: "yellow" }
                GradientStop { position: 0; color: "red"}
            }
            Rectangle {
                height: slider.visualPosition * parent.height
                width: parent.width
                //radius: parent.radius
                color:backgroundColor
            }
        }

        onMoved: {
            volume = Math.round(((1-visualPosition)*(maxVolume- miniVolume)))
            WS.level(control.channel, volume)
        }


        Repeater{
            id:repeater
            model: (maxVolume-miniVolume)/5+1
            Item{
                anchors.fill: parent
                Shape{ //刻度线
                    anchors.fill: parent
                    ShapePath{
                        strokeColor: (-5*index+maxVolume ) <= 0 ? volumeBlueColor:volumeRedColor
                        strokeWidth: 2
                        startX: parent.width*0.3
                        startY: parent.handle.height/2+(parent.availableHeight-parent.handle.height)/(maxVolume-miniVolume)*5*index
                        PathLine{
                            x:parent.width*0.4
                            y:parent.handle.height/2+(parent.availableHeight-parent.handle.height)/(maxVolume-miniVolume)*5*index
                        }
                    }
                }
                Shape{ //刻度线
                    anchors.fill: parent
                    ShapePath{
                        strokeColor: (-5*index+maxVolume ) <= 0 ? volumeBlueColor:volumeRedColor
                        strokeWidth: 2
                        startX: parent.width*0.6
                        startY: parent.handle.height/2+(parent.availableHeight-parent.handle.height)/(maxVolume-miniVolume)*5*index
                        PathLine{
                            x:parent.width*0.9
                            y:parent.handle.height/2+(parent.availableHeight-parent.handle.height)/(maxVolume-miniVolume)*5*index
                        }
                    }
                }
                Text {
                    text: -5*index+maxVolume
                    width: parent.parent.width*0.3
                    height: parent.parent.handle.height
                    horizontalAlignment: Text.AlignRight
                    x: -parent.width*0.1
                    y: (parent.parent.availableHeight - parent.parent.handle.height)/(maxVolume-miniVolume)*5*index
                    color: (-5*index+maxVolume ) <= 0 ? volumeBlueColor:volumeRedColor
                    font.pixelSize: height*0.3
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
    MyButton{
        id:mute
        height: parent.height*0.1
        width: slider.width
        anchors.bottom:  parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        icon.source: root.digital[control.muteChannel]? "qrc:/qt/qml/content/icons/mute.png":"qrc:/qt/qml/content/icons/unmute.png"
        icon.color: root.digital[control.muteChannel]? volumeRedColor:buttonTextColor
        channel: muteChannel
        text: root.digital[control.muteChannel]? "静音" : root.analog[control.channel]? root.analog[control.channel]+miniVolume : miniVolume
    }
    Text {
        id: channel
        height: parent.height*0.2
        text: root.settings.showChannel? "A"+control.channel : ""
        color: buttonTextColor
        font.pixelSize: height*0.3
    }
}

