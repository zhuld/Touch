import QtQuick

Item{
    id: control
    property real widthRatio: 0.5
    height: parent.height
    width: (parent.width+parent.spacing)*widthRatio-parent.spacing
    Rectangle {
        id: rectangle
        height: parent.height
        width: parent.width
        gradient: Gradient {
            GradientStop {
                position: 1.0; color: Qt.alpha(catagoryColor,0.2)
                Behavior on color{
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
            GradientStop {
                position: 0.1; color: catagoryColor
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
        radius: height*0.03
        border.color:buttonCheckedColor
        border.width: parent.height*0.002
    }
}
