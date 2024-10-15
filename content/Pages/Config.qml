import QtQuick

Item {
    id: control
    property alias pageList: config.pageList
    property alias logoName: config.logoName
    property alias titleName: config.titleName
    property alias version: config.version
    property alias background: config.background
    property alias logoImage: config.logoImage
    ShiyiMZ {
        id: config
    }
}
