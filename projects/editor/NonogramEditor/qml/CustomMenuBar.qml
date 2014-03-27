import QtQuick 2.2
import QtQuick.Controls 1.1

MenuBar {
    Menu {
        id: file
        title: qsTr("File")

        MenuItem {
            text: qsTr("New crossword")
            //TODO: onTriggered:
        }
        MenuItem {
            text: qsTr("Open crossword")
            //TODO: onTriggered:
        }
        MenuItem {
            text: qsTr("Save crossword")
            enabled: false
            //TODO: onTriggered:
        }
        MenuItem {
            text: qsTr("Change working directory")
            enabled: false
            //TODO: onTriggered:
        }
        MenuItem {
            text: qsTr("Close crossword")
            enabled: false
            //TODO: onTriggered:
        }
    }
    Menu {
        id: publish
        title: qsTr("Publish")

        MenuItem {
            text: qsTr("Publish to cloud")
            enabled: false
            //TODO: onTriggered:
        }
        MenuItem {
            text: qsTr("Options")
            enabled: false
            //TODO: onTriggered:
        }
    }
}
