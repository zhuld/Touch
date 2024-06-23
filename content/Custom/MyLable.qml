import QtQuick

Item {
    id:control
    property alias text : labelText.text
    width: parent.width
    height:100
    Text {
        id:labelText
        text: qsTr("Label")
        width: parent.width
        height: parent.height*0.9
        font.pixelSize: height*0.6
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: textColor
    }

    Rectangle{
        id:labelLine
        width: parent.width
        height: parent.height*0.02
        color: textColor
        anchors.bottom: parent.bottom
    }

}
