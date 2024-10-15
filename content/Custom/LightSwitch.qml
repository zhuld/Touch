import QtQuick
import QtQuick.Shapes
import QtQuick.Controls

import "qrc:/qt/qml/content/crestroncip.js" as CrestronCIP

Item {
    id: control
    property int channel
    property color btnColor: buttonCheckedColor
    property color textColor: buttonTextColor
    property bool checked
    property alias text: label.text
    property color lightColor: control.checked ? "khaki" : "transparent"

    implicitWidth: parent.width
    implicitHeight: width

    Rectangle {
        width: parent.width
        height: parent.height * 0.8
        color: "transparent"
        radius: width * 0.1
    }

    Shape {
        id: light
        width: parent.width
        height: parent.height
        ShapePath {
            strokeColor: "transparent"
            fillGradient: RadialGradient {
                centerX: light.width / 2
                centerY: 0
                centerRadius: light.height
                focalX: centerX
                focalY: centerY
                GradientStop {
                    position: 0
                    color: control.lightColor
                    Behavior on color {
                        ColorAnimation {
                            duration: 500
                        }
                    }
                }
                GradientStop {
                    position: 0.8
                    color: "transparent"
                }
            }
            startX: light.width * 0.45
            startY: 0
            PathLine {
                x: light.width * 0.55
                y: 0
            }
            PathLine {
                x: light.width
                y: light.height * 0.8
            }
            PathLine {
                x: light.width
                y: light.height
            }
            PathLine {
                x: 0
                y: light.height
            }
            PathLine {
                x: 0
                y: light.height * 0.8
            }
            PathLine {
                x: light.width * 0.45
                y: 0
            }
        }
    }

    Text {
        id: label
        text: qsTr("灯光")
        width: parent.width
        height: parent.height * 0.2
        font.pixelSize: height * 0.6
        color: textColor
        anchors.bottom: switchbtn.top
        horizontalAlignment: Text.AlignHCenter
    }
    Rectangle {
        id: switchbtn
        height: parent.height * 0.2
        width: height * 2
        radius: height * 0.5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: control.bottom
        color: control.checked ? buttonCheckedColor : buttonColor
        border.color: backgroundColor

        Rectangle {
            x: control.checked ? parent.width - parent.height : parent.height - height
            width: parent.height * 0.8
            height: width
            radius: height * 0.5
            color: buttonTextColor
            anchors.verticalCenter: parent.verticalCenter
            Text {
                anchors.centerIn: parent
                text: "✓"
                color: buttonCheckedColor
                font.pixelSize: parent.height * 0.8
                opacity: checked ? 1 : 0
                Behavior on opacity {
                    NumberAnimation {
                        duration: 300
                    }
                }
            }
            Behavior on x {
                NumberAnimation {
                    easing.type: Easing.InOutCubic
                    duration: 300
                }
            }
        }
        Behavior on color {
            ColorAnimation {
                duration: 300
            }
        }
    }
    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel ? "D" + control.channel : ""
        color: buttonTextColor
        font.pixelSize: height * 0.1
        anchors.left: parent.left
    }
    MouseArea {
        anchors.fill: parent
        onPressed: cipClient.sendData(CrestronCIP.push(control.channel))
        onReleased: cipClient.sendData(CrestronCIP.releasea(control.channel))
    }
    checked: root.digital[control.channel] ? root.digital[control.channel] : 0
}
