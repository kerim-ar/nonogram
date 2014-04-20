import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Nonogram.NonogramEditor 1.0

MenuBar {

    id: menuBar

    property int mode

    signal newNonogram()
    signal openNonogram()
    signal saveNonogram()
    signal changeWorkingDirectory()
    signal closeNonogram()
    signal publishToCloud()
    signal options()

    Menu {
        title: qsTr("File")

        MenuItem {
            text: qsTr("New nonogram")
            enabled: (mode == NonogramEditor.Launcher || mode == NonogramEditor.NonogramView)
            onTriggered: newNonogram()
        }
        MenuItem {
            text: qsTr("Open nonogram")
            enabled: (mode == NonogramEditor.Launcher || mode == NonogramEditor.NonogramView)
            onTriggered: openNonogram()
        }
        MenuItem {
            text: qsTr("Save nonogram")
            enabled: (mode == NonogramEditor.NonogramView)
            onTriggered: saveNonogram()
        }
        MenuItem {
            text: qsTr("Change working directory")
            enabled: (mode == NonogramEditor.NonogramView)
            onTriggered: changeWorkingDirectory()
        }
        MenuItem {
            text: qsTr("Close nonogram")
            enabled: (mode == NonogramEditor.NonogramView)
            onTriggered: closeNonogram()
        }
    }
    Menu {
        title: qsTr("Publish")

        MenuItem {
            text: qsTr("Publish to cloud")
            enabled: (mode == NonogramEditor.NonogramView)
            onTriggered: publishToCloud()
        }
        MenuItem {
            text: qsTr("Options")
            enabled: (mode == NonogramEditor.NonogramView)
            onTriggered: options()
        }
    }
}
