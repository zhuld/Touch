import QtQuick
import QtQuick.Controls

import QtQuick.Shapes

//import "qrc:/qt/qml/content/ws.js" as WS
import "qrc:/qt/qml/content/crestroncip.js" as CrestronCIP

Item {
    id: control

    property int channel
    implicitWidth: 100
    implicitHeight: 130

    Shape {
        id: shapeCircle
        width: parent.width
        height: width
        ShapePath {
            strokeColor: buttonCheckedColor
            strokeWidth: parent.width * 0.005
            startX: shapeCircle.width / 2
            startY: 0
            PathArc {
                x: shapeCircle.width / 2
                y: shapeCircle.height
                radiusX: shapeCircle.width / 2
                radiusY: shapeCircle.height / 2
            }
            PathArc {
                x: shapeCircle.width / 2
                y: 0
                radiusX: shapeCircle.width / 2
                radiusY: shapeCircle.height / 2
            }
            fillGradient: RadialGradient {
                centerX: shapeCircle.width / 2 - pad.x
                centerY: shapeCircle.height / 2 - pad.y
                centerRadius: shapeCircle.width
                focalX: shapeCircle.width / 2 + pad.x
                focalY: shapeCircle.height / 2 + pad.y
                focalRadius: shapeCircle.width * 0.08
                GradientStop {
                    position: 0
                    color: mouseArea.pressed ? buttonCheckedColor : Qt.alpha(
                                                   buttonColor, 0.4)
                    Behavior on color {
                        ColorAnimation {
                            duration: 500
                        }
                    }
                }
                GradientStop {
                    position: 0.2
                    color: "transparent"
                }
            }
        }
    }
    Grid {
        id: dpadBackground
        width: parent.width
        height: width
        columns: 3
        spacing: -width / 20
        Repeater {
            model: ListModel {
                id: dpadModel
                ListElement {
                    name: "1"
                    enable: false
                    dPadIcon: ""
                    iconUrl: ""
                }
                ListElement {
                    name: "2"
                    enable: true
                    dPadIcon: "qrc:/content/icons/dpad-up.png"
                    iconUrl: "qrc:/content/icons/up.png"
                }
                ListElement {
                    name: "3"
                    enable: false
                    dPadIcon: ""
                    iconUrl: ""
                }
                ListElement {
                    name: "4"
                    enable: true
                    dPadIcon: "qrc:/content/icons/dpad-left.png"
                    iconUrl: "qrc:/content/icons/left.png"
                }
                ListElement {
                    name: "5"
                    enable: false
                    dPadIcon: ""
                    iconUrl: ""
                }
                ListElement {
                    name: "6"
                    enable: true
                    dPadIcon: "qrc:/content/icons/dpad-right.png"
                    iconUrl: "qrc:/content/icons/right.png"
                }
                ListElement {
                    name: "7"
                    enable: false
                    dPadIcon: ""
                    iconUrl: ""
                }
                ListElement {
                    name: "8"
                    enable: true
                    dPadIcon: "qrc:/content/icons/dpad-down.png"
                    iconUrl: "qrc:/content/icons/down.png"
                }
                ListElement {
                    name: "9"
                    enable: false
                    dPadIcon: ""
                    iconUrl: ""
                }
            }
            delegate: Rectangle {
                id: dpadDrog
                required property string name
                required property bool enable
                required property int index
                required property string dPadIcon
                required property string iconUrl
                width: (parent.width + parent.spacing) / parent.columns - parent.spacing
                height: (parent.height + parent.spacing) / dpadModel.count
                        * parent.columns - parent.spacing
                color: "transparent"
                radius: width / 2
                IconLabel {
                    id: icon
                    anchors.fill: parent
                    icon.height: height * 0.5
                    icon.color: buttonTextColor
                    icon.source: iconUrl
                    Behavior on icon.height {
                        NumberAnimation {
                            duration: 200
                        }
                    }
                }
                Text {
                    id: channel
                    height: parent.height
                    text: root.settings.showChannel & enable ? "D" + (control.channel + index) : ""
                    color: buttonTextColor
                    font.pixelSize: height * 0.3
                }
                DropArea {
                    id: dropContainer
                    enabled: enable
                    anchors.fill: parent
                    Connections {
                        onEntered: {
                            icon.icon.height = height * 0.9
                            cipClient.sendData(CrestronCIP.push(
                                                   control.channel + index))
                            //WS.push(control.channel+index)
                        }
                        onExited: {
                            icon.icon.height = height * 0.5
                            cipClient.sendData(CrestronCIP.release(
                                                   control.channel + index))
                            //WS.release(control.channel + index)
                        }
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        if (enable) {
                            icon.icon.height = height * 0.9
                            cipClient.sendData(CrestronCIP.push(
                                                   control.channel + index))
                            //WS.push(control.channel+index)
                        }
                    }
                    onReleased: {
                        if (enable) {
                            icon.icon.height = height * 0.5
                            cipClient.sendData(CrestronCIP.release(
                                                   control.channel + index))
                            //WS.release(control.channel + index)
                        }
                    }
                }
            }
        }
    }

    MouseArea {
        id: mouseArea
        width: dpadBackground.width * 0.3
        height: width
        anchors.centerIn: dpadBackground
        onReleased: dragButtonAnimation.start()
        ParallelAnimation {
            id: dragButtonAnimation
            NumberAnimation {
                target: pad
                property: "x"
                duration: 300
                to: 0
                easing.type: Easing.OutBack
            }
            NumberAnimation {
                target: pad
                property: "y"
                duration: 300
                to: 0
                easing.type: Easing.OutBack
            }
        }
        drag.target: pad
        drag.minimumX: -dpadBackground.width / 2 + width * 0.7
        drag.maximumX: dpadBackground.width / 2 - width * 0.7
        drag.minimumY: -dpadBackground.height / 2 + height * 0.7
        drag.maximumY: dpadBackground.height / 2 - height * 0.7
        Rectangle {
            id: pad
            width: parent.width
            height: width
            radius: width / 2
            color: "transparent"
            Drag.active: mouseArea.drag.active
            Drag.hotSpot.x: width / 2
            Drag.hotSpot.y: height / 2
        }
    }
    MyRoundButton {
        height: dpadBackground.height * 0.3
        width: height
        anchors.top: dpadBackground.bottom
        icon.source: "qrc:/content/icons/fangda.png"
        icon.color: buttonTextColor
        channel: control.channel + 9
    }
    MyRoundButton {
        height: dpadBackground.height * 0.3
        width: height
        anchors.top: dpadBackground.bottom
        anchors.right: dpadBackground.right
        icon.source: "qrc:/content/icons/suoxiao.png"
        icon.color: buttonTextColor
        channel: control.channel + 10
    }
}
