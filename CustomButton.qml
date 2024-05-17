import QtQuick
MouseArea {
    width: label.width
    height: label.height
    property alias text: label.text;
    property alias textColor: label.color
    property alias backgroundColor: background.color
    property alias backgroundVisible: background.visible

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
