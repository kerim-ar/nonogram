import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Nonogram.NonogramEditor 1.0

MenuBar {

    id: menuBar

    property int mode

    signal newNonogram()
    signal openNonogram()
    signal saveNonogram()
    signal publish()
    signal closeNonogram()

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
            text: qsTr("Publish")
            enabled: (mode == NonogramEditor.NonogramView)
            onTriggered: publish()
        }
        MenuItem {
            text: qsTr("Close nonogram")
            enabled: (mode == NonogramEditor.NonogramView)
            onTriggered: closeNonogram()
        }
    }
}
