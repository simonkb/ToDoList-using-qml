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
    function saveTask(index, task) {
        listView.model.set(index, task)
    }

    ListView {
        id: listView
        width: parent.width * 0.9
        height: parent.height - header1.height - 100
        clip: true
        anchors {
            top: header1.bottom
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
        model: ListModel {
                ListElement { task: "djflaskfjs"; details: "dsdfsaf"; time: "faskflasj"; selected: false}
            }
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
                    selectedCount += !selected ? 1 : 0
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
                        Qt.createComponent("TaskPage.qml").createObject(root, { taskObject : { "task": task, "details": details, "time": time, "index": index }, saveTaskFunction: saveTask })

                    }
                }
            }
        }
    }
    Column {
        visible: listView.model.count === 0
        anchors {verticalCenter: parent.verticalCenter; centerIn: parent; verticalCenterOffset: -40 }
        spacing: 20
        Text {
            id: empty
            text: qsTr("<i><h3>No tasks for today.</h3></i>")
        }
        CustomButton {
            text: qsTr("<b>Add New</b>")
            anchors.horizontalCenter: parent.horizontalCenter
            textColor: "white"
            backgroundVisible: true
            backgroundColor: "green"
            onClicked: {
                Qt.createComponent("TaskPage.qml").createObject(root, { addTaskFunction : addTask })
            }
        }

    }
    function deletAllSelectedItems() {
        for (let i=0; i<listView.model.count;) {
            if(listView.model.get(i).selected) {
                listView.model.remove(i)
                selectedCount--;
            } else {
                i++
            }
        }
    }
    Rectangle{
        id: header1
        anchors {
            top: parent.top;
            topMargin: 20 * parent.height/480;
            horizontalCenter: parent.horizontalCenter;
        }
        radius: 5
        border.color: 'lightgray'
        color:  selectedCount > 0 ? "lightgray" : "white"
        border.width: 2
        width: parent.width * 0.9
        height: 60

        Text {
            id: title
            text: qsTr( selectedCount > 0 ? "Selected : " + selectedCount : "To Do List")
            font.pixelSize: 28
            font.bold: true
            padding: 10
        }
        CustomButton {
            text: qsTr(selectedCount > 0 ? "Delete" : "<b>New</b>")
            textColor: selectedCount > 0 ? "red": "black"
            anchors {
                right: parent.right
                rightMargin: 10
                verticalCenter: parent.verticalCenter
            }
            onClicked: {
                if (selectedCount > 0){
                    deletAllSelectedItems()
                } else {
                    Qt.createComponent("TaskPage.qml").createObject(root, { addTaskFunction : addTask })
                }
            }
        }
    }
}
