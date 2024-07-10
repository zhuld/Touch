import QtQuick
import QtQuick.Shapes

Item {
    id:control
    property alias text : labelText.text
    width: parent.width
    height:100
    Text {
        id:labelText
        text: qsTr("Label")
        anchors.fill: parent
        font.pixelSize: height*0.5
        verticalAlignment: Text.AlignTop
        horizontalAlignment: Text.AlignHCenter
        color: textColor
    }
    Shape{
        anchors.fill: parent
        ShapePath{
            strokeColor: textColor
            strokeStyle: ShapePath.SolidLine
            strokeWidth: parent.height*0.003
            startX: 0
            startY: control.height
            PathLine{
                x:control.width
                y:control.height
            }
        }
    }
}
