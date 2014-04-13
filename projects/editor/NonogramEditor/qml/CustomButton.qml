import QtQuick 2.2
import QtQuick.Controls 1.1

Rectangle {
    id: container

    property string text: "Button"
    property string gradientBoundaryColor: "#E1DFDD"
    property string gradientCentralColor: "#D3D0CD"

    signal clicked()

    width: 198
    height: 30
    border  { width: 1; color: "#ADA9A4" }
    smooth: true

    gradient: Gradient {
        GradientStop { position: 0.0; color: gradientBoundaryColor }
        GradientStop { position: 0.5; color: gradientCentralColor }
        GradientStop { position: 1.0; color: gradientBoundaryColor }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: container.clicked();
    }

    Text {
        id: buttonLabel
        anchors.centerIn: container
        text: container.text
        font.pixelSize: 14
    }
}
