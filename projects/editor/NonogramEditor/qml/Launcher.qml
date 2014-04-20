import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Nonogram.RecentNonogramsModel 1.0

Rectangle {
    id: launcher

    signal newNonogram()
    signal openNonogram()
    signal connectToCloud()
    signal createNonogram(string filePath)

    color: "#ffffff"
    anchors.fill: parent;

    function setRecentNonograms(recentNonograms) {
        recentNonogramsModel.setRecentNonograms(recentNonograms);
    }

    RecentNonogramsModel {
        id: recentNonogramsModel
    }

    Label {
        y: 30
        text: qsTr("Welcome to Nonogram Editor!")
        anchors.horizontalCenter: parent.horizontalCenter;
        font.pixelSize: 24
        style: Text.Normal
    }

    Label {
        y: 99
        text: qsTr("Recent nonograms")
        font.bold: true
        font.pixelSize: 20
        style: Text.Normal
        anchors.left: newNonogramButton.right
        anchors.leftMargin: 21
    }

    CustomButton {
        id: newNonogramButton

        x: 41
        y: 101
        text: qsTr("New Nonogram")

        Component.onCompleted: {
            newNonogramButton.clicked.connect(function() {
                newNonogram()
            })
        }
    }

    CustomButton {
        id: openNonogramButton

        x: 41
        y: 140
        text: qsTr("Open Nonogram")
        anchors.top: newNonogramButton.bottom
        anchors.topMargin: 20

        Component.onCompleted: {
            openNonogramButton.clicked.connect(function() {
                openNonogram()
            })
        }
    }

    CustomButton {
        id: connectToCloudButton

        x: 41
        y: 198
        text: qsTr("Connect to Cloud")
        anchors.top: openNonogramButton.bottom
        anchors.topMargin: 20

        Component.onCompleted: {
            connectToCloudButton.clicked.connect(function() {
                connectToCloud()
            })
        }
    }

    Component {
        id: recentNonogramsDelegate

        Rectangle {
            height: 30
            width: parent.width

            Text {
                x: 5
                text: fileName
                font.pixelSize: 14
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    parent.color = "#cccccc"
                }

                onExited: {
                    parent.color = "#ffffff"
                }

                onClicked: createNonogram(filePath)
            }
        }
    }

    ScrollView {
        x: 260
        y: 129
        width: 480
        height: 150
        ListView {
            id: recentNonogramsListView

            anchors.fill: parent
            model: recentNonogramsModel
            delegate: recentNonogramsDelegate
        }
    }
}
