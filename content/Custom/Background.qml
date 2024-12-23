import QtQuick
import QtQuick.Effects
import QtQuick.Shapes

Rectangle {
    id: control
    height: parent.height
    width: parent.width
    color: "transparent"
    Shape {
        id: back
        height: parent.height
        width: parent.width
        containsMode: Shape.FillContains
        ShapePath {
            strokeWidth: 0
            strokeColor: "transparent"
            PathRectangle {
                id: pathRect
                x: 0
                y: 0
                radius: back.height / 20
                width: back.width
                height: back.height
            }
            fillGradient: LinearGradient {
                y1: 0
                y2: pathRect.height
                x1: pathRect.width / 2
                x2: pathRect.width / 2
                GradientStop {
                    position: 0.0
                    color: Qt.lighter(config.backgroundColor, 1.3)
                }
                GradientStop {
                    position: 0.8
                    color: Qt.darker(config.backgroundColor, 1.3)
                }
            }
        }
    }
}
