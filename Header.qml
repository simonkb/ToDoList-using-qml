import QtQuick
Rectangle{
    anchors {
        top: parent.top;
        topMargin: 20 * parent.height/480;
        horizontalCenter: parent.horizontalCenter;
    }
    radius: 5
    border.color: 'lightgray'
    border.width: 2
    width: parent.width * 0.9
    height: 60
    property alias title: title.text
    property alias button: button
    Text {
        id: title
        font.pixelSize: 28
        font.bold: true
        padding: 10
    }
    CustomButton {
        id: button
        anchors {
            right: parent.right
            rightMargin: 10
            verticalCenter: parent.verticalCenter
        }
    }
}
