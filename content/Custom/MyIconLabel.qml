import QtQuick
import QtQuick.Controls.impl

IconLabel {
    icon.height: height / 2
    icon.width: height / 2
    icon.color: Global.buttonTextColor
    font.pixelSize: height * 0.4
    color: Global.buttonTextColor
    font.family: Global.alibabaPuHuiTi.font.family
    spacing: height / 10
    Behavior on color {
        ColorAnimation {
            duration: 50
        }
    }
    Behavior on icon.color {
        ColorAnimation {
            duration: 50
        }
    }
}
