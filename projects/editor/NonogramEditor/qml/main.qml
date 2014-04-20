import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.1
import QtQuick.Nonogram.NonogramEditor 1.0

ApplicationWindow {
    id: nonogramEditor
    property int mode;

    visible: true
    width: 800
    height: 400

    function initStartState() {
        nonogramEditor.title = qsTr("Nonogram Editor");
        nonogramEditor.mode = NonogramEditor.Launcher;
        launcher.setRecentNonograms(nonogramEditorCpp.getFileList());
    }

    function onNewNonogram() {
        launcher.visible = false;
        nonogramCreatorMaster.visible = true;
    }

    function onOpenNonogram() {
        fileDialog.open();
    }

    function onSaveNonogram() {
        nonogramEditorCpp.saveNonogram(nonogramView.getModelJson());
    }

    function onCloseNonogram() {
        // need to show message box
        initStartState();
    }

    /**
     * @param {string} filePath
     */
    function onCreateNonogram(filePath) {
        filePath = filePath.toString().replace(new RegExp("file:///", 'g'), "");

        nonogramEditor.mode = NonogramEditor.NonogramView;
        var jsonObject = nonogramEditorCpp.getJsonObject(filePath);
        nonogramEditor.title = jsonObject["name"];
        nonogramView.initWithJsonObject(jsonObject);
    }

    Component.onCompleted: initStartState();

    onModeChanged: {
        switch(nonogramEditor.mode) {
        case NonogramEditor.Launcher :
            launcher.visible = true;
            nonogramCreatorMaster.visible = false;
            nonogramView.visible = false;
            customMenuBar.mode = nonogramEditor.mode;
            break;

        case NonogramEditor.NonogramCreatorMaster :
            launcher.visible = false;
            nonogramCreatorMaster.visible = true;
            customMenuBar.mode = nonogramEditor.mode;
            break;

        case NonogramEditor.NonogramView :
            nonogramCreatorMaster.visible = false;
            nonogramView.visible = true;
            customMenuBar.mode = nonogramEditor.mode;
            break;
        }
    }

    NonogramEditor {
        id: nonogramEditorCpp
    }

    /* ------------------------------------------ */

    FileDialog {
        id: fileDialog
        title: qsTr("Please choose a file")
        nameFilters: [ "Nonogram files (*.non)", "All files (*)" ]
        onAccepted: nonogramEditor.onCreateNonogram(fileDialog.fileUrls);
    }

    /* ------------------------------------------ */

    CustomMenuBar {
        id: customMenuBar

        onNewNonogram: nonogramEditor.onNewNonogram()
        onOpenNonogram: nonogramEditor.onOpenNonogram()
        onSaveNonogram: nonogramEditor.onSaveNonogram()
        onCloseNonogram: nonogramEditor.onCloseNonogram()
    }
    menuBar: customMenuBar

    Launcher {
        id: launcher

        x: (parent.width - launcher.width) / 2
        y: (parent.height - launcher.height) / 2

        onNewNonogram: nonogramEditor.mode = NonogramEditor.NonogramCreatorMaster;
        onOpenNonogram: nonogramEditor.onOpenNonogram()
        onCreateNonogram: nonogramEditor.onCreateNonogram(filePath)
    }

    NonogramCreatorMaster {
        id: nonogramCreatorMaster

        visible: false;
        x: (parent.width - nonogramCreatorMaster.width) / 2
        y: (parent.height - nonogramCreatorMaster.height) / 2

        onCreateNonogram: {
            nonogramEditor.title = title;
            nonogramView.init(title, horizontalCellsCount, verticalCellsCount, comment);
            nonogramEditor.mode = NonogramEditor.NonogramView;
        }

        onCancelButtonClick: nonogramEditor.initStartState()

        onVisibleChanged: {
            if (nonogramCreatorMaster.visible) {
                nonogramEditor.title = qsTr("New Nonogram")
            }
        }
    }

    NonogramView {
        id: nonogramView

        visible: false;
        width: parent.width
        height: parent.height
    }
}
