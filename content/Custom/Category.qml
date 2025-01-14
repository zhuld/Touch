import QtQuick
import QtQuick.Effects
import QtQuick.Shapes

import "../"

Item {
    id: control
    property alias content: content.data
    property alias info: info.data
    property real widthRatio: 1
    property string label
    height: parent.height - parent.width * 0.02
    width: (parent.width * 0.98 + parent.spacing) * widthRatio - parent.spacing
    Shape {
        id: back
        anchors.fill: parent
        containsMode: Shape.FillContains
        layer.enabled: true
        layer.samples: 16
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: Global.buttonShadowColor
            shadowHorizontalOffset: shadowVerticalOffset
            shadowVerticalOffset: shadowHeight
            Behavior on shadowHorizontalOffset {
                NumberAnimation {
                    duration: 100
                }
            }
        }
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
                    position: 0.13
                    color: Global.backgroundColor
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
                GradientStop {
                    position: 0.101
                    color: Qt.darker(Global.backgroundColor, 1.4)
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
                GradientStop {
                    position: 0.1
                    color: Global.backgroundColor
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
                GradientStop {
                    position: 0.07
                    color: Global.backgroundColor
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
                GradientStop {
                    position: 0.0
                    color: Qt.lighter(Global.backgroundColor, 1.3)
                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }
                }
            }
        }
    }
    MyIconLabel {
        text: control.label
        height: parent.height * 0.1
        width: parent.width
    }
    Item {
        id: content
        anchors.fill: parent
        anchors.topMargin: parent.height * 0.15
        anchors.bottomMargin: parent.height * 0.04
        anchors.leftMargin: parent.height * 0.04
        anchors.rightMargin: parent.height * 0.04
    }
    Item {
        id: info
        height: parent.height * 0.08
        width: parent.width
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.01
        anchors.left: parent.left
        anchors.leftMargin: parent.height * 0.04
    }
}
