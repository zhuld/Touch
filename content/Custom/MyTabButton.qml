import QtQuick
import QtQuick.Controls

TabButton {
    id: control
    icon.width: height*0.4
    icon.height: height*0.4
    icon.color:  buttonTextColor
    font.pixelSize: height*0.2
    anchors.margins: width*0.2
    contentItem: IconLabel {
        anchors.fill: parent
        text: control.text
        font: control.font
        icon: control.icon
        opacity: enabled ? 1.0 : 0.3
        color: buttonTextColor
        display: AbstractButton.TextUnderIcon
        spacing: height*0.1
    }

    background: Rectangle {
        anchors.fill: parent
        opacity: enabled ? 1 : 0.3
        color: control.checked ? buttonCheckedColor : buttonColor
        radius: width/10
        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
    }
}
