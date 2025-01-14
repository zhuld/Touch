import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Templates as T

T.Switch {
    id: control
    implicitHeight: parent.height
    implicitWidth: parent.width

    indicator: Rectangle {
        id: indicator
        width: height * 2
        height: parent.height * 0.5
        radius: height * 0.5
        color: checked ? Global.buttonCheckedColor : Global.backgroundColor
        border.color: Global.buttonTextColor
        x: height / 2
        anchors.verticalCenter: parent.verticalCenter
        Behavior on color {
            ColorAnimation {
                duration: Global.durationDelay
            }
        }
        Rectangle {
            x: checked ? parent.width - parent.height : parent.height - height
            width: parent.height * 1.6
            height: width
            radius: height * 0.5
            color: Global.backgroundColor
            border.color: Global.buttonTextColor
            anchors.verticalCenter: parent.verticalCenter
            Behavior on color {
                ColorAnimation {
                    duration: Global.durationDelay
                }
            }
            Text {
                anchors.centerIn: parent
                text: "✓"
                opacity: checked ? 1 : 0
                color: Global.buttonCheckedColor
                font.pixelSize: parent.height * 0.8
                font.family: Global.alibabaPuHuiTi.font.family
                Behavior on opacity {
                    NumberAnimation {
                        easing.type: Easing.InOutQuad
                        duration: Global.durationDelay
                    }
                }
            }
            layer.enabled: true
            layer.samples: 16
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: Global.buttonShadowColor
                shadowHorizontalOffset: shadowHeight / 2
                shadowVerticalOffset: shadowHorizontalOffset
            }
            Behavior on x {
                NumberAnimation {
                    duration: Global.durationDelay
                }
            }
        }
    }
    contentItem: Text {
        height: parent.height
        text: control.text
        font.pixelSize: height * 0.7
        anchors.left: indicator.right
        leftPadding: height
        color: Global.buttonTextColor
        font.family: Global.alibabaPuHuiTi.font.family
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }
}
