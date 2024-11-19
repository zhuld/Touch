import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Button {
    id: control
    property real btnRadius: 0
    property color backColor: buttonColor

    implicitHeight: parent.height
    implicitWidth: parent.width
    text: qsTr("Button")

    background: Rectangle {
        id: back
        anchors.fill: parent
        border.color: buttonCheckedColor
        border.width: 0 //height / 40
        gradient: Gradient {
            GradientStop {
                position: 0.2
                color: down | checked ? Qt.darker(buttonCheckedColor,
                                                  1.2) : backColor
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            GradientStop {
                position: 1
                color: down | checked ? buttonCheckedColor : Qt.darker(
                                            backColor, 1.2)
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
        }
        radius: btnRadius
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: buttonShadowColor
            shadowHorizontalOffset: (control.checked
                                     || control.pressed) ? height / 60 : height / 20
            shadowVerticalOffset: shadowHorizontalOffset
            Behavior on shadowHorizontalOffset {
                NumberAnimation {
                    duration: 100
                }
            }
        }
    }

    contentItem: Text {
        anchors.fill: parent
        text: control.text
        font.pixelSize: control.height * 0.4
        color: buttonTextColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: alibabaPuHuiTi.font.family
    }

    onPressedChanged: {
        if (pressed) {
            y += height / 40
        } else {
            y -= height / 40
        }
    }
    Behavior on y {
        NumberAnimation {
            duration: 100
        }
    }
}
