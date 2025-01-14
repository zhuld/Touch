import QtQuick
import QtQuick.Effects
import QtQuick.Shapes

import "../"

Rectangle {
    id: control
    implicitHeight: parent.height
    implicitWidth: parent.width
    //anchors.fill: parent
    color: "transparent"
    Shape {
        id: back
        anchors.fill: parent
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
                    color: Qt.lighter(Global.backgroundColor, 1.3)
                }
                GradientStop {
                    position: 0.22
                    color: Global.backgroundColor
                }
                GradientStop {
                    position: 0.221
                    color: Qt.darker(Global.backgroundColor, 1.3)
                }
                GradientStop {
                    position: 0.28
                    color: Global.backgroundColor
                }
            }
        }
    }
}
