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
            height: 60
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
                text: time
                font.pixelSize: 12
            }
            MouseArea {
                anchors.fill: parent
                pressAndHoldInterval: 300
                onPressAndHold: {
                    selectedCount += 1
                    selected = true
                }
                onClicked: {
                    if ( selectedCount > 0 ) {
                        if (selected) {
                            selectedCount --
                        } else {
                            selectedCount ++
                        }
                        selected = !selected
                    } else {
                        pageLoader.source = "TaskPage.qml"
                        pageLoader.item.taskObject = { "task": task, "details": details, "time": time, "index": index }
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
    Header {
        id: header
    }
}
