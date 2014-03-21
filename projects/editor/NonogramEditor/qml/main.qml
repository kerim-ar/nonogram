import QtQuick 2.2
import QtQuick.Controls 1.0

ApplicationWindow {
    visible: true
    width: 800
    height: 640

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
                //TODO: onTriggered:
            }
            MenuItem {
                text: qsTr("Change working directory")
                //TODO: onTriggered:
            }
            MenuItem {
                text: qsTr("Close crossword")
                //TODO: onTriggered:
            }
        }
        Menu {
            id: publish
            title: qsTr("Publish")
            MenuItem {
                text: qsTr("Publish to cloud")
                //TODO: onTriggered:
            }
        }

        Menu {
            id: test
            title: qsTr("test")
            MenuItem {
                text: qsTr("Start Window")
                onTriggered: {
                    startWindow.visible = true;
                    nonogramCreatorMaster.visible = false;
                }
            }
            MenuItem {
                text: qsTr("Crossword Creator Maaster")
                onTriggered: {
                    startWindow.visible = false;
                    nonogramCreatorMaster.visible = true;
                }
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
            text: qsTr("New nonogram")
            style: Text.Normal
            font.underline: true
            font.pointSize: 13
        }

        Label {
            x: 65
            y: 98
            text: qsTr("Open nonogram")
            style: Text.Normal
            font.underline: true
            font.pointSize: 13
        }

        Label {
            x: 321
            y: 46
            text: qsTr("Recently used")
            style: Text.Normal
            font.pointSize: 13
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
        visible: false
        x: (parent.width - nonogramCreatorMaster.width) / 2
        y: (parent.height - nonogramCreatorMaster.height) / 2

        TextField {
            id: title
            x: 118
            y: 89
            width: 423
            height: 36
            font.pointSize: 13
            placeholderText: qsTr("Nonogram Title")
        }

        Label {
            x: 55
            y: 167
            text: qsTr("Horizontal")
            font.pointSize: 13
        }

        Label {
            x: 55
            y: 96
            text: qsTr("Title")
            font.pointSize: 13
        }

        Label {
            x: 186
            y: 27
            text: qsTr("Nonogram creator master")
            font.bold: true
            font.pointSize: 15
        }

        TextField {
            id: horizontal
            x: 139
            y: 160
            width: 95
            height: 36
            font.pointSize: 13
            placeholderText: qsTr("")
        }

        Label {
            x: 240
            y: 167
            text: qsTr("cells")
            font.pointSize: 13
        }

        Label {
            id: verticalLabel
            x: 346
            y: 167
            text: qsTr("Vertical")
            font.pointSize: 13
        }

        TextField {
            id: vertical
            x: 407
            y: 159
            width: 95
            height: 36
            font.pointSize: 13
            placeholderText: qsTr("")
        }

        Label {
            x: 508
            y: 166
            text: qsTr("cells")
            font.pointSize: 13
        }

        Label {
            x: 55
            y: 240
            text: qsTr("Comment")
            font.pointSize: 13
        }

        TextArea {
            id: comment
            x: 132
            y: 239
            width: 409
            height: 101
            readOnly: false
            highlightOnFocus: true
            font.pointSize: 13
        }
    }

    Rectangle {
        id: crosswordView
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        visible: false

        Rectangle {
            id: rectangle2
            x: 150
            y: 150
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle3
            x: 190
            y: 150
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle4
            x: 230
            y: 150
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle5
            x: 270
            y: 150
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle6
            x: 310
            y: 150
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle7
            x: 350
            y: 150
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle8
            x: 390
            y: 150
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle9
            x: 430
            y: 150
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle10
            x: 470
            y: 150
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle11
            x: 510
            y: 150
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle12
            x: 550
            y: 150
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle13
            x: 590
            y: 150
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle14
            x: 630
            y: 150
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle15
            x: 150
            y: 191
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle16
            x: 190
            y: 191
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle17
            x: 230
            y: 191
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle18
            x: 270
            y: 191
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle19
            x: 310
            y: 191
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle20
            x: 350
            y: 191
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle21
            x: 390
            y: 191
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle22
            x: 430
            y: 191
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle23
            x: 470
            y: 191
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle24
            x: 510
            y: 191
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle25
            x: 550
            y: 191
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle26
            x: 590
            y: 191
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle27
            x: 630
            y: 191
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle28
            x: 150
            y: 230
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle29
            x: 190
            y: 230
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle30
            x: 230
            y: 230
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle31
            x: 270
            y: 230
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle32
            x: 310
            y: 230
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle33
            x: 350
            y: 230
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle34
            x: 390
            y: 230
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle35
            x: 430
            y: 230
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle36
            x: 470
            y: 230
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle37
            x: 510
            y: 230
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle38
            x: 550
            y: 230
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle39
            x: 590
            y: 230
            width: 40
            height: 40
            color: "#e0dcdc"
        }

        Rectangle {
            id: rectangle40
            x: 630
            y: 230
            width: 40
            height: 40
            color: "#e0dcdc"
        }
    }
}
