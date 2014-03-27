import QtQuick 2.2
import QtQuick.Controls 1.1

Rectangle {
    id: nonogramCreatorMaster

    signal createNonogram()

    width: 600
    height: 440
    radius: 2

    CustomMessageBox {
        id: messageBox
    }

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
                messageBox.messageTitle = qsTr("Error")
                messageBox.messageText = qsTr("Please fill all fields")
                messageBox.show()
            } else {
                createNonogram()
            }
        }
    }
}
