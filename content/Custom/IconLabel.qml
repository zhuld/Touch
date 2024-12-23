import QtQuick

import QtQuick.Controls.impl

IconLabel {
    icon.height: height / 2
    icon.width: height / 2
    icon.color: config.buttonTextColor
    font.pixelSize: height * 0.4
    color: config.buttonTextColor
    font.family: alibabaPuHuiTi.font.family
    spacing: height / 10
}
