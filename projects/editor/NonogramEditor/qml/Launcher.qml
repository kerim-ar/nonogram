import QtQuick 2.2
import QtQuick.Controls 1.1

Rectangle {
    id: launcher

    signal newNonogram()
    signal openNonogram()

    width: 500
    height: 340

    Label {
        x: 65
        y: 46
        text: "<a href=\"#\">" + qsTr("New nonogram") + "</a>"
        font.pixelSize: 16
        verticalAlignment: Text.AlignTop
        style: Text.Normal
        font.underline: false

        onLinkActivated: newNonogram()
    }

    Label {
        x: 65
        y: 98
        text: "<a href=\"#\">" + qsTr("Open nonogram") + "</a>"
        font.pixelSize: 16
        style: Text.Normal
        font.underline: true

        onLinkActivated: openNonogram()
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
