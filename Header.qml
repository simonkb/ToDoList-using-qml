import QtQuick

Rectangle{
    id: header
    anchors.horizontalCenter: parent.horizontalCenter
    anchors {
        top: parent.top
        topMargin: 20 * parent.height/480
    }
    radius: 5
    border.color: 'lightgray'
    border.width: 2
    width: parent.width * 0.9
    height: title.height + 5

    Text {
        id: title
        text: qsTr("To Do List")
        font.pixelSize: 28 * header.width/600
        font.bold: true
        padding: 10
    }

    Text {
        id: button
        anchors {
            right: parent.right
            rightMargin: 10 * header.width/600
        }
        padding: 10
        text: qsTr("+")
        font.pixelSize: Math.max(28 * header.width/600, 18)
        MouseArea{
            anchors.fill: parent
            onClicked: {
                navigateTo("TaskPage.qml")
            }

        }
    }
    Rectangle {
        anchors.fill: parent
        visible: selectedCount > 0
        color: '#D5DBDB'
        Text {
            id: selectTitle
            text: "Selected : " + selectedCount
            font.pixelSize: 28 * header.width/600
            font.bold: true
            padding: 10
        }

        Text {
            id: deleteButton
            anchors {
                right: parent.right
                rightMargin: 10
            }
            padding: 10
            color: "red"
            text: qsTr("Delete")
            font.pixelSize: Math.max(28 * header.width/600, 18)
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if ( selectedCount > 0 ){
                        deletAllSelectedItems()
                    }

                }

            }
        }

    }


}
