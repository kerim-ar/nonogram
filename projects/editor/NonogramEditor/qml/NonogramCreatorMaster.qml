import QtQuick 2.2
import QtQuick.Controls 1.1

Rectangle {
    id: nonogramCreatorMaster

    signal createNonogram(int horizontalCellsCount, int verticalCellsCount)

    anchors.fill: parent

    CustomMessageBox {
        id: messageBox
    }

    TextField {
        id: name
        y: 10
        width: 380
        height: 25
        font.pixelSize: 12
        focus: true
        anchors.horizontalCenter: parent.horizontalCenter;
        placeholderText: qsTr("Nonogram name")
        validator: RegExpValidator {regExp: /\w{,40}/}
    }

    Label {
        text: qsTr("Name:")
        font.pixelSize: 12
        anchors.right: name.left
        anchors.rightMargin: 10
        anchors.verticalCenter: name.verticalCenter
    }

    TextField {
        id: width
        x: name.x
        width: 100
        height: 25
        font.pixelSize: 12
        anchors.top: name.bottom
        anchors.topMargin: 5
        validator: IntValidator {bottom: 1; top: 32}
    }

    Label {
        text: qsTr("Width:")
        font.pixelSize: 12
        anchors.right: width.left
        anchors.rightMargin: 10
        anchors.verticalCenter: width.verticalCenter
    }

    TextField {
        id: height
        x: width.x + width.width + 80
        width: 100
        height: 25
        font.pixelSize: 12
        anchors.top: name.bottom
        anchors.topMargin: 5
        validator: IntValidator {bottom: 1; top: 32}
    }

    Label {
        text: qsTr("Height:")
        font.pixelSize: 12
        anchors.right: height.left
        anchors.rightMargin: 10
        anchors.verticalCenter: height.verticalCenter
    }

    TextArea {
        id: comment
        x: width.x
        width: 380
        height: 100
        anchors.top: width.bottom
        anchors.topMargin: 5
        font.pixelSize: 12
        readOnly: false
        highlightOnFocus: true
    }

    Label {
        y: comment.y
        text: qsTr("Comment:")
        font.pixelSize: 12
        anchors.right: comment.left
        anchors.rightMargin: 10
    }

    CustomButton {
        id: cancelButton
        x: (parent.width / 2) - cancelButton.width - 21
        text: qsTr("Cancel")
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 10
    }

    CustomButton {
        id: createButton
        x: (parent.width / 2) + 21
        text: qsTr("Create")
        gradientBoundaryColor: "#BADCB0"
        gradientCentralColor: "#A8D191"
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 10

        onClicked: {
            if (name.text.length == 0 || width.text.length == 0 || height.text.length == 0) {
                messageBox.messageTitle = qsTr("Error")
                messageBox.messageText = qsTr("Please fill all fields")
                messageBox.show()
            } else {
                createNonogram(width.text, height.text)
            }
        }
    }
}
