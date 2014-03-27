import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.1

ApplicationWindow {
    visible: true
    width: 800
    height: 640

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

        visible: true
        x: (parent.width - launcher.width) / 2
        y: (parent.height - launcher.height) / 2

        Component.onCompleted: {
            launcher.newNonogram.connect(function() {
                launcher.visible = false
                nonogramCreatorMaster.visible = true
            })

            launcher.openNonogram.connect(function() {
                fileDialog.open()
            })
        }
    }

    NonogramCreatorMaster {
        id: nonogramCreatorMaster
        x: (parent.width - nonogramCreatorMaster.width) / 2
        y: (parent.height - nonogramCreatorMaster.height) / 2
        visible: false

        Component.onCompleted: {
            nonogramCreatorMaster.createNonogram.connect(function() {
                nonogramCreatorMaster.visible = false
                //TODO: init nonogram
                nonogram.visible = true
            })
        }
    }

    Nonogram {
        id: nonogram
        width: parent.width
        height: parent.height
        visible: false
    }
}
