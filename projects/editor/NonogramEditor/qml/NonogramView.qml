import QtQuick 2.0

Rectangle {
    id: nonogramView

    function setSize(horizontalCellsCount, verticalCellsCount) {
        view.width = horizontalCellsCount * 40;
        view.height = (verticalCellsCount - 1) * 40;
    }

    GridView {
        id: view
        anchors.centerIn: parent
        cellHeight: 40
        delegate: Item {
            x: 5
            height: 50
            Column {
                spacing: 5
                Rectangle {
                    width: 40
                    height: 40
                    color: colorCode
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
        cellWidth: 40
        model: ListModel {
            ListElement {
                colorCode: "grey"
            }

            ListElement {
                colorCode: "red"
            }

            ListElement {
                colorCode: "blue"
            }

            ListElement {
                colorCode: "green"
            }
        }
    }


}
