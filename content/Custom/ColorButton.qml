import QtQuick
import QtQuick.Controls

Button {
    id:control
    property real btnRadius: 0

    implicitHeight: parent.height
    implicitWidth: parent.width

    text: qsTr("Button")

    background:  Rectangle{
        width: parent.width
        height: parent.height
        id: rect
        border.color:buttonCheckedColor
        border.width: 2
        color: control.down | control.checked?  buttonCheckedColor:buttonColor
        radius: btnRadius
    }

    contentItem: Text {
        text: control.text
        font.pixelSize: control.height*0.4
        color: buttonTextColor
        wrapMode: Text.Wrap
        horizontalAlignment : Text.AlignHCenter
        verticalAlignment : Text.AlignVCenter
    }
    opacity: enabled? 1:0.6
}
