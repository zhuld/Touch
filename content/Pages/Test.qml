import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

import "../Custom"

Item {
    implicitWidth: parent.width
    implicitHeight: parent.height
    ListModel {
        id: dataModel
        ListElement {
            name: "Item 1"
            category: "A"
        }
        ListElement {
            name: "Item 2"
            category: "B"
        }
        ListElement {
            name: "Item 3"
            category: "A"
        }
        ListElement {
            name: "Item 4"
            category: "C"
        }
        ListElement {
            name: "Item 5"
            category: "B"
        }
    }

    // Filtered data will be stored here
    ListModel {
        id: filteredModel
    }

    // ListView to display filtered data
    ListView {
        width: parent.width
        height: 200
        model: filteredModel

        delegate: Item {
            width: ListView.view.width
            height: 50
            Rectangle {
                width: parent.width
                height: 50
                color: "lightgray"
                border.color: "black"
                border.width: 1

                Text {
                    anchors.centerIn: parent
                    text: model.name
                }
            }
        }
    }

    // TextField to input filter text
    TextField {
        id: filterTextField
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width
        placeholderText: "Filter by category"

        onTextChanged: {
            // Clear the filtered model
            filteredModel.clear()

            var filterText = filterTextField.text.toLowerCase()

            // Loop through original model and add filtered items to filteredModel
            for (var i = 0; i < dataModel.count; i++) {
                var item = dataModel.get(i)
                if (item.category.toLowerCase().includes(filterText)) {
                    filteredModel.append(item)
                }
            }
        }
    }
}
