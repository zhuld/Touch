import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import QtQuick.Effects

import "qrc:/qt/qml/content/Js/crestroncip.js" as CrestronCIP

Item {
    id: control
    property int channel
    property int disEnableChannel: 0
    enabled: root.digital[control.disEnableChannel] ? false : true
    opacity: enabled ? 1 : 0.6

    implicitWidth: 100
    implicitHeight: 130

    Shape {
        id: shapeCircle
        width: parent.width
        height: width
        ShapePath {
            strokeColor: catagoryColor
            strokeWidth: parent.width * 0.01
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
                    iconUrl: "qrc:/content/icons/down.png"
                }
                ListElement {
                    name: "9"
                    enable: false
                    dPadIcon: ""
                    iconUrl: ""
                }
            }
            delegate: Button {
                id: dpadDrog
                required property string name
                required property bool enable
                required property int index
                required property string iconUrl
                width: (parent.width + parent.spacing) / parent.columns - parent.spacing
                height: (parent.height + parent.spacing) / dpadModel.count
                        * parent.columns - parent.spacing

                icon.source: iconUrl
                icon.height: height * 0.5
                icon.width: height * 0.5
                icon.color: buttonTextColor
                Behavior on icon.width {
                    NumberAnimation {
                        target: dpadDrog
                        property: "icon.width"
                        duration: 300
                    }
                }
                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                }

                Text {
                    id: channel
                    height: parent.height
                    text: root.settings.showChannel & enable ? "D" + (control.channel + index) : ""
                    color: buttonTextColor
                    font.pixelSize: height * 0.3
                    font.family: alibabaPuHuiTi.font.family
                }
                DropArea {
                    id: dropContainer
                    enabled: enable
                    anchors.fill: parent
                    Connections {
                        onEntered: {
                            icon.height = height
                            icon.width = height
                            CrestronCIP.push(control.channel + index)
                        }
                        onExited: {
                            icon.height = height * 0.5
                            icon.width = height * 0.5
                            CrestronCIP.release(control.channel + index)
                        }
                    }
                }
                onPressed: {
                    if (enable) {
                        icon.height = height
                        icon.width = height
                        CrestronCIP.push(control.channel + index)
                    }
                }
                onReleased: {
                    if (enable) {
                        icon.height = height * 0.5
                        icon.width = height * 0.5
                        CrestronCIP.release(control.channel + index)
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
    MyButton {
        height: dpadBackground.height * 0.25
        width: height
        y: dpadBackground.height
        //anchors.top: dpadBackground.bottom
        icon.source: "qrc:/content/icons/fangda.png"
        icon.color: buttonTextColor
        radius: width / 2
        channel: control.channel + 9
    }
    MyButton {
        height: dpadBackground.height * 0.25
        width: height
        y: dpadBackground.height
        anchors.right: dpadBackground.right
        icon.source: "qrc:/content/icons/suoxiao.png"
        icon.color: buttonTextColor
        radius: width / 2
        channel: control.channel + 10
    }

    Text {
        id: disEnableChannel
        height: parent.height * 0.2
        text: root.settings.showChannel ? "E" + control.disEnableChannel : ""
        color: buttonTextColor
        font.pixelSize: height * 0.3
        anchors.right: parent.right
        font.family: alibabaPuHuiTi.font.family
    }
}
