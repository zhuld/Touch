import QtQuick

QtObject {
    readonly property string logoName: qsTr("启动页面")
    readonly property string titleName: qsTr("配置文件选择")
    readonly property string version: qsTr("202501")
    readonly property string background: "qrc:/content/images/background.jpg"
    readonly property string logoImage: ""
    readonly property int processDialogChannel: 0

    readonly property ListModel pageList: ListModel {}

    readonly property ListModel initValue: ListModel {}

    readonly property bool tabOnBottom: false
}
