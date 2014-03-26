import QtQuick 2.2
import QtQuick.Controls 1.0
import QtQuick.Dialogs 1.1

ApplicationWindow {
    visible: true
    width: 800
    height: 640

    /* ------------------------------------------ */

    MessageDialog {
        id: emptyFieldsMessage
        title: qsTr("Error")
        text: qsTr("Please fill all fields")
        icon: StandardIcon.Warning
        visible: false
    }

    FileDialog {
        id: fileDialog
        title: qsTr("Please choose a file")
        nameFilters: [ "Text files (*.txt)", "All files (*)" ]
        visible: false
        //TODO
    }

    /* ------------------------------------------ */

    menuBar: MenuBar {
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

    Rectangle {
        id: startWindow
        visible: true
        width: 500
        height: 340
        x: (parent.width - startWindow.width) / 2;
        y: (parent.height - startWindow.height) / 2;

        Label {
            x: 65
            y: 46
            text: "<a href=\"#\">" + qsTr("New nonogram") + "</a>"
            font.pixelSize: 16
            verticalAlignment: Text.AlignTop
            style: Text.Normal
            font.underline: false
            onLinkActivated: {
                startWindow.visible = false
                nonogramCreatorMaster.visible = true
            }
        }

        Label {
            x: 65
            y: 98
            text: "<a href=\"#\">" + qsTr("Open nonogram") + "</a>"
            font.pixelSize: 16
            style: Text.Normal
            font.underline: true
            onLinkActivated: {
                fileDialog.visible = true
            }
        }

        Label {
            x: 321
            y: 46
            text: qsTr("Recently used")
            font.pixelSize: 16
            style: Text.Normal
        }

        Rectangle {
            id: rectangle1
            x: 248
            y: 25
            width: 1
            height: 290
            color: "#000000"
            radius: 0
        }
    }

    Rectangle {
        id: nonogramCreatorMaster
        width: 600
        height: 440
        radius: 2
        visible: false
        x: (parent.width - nonogramCreatorMaster.width) / 2
        y: (parent.height - nonogramCreatorMaster.height) / 2

        TextField {
            id: title
            x: 118
            y: 89
            width: 423
            height: 36
            font.pixelSize: 16
            placeholderText: qsTr("Nonogram Title")
            validator: RegExpValidator {regExp: /\w{,40}/}
        }

        Label {
            x: 55
            y: 168
            text: qsTr("Horizontal")
            font.pixelSize: 16
        }

        Label {
            x: 55
            y: 98
            text: qsTr("Title")
            font.pixelSize: 16
        }

        Label {
            x: 157
            y: 30
            text: qsTr("Nonogram creator master")
            font.pixelSize: 22
            font.bold: true
        }

        TextField {
            id: horizontal
            x: 139
            y: 160
            width: 95
            height: 36
            font.pixelSize: 16
            placeholderText: qsTr("")
            validator: IntValidator {bottom: 1; top: 32}
        }

        Label {
            x: 240
            y: 168
            text: qsTr("cells")
            font.pixelSize: 16
        }

        Label {
            id: verticalLabel
            x: 350
            y: 168
            text: qsTr("Vertical")
            font.pixelSize: 16
        }

        TextField {
            id: vertical
            x: 407
            y: 160
            width: 95
            height: 36
            font.pixelSize: 16
            placeholderText: qsTr("")
            validator: IntValidator {bottom: 1; top: 32}
        }

        Label {
            x: 511
            y: 168
            text: qsTr("cells")
            font.pixelSize: 16
        }

        Label {
            id: label1
            x: 55
            y: 239
            text: qsTr("Comment")
            font.pixelSize: 16
        }

        TextArea {
            id: comment
            x: 132
            y: 239
            width: 409
            height: 101
            anchors.right: title.right
            anchors.top: label1.top
            font.pixelSize: 14
            readOnly: false
            highlightOnFocus: true
        }

        Button {
            id: createNonogramBtn
            x: 439
            y: 386
            width: 102
            height: 25
            text: qsTr("Create nonogram")
            enabled: true
            onClicked: {
                if (title.text.length == 0 || vertical.text.length == 0 || horizontal.text.length == 0) {
                    emptyFieldsMessage.visible = true;
                } else {
                    nonogramCreatorMaster.visible = false
                    nonogramView.visible = true
                    //TODO: clear text fields
                }
            }
        }
    }

    Rectangle {
        id: nonogramView
        x: 0
        y: 1
        width: parent.width
        height: parent.height
        visible: false
    }
}
