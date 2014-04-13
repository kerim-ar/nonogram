import QtQuick 2.2
import QtQuick.Window 2.0
import QtQuick.Controls 1.1

Window {
    id: messageBox

    property alias messageTitle: messageBox.title
    property alias messageText: messageText.text

    maximumWidth: 300
    minimumWidth: 300
    maximumHeight: 100
    minimumHeight: 100
    modality: Qt.WindowModal
    flags: Qt.Dialog

    Label {
        id: messageText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 18
        anchors.fill: parent
    }
}
