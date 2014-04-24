import QtQuick 2.2
import QtQuick.Nonogram.NonogramModel 1.0

Rectangle {
    id: nonogramView

    anchors.fill: parent

    signal cellStateChanged()

    /**
     * @param {string} name
     * @param {int} horizontalCellsCount
     * @param {int} verticalCellsCount
     * @param {string} comment
     */
    function init(name, horizontalCellsCount, verticalCellsCount, comment) {
        nonogramModel.name = name;
        nonogramModel.comment = comment;
        nonogramModel.setSize(horizontalCellsCount, verticalCellsCount);
        nonogramView._initPlayingField();
    }

    /**
     * @param {QJsonObject} jsonObject
     */
    function initWithJsonObject(jsonObject) {
        nonogramModel.initWithJsonObject(jsonObject);
        nonogramView._initPlayingField();
    }

    /**
     * @return {QJsonObject}
     */
    function getModelJson() {
        return nonogramModel.toJsonObject();
    }

    /**
     * @private
     */
    function _initPlayingField() {
        var tmp1 = Math.min(nonogramView.width / nonogramModel.width(), 40);
        var tmp2 = Math.min(nonogramView.height / nonogramModel.height(), 40);
        var min = Math.min(tmp1, tmp2);

        playingField.cellWidth = min;
        playingField.cellHeight = min;

        playingField.width = nonogramModel.width() * playingField.cellWidth
        playingField.height = (nonogramModel.height()) * playingField.cellHeight
    }

    onHeightChanged: nonogramView._initPlayingField();
    onWidthChanged: nonogramView._initPlayingField();

    NonogramModel {
        id: nonogramModel

        onLayoutChanged: nonogramView.cellStateChanged();
    }

    Component {
        id: playingFieldDelegate
        Item {
            width: playingField.cellWidth
            height: playingField.cellHeight
            MouseArea {
                anchors.fill: parent
                onClicked: nonogramModel.toggleCell(index);
            }
            Cell {
                isBlack: isColored
            }
        }
    }

    GridView {
        id: playingField

        anchors.centerIn: parent;

        model: nonogramModel
        delegate: playingFieldDelegate
    }
}
