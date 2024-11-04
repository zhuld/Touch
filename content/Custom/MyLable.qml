import QtQuick
import QtQuick.Shapes
import QtQuick.Effects

Item {
    id: control
    property alias text: labelText.text
    width: parent.width

    Text {
        id: labelText
        text: qsTr("Label")
        height: parent.height * 0.95
        width: parent.width
        anchors.fill: parent
        font.pixelSize: height * 0.5
        verticalAlignment: Text.AlignTop
        horizontalAlignment: Text.AlignHCenter
        color: buttonTextColor
        styleColor: buttonTextColor
        font.family: alibabaPuHuiTi.font.family
    }
}
