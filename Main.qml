import QtQuick
Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("To Do List")
    property int selectedCount: 0
    function addTask(task) {
        listView.model.append(task)
    }
    function saveTask(task, index) {
        listView.model.set(index, task)
    }
    ListView {
        id: listView
        anchors { fill: parent; margins: 20; topMargin: 100 }
        clip: true
        model: ListModel {}
        delegate: Rectangle {
            width: ListView.view.width
            height: taskText.height
            color: selected ? '#2E86C1': "lightgreen"
            border.color: Qt.lighter(color)
            radius: 5
            Text{
                id: taskText
                padding: 10
                text: `<b>${task}</b> <br> <p>${time}</p>`
                font.pixelSize: 14
            }
            MouseArea {
                anchors.fill: parent
                pressAndHoldInterval: 300
                onPressAndHold: {
                    if(!selected) {
                        selectedCount++
                        selected = true
                    }
                }
                onClicked: {
                    if ( selectedCount > 0 ) {
                        selectedCount += selected ? -1 : 1
                        selected = !selected
                    } else {
                        Qt.createComponent("TaskPage.qml").createObject(root, { taskObject: model, callback: saveTask })
                    }
                }
            }
        }
    }
    Column {
        visible: listView.model.count === 0
        anchors { centerIn: parent; verticalCenterOffset: -40 }
        spacing: 20
        Text {
            text: "<i><h3>No tasks for today.</h3></i>"
        }
        CustomButton {
            anchors.horizontalCenter: parent.horizontalCenter
            label { text: "<b>Add New</b>"; color: "white" }
            background { visible: true; color: "green" }
            onClicked: Qt.createComponent("TaskPage.qml").createObject(root, { callback: addTask })
        }

    }
    function deleteSelectedItems() {
        for (let i=0; i<listView.model.count;) {
            if(listView.model.get(i).selected) {
                listView.model.remove(i)
                selectedCount--;
            } else {
                i++
            }
        }
    }
    Header {
        color:  selectedCount > 0 ? "lightgray" : "white"
        title: selectedCount > 0 ? "Selected : " + selectedCount : "To Do List"
        button {
            label { text: selectedCount > 0 ? "Delete" : "<b>New</b>"; color: selectedCount > 0 ? "red": "black" }
            onClicked: {
                if (selectedCount > 0)
                    deleteSelectedItems()
                else
                    Qt.createComponent("TaskPage.qml").createObject(root, { callback: addTask })
            }
        }
    }
}
