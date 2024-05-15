import QtQuick
Item {
    ListView {
        id: listView
        width: parent.width
        height: parent.height
        clip: true
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: header.bottom
            topMargin: 20
        }

        model: listModel
        delegate: Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: ListView.view.width * 0.9
            height: timeText.height + taskText.height
            color: selected ? '#2E86C1': "lightgreen"
            border.color: Qt.lighter(color)
            radius: 5
            Text{
                id: taskText
                padding: 10
                text: task
                font.pixelSize: 14
                font.bold: true
            }
            Text {
                id: timeText
                padding: 10
                anchors.top: taskText.bottom
                anchors.topMargin: 5
                text:  time
                font.pixelSize: 12
            }
            MouseArea {
                anchors.fill: parent
                pressAndHoldInterval: 500
                onPressAndHold: {
                    selectedCount += 1
                    selected = true
                }
                onClicked: {
                    if ( selectedCount > 0 ) {
                        if (selected) {
                            selectedCount--
                        } else {
                            selectedCount ++
                        }
                        selected = !selected
                    } else {
                        pageLoader.source = "TaskPage.qml"
                        pageLoader.item.taskObject = { "task": task, "details": details, "time": time, "index": listView.currentIndex }

                    }

                }
            }
        }

    }

    function deletAllSelectedItems() {
        for (let i=0; i<listModel.count;) {
            if(listModel.get(i).selected) {
                listModel.remove(i)
                selectedCount--;
            } else {
                i++
            }
        }
    }

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

}
