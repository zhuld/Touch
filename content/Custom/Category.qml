import QtQuick

//import Qt5Compat.GraphicalEffects

Item{
    id: control
    property real  widthRatio: 0.5
    height: parent.height
    width: (parent.width+parent.spacing)*widthRatio-parent.spacing
    Rectangle {
        id: rectangle
        height: parent.height
        width: parent.width
        gradient: Gradient {
            GradientStop {
                position: 1.0; color: Qt.alpha(catagoryColor,0.6)
                Behavior on color{
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
            GradientStop {
                position: 0.0; color: catagoryColor
                Behavior on color{
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
        }
        radius: height*0.02
    }
    // DropShadow {
    //     anchors.fill: rectangle
    //     horizontalOffset: rectangle.radius/2
    //     verticalOffset: rectangle.radius/2
    //     radius:  rectangle.radius
    //     color: catagoryColor
    //     source: rectangle
    // }
}
