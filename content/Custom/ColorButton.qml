import QtQuick
import QtQuick.Controls

Button {
    id:control
    property color btnColor: "steelblue"
    property color borderColor: "steelblue"
    property color textColor: "whitesmoke"
    property real btnRadius: 0

    implicitHeight: parent.height
    implicitWidth: parent.width

    text: qsTr("Button")

    background:  Rectangle{
        width: parent.width
        height: parent.height
        id: rect
        border.color: control.down | control.checked  ?  Qt.darker(control.borderColor, 2):Qt.lighter(control.borderColor, 1.1)
        border.width: 2
        color: control.down | control.checked?  btnColor: control.hovered?  Qt.darker(btnColor, 2):"transparent"
        radius: btnRadius
    }

    contentItem: Text {
        text: control.text
        font.pixelSize: control.height*0.35
        color: control.down | control.checked? Qt.lighter(control.textColor, 1.4) :Qt.darker(control.textColor, 1.2)
        wrapMode: Text.Wrap
        horizontalAlignment : Text.AlignHCenter
        verticalAlignment : Text.AlignVCenter
    }
    opacity: enabled? 1:0.6
}
