import QtQuick 2.0
import QtQuick.Nonogram.NonogramModel 1.0

Rectangle {
    id: nonogramView

    /**
     * @param {string} name
     * @param {int} horizontalCellsCount
     * @param {int} verticalCellsCount
     * @param {string} comment
     */
    function init(name, horizontalCellsCount, verticalCellsCount, comment) {
        nonogramModel.name = name;
        nonogramModel.comment = comment;
        nonogramModel.setSize(horizontalCellsCount, verticalCellsCount)

        playingField.width = horizontalCellsCount * 40;
        playingField.height = (verticalCellsCount - 1) * 40;
    }

    /**
     * @param {QJsonObject} jsonObject
     */
    function initWithJsonObject(jsonObject) {
        nonogramModel.initWithJsonObject(jsonObject);

        playingField.width = nonogramModel.width() * 40;
        playingField.height = (nonogramModel.height() - 1) * 40;
    }

    /**
     * @return {QJsonObject}
     */
    function getModelJson() {
        return nonogramModel.toJsonObject();
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
