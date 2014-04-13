import QtQuick 2.0
import QtQuick.Nonogram.NonogramModel 1.0

Rectangle {
    id: nonogramView

    function init(title, horizontalCellsCount, verticalCellsCount, comment) {
        nonogramModel.init(title, horizontalCellsCount * verticalCellsCount, comment)

        playingField.width = horizontalCellsCount * 40;
        playingField.height = (verticalCellsCount - 1) * 40;
    }

    NonogramModel {
        id: nonogramModel
    }

    Component {
        id: playingFieldDelegate
        Item {
            width: playingField.cellWidth
            height: playingField.cellHeight
            MouseArea {
                anchors.fill: parent
                onClicked: nonogramModel.toggleCell(index)
            }
            Cell {
                isBlack: isColored
            }
        }
    }

    GridView {
        id: playingField
        anchors.centerIn: parent
        cellWidth: 40
        cellHeight: 40
        model: nonogramModel
        delegate: playingFieldDelegate
    }
}
