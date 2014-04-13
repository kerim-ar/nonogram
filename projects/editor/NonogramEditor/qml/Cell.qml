import QtQuick 2.2

Rectangle {
    property bool isBlack: false

    id: root
    color: "#d7dddf"
    anchors.fill: parent
    Rectangle {
        color: "#ffffff"
        x: 1
        y: 1
        width: parent.width - 2
        height: parent.height - 2
        Rectangle {
            color: root.isBlack ? "#000000" : "#ffffff"
            x: 1
            y: 1
            width: parent.width - 2
            height: parent.height - 2
        }
    }
}
