import QtQuick
import QtQuick.Controls
import Touch

import "./Custom"
import "./Pages"
import "./icons"

Item{
    id:main
    anchors.fill: parent
    anchors.margins: width*0.02

    Column {
        id:tabBar
        width: parent.width*0.12
        height: parent.height
        spacing: height*0.02
           Repeater {
                id:repeater
                model: root.pageList
                delegate: MyTabButton{
                    id:tabButton
                    required property string name
                    required property string iconUrl
                    required property string pageUrl
                    required property int index
                    text: name
                    width: parent.width
                    height: (parent.height+parent.spacing)/repeater.model.count - parent.spacing
                    icon.source: iconUrl

                    Connections{
                        onClicked:{
                            if(pageUrl.localeCompare(loader.source)){
                                loader.setSource(pageUrl)
                                usedIndex = index
                            }
                        }
                        Component.onCompleted: {
                            if(index === usedIndex){
                                tabButton.checked = true
                                tabButton.clicked()
                            }
                        }
                    }
                }
            }

    }

    Loader{
        id:loader
        anchors.right: parent.right
        width: parent.width*0.98 - tabBar.width
        height: parent.height
    }
}
