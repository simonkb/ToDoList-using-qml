import QtQuick
MouseArea {
    width: label.width
    height: label.height
    property alias label: label;
    property alias background: background
    Rectangle {
        id:background
        anchors {fill: parent; centerIn: parent }
        radius: 5
    }
    Text {
        anchors.centerIn: parent
        id: label
        padding: 10
    }
}
