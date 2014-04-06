import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.1
//import QtQuick.Nonogram.NonogramEditor 1.0

ApplicationWindow {
    id: nonogramEditor

    visible: true
    width: 800
    height: 400

    function init() {
        nonogramEditor.title = qsTr("Nonogram Editor")

        launcher.visible = true;
        nonogramCreatorMaster.visible = false;
        nonogramView.visible = false;
    }

    Component.onCompleted: init()

    /* ------------------------------------------ */

    FileDialog {
        id: fileDialog
        title: qsTr("Please choose a file")
        nameFilters: [ "Text files (*.txt)", "All files (*)" ]
    }

    /* ------------------------------------------ */

    CustomMenuBar {
        id: customMenuBar
    }
    menuBar: customMenuBar

    Launcher {
        id: launcher

        x: (parent.width - launcher.width) / 2
        y: (parent.height - launcher.height) / 2

        onNewNonogram: {
            launcher.visible = false
            nonogramCreatorMaster.visible = true
        }

        onOpenNonogram: {
            fileDialog.open()
        }
    }

    NonogramCreatorMaster {
        id: nonogramCreatorMaster
        x: (parent.width - nonogramCreatorMaster.width) / 2
        y: (parent.height - nonogramCreatorMaster.height) / 2

        onCreateNonogram: {
            nonogramCreatorMaster.visible = false
            nonogramView.visible = true
            nonogramView.setSize(horizontalCellsCount, verticalCellsCount)
        }

        onVisibleChanged: {
            if (nonogramCreatorMaster.visible) {
                nonogramEditor.title = qsTr("New Nonogram")
            }
        }
    }

    NonogramView {
        id: nonogramView
        width: parent.width
        height: parent.height
    }
}
