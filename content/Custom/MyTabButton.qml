import QtQuick
import QtQuick.Controls
import QtQuick.Effects

TabButton {
    id: control
    width: parent.width
    height: parent.height
    icon.width: control.checked ? height * 0.5 : height * 0.4
    icon.height: control.checked ? height * 0.5 : height * 0.4

    icon.color: buttonTextColor
    font.pixelSize: height * 0.2
    anchors.margins: width * 0.2
    contentItem: IconLabel {
        anchors.fill: parent
        text: control.text
        font: control.font
        icon: control.icon
        opacity: enabled ? 1.0 : 0.3
        color: buttonTextColor
        display: AbstractButton.TextUnderIcon
        spacing: parent.height * 0.1
    }

    background: Rectangle {
        id: rectangle
        anchors.fill: parent
        opacity: enabled ? 1 : 0.3
        color: control.checked ? buttonCheckedColor : buttonColor
        radius: width / 10
        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
    }

    MultiEffect {
        source: rectangle
        anchors.fill: rectangle
        shadowEnabled: true
        shadowColor: Qt.alpha(rectangle.color, 0.8)
        shadowHorizontalOffset: rectangle.height / 40
        shadowVerticalOffset: shadowHorizontalOffset
    }
}
