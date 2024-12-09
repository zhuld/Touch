import QtQuick
import QtQuick.Effects

Item {
    id: control
    property real widthRatio: 1
    property alias lable: _lable.text

    height: parent.height - parent.width * 0.02
    width: (parent.width * 0.98 + parent.spacing) * widthRatio - parent.spacing
    Rectangle {
        id: rectangle
        height: parent.height
        width: parent.width
        gradient: Gradient {
            GradientStop {
                position: 1.0
                color: Qt.alpha(catagoryColor, 0.5)
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            GradientStop {
                position: 0.112
                color: Qt.alpha(catagoryColor, 0.7)
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
            GradientStop {
                position: 0.11
                color: catagoryColor
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
        }
        radius: height * 0.05
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset / 2
            shadowVerticalOffset: height / 100
        }
    }
    Text {
        id: _lable
        text: qsTr("Label")
        height: parent.height * 0.1
        width: parent.width
        font.pixelSize: height * 0.5
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: buttonTextColor
        styleColor: buttonTextColor
        font.family: alibabaPuHuiTi.font.family
    }
}
