import QtQuick
import QtQuick.Controls
import QtQuick.Effects

import "qrc:/qt/qml/content/crestroncip.js" as CrestronCIP

Button {
    id: control

    property int channel
    property color btnColor: buttonColor

    property int delay: 2500

    text: qsTr("DelayBtn")

    icon.width: height * 0.4
    icon.height: height * 0.4
    icon.color: buttonTextColor
    font.pixelSize: height * 0.35
    font.family: alibabaPuHuiTi.font.family

    background: Rectangle {
        id: bgrect
        anchors.fill: parent
        //color: "transparent"
        color: root.digital[control.channel] ? btnColor : root.settings.darkTheme ? Qt.darker(btnColor, 1.4) : Qt.lighter(btnColor, 1.4)
        radius: height * 0.1
        Rectangle {
            id: progressBar
            height: parent.height
            //width: parent.width * control.progress
            color: btnColor
            radius: parent.radius
            width: parent * 0.5
        }
        NumberAnimation {
            id: delayAnimationUp
            target: bgrect
            property: "width"
            from: 0
            to: control.width
            duration: delay
        }
        NumberAnimation {
            id: delayAnimationDown
            target: bgrect
            property: "width"
            from: control.width
            to: 0
            duration: delay
        }
    }

    // MultiEffect {
    //     source: rect
    //     anchors.fill: rect
    //     shadowEnabled: true
    //     shadowColor: Qt.alpha(rect.color, 0.8)
    //     shadowHorizontalOffset: rect.height / 40
    //     shadowVerticalOffset: shadowHorizontalOffset
    // }
    Text {
        id: channel
        height: parent.height
        text: root.settings.showChannel ? "D" + control.channel : ""
        color: buttonTextColor
        font.pixelSize: height * 0.3
    }

    onPressed: {
        //delayAnimationDown.stop()
        delayAnimationUp.start()
        CrestronCIP.push(control.channel)
    }
    onReleased: {
        //delayAnimationUp.stop()
        delayAnimationDown.start()
        CrestronCIP.release(control.channel)
    }
    onHoveredChanged: if (pressed) {
                          CrestronCIP.release(control.channel)
                      }
    //onActivated: progress = 0
}
