import QtQuick
Item {
    property var taskObject: null
    id:taskPage
    height: parent.height
    width: parent.width
    property var addTaskFunction : () =>{}
    property var saveTaskFunction :  () =>{}
    Rectangle {
        anchors { horizontalCenter: parent.horizontalCenter; top: header.bottom; topMargin: 20 }
        id: addTask
        width: parent.width * 0.9
        color: 'lightgreen'
        radius: 10
        height: parent.height * 0.6
        clip: true
        Column {
            id:column
            anchors { fill: parent; margins: 10; topMargin: 50}
            spacing: 20
            CustomTextInput {
                id: taskInput
                text: taskObject  ? taskObject.task: ""
                type: "title"
            }
            CustomTextInput {
                id: taskDescription
                text2: taskObject  ? taskObject.details: ""
                type: "details"
            }
            CustomTextInput {
                id: timeInput
                text:  taskObject  ? taskObject.time : ""
                type: "time"
            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10
                CustomButton {
                    backgroundColor: "blue"
                    backgroundVisible: true
                    textColor: "white"
                    text: qsTr( !taskObject ? "Add": "Save changes")
                    onClicked: {
                        if (taskObject) {
                            if(taskInput.text !== "" && timeInput.text !=="" && taskDescription.text2 !== ""){
                                saveTask(taskObject.index, {
                                             task: taskInput.text,
                                             details: taskDescription.text2,
                                             time: timeInput.text,
                                         })
                                taskPage.destroy()


                            } else {

                            }
                        } else {
                            if(taskInput.text !== "" && timeInput.text !=="" && taskDescription.text2 !== ""){
                                addTaskFunction({ task: taskInput.text, details: taskDescription.text2, time: timeInput.text, selected: false })
                            }
                        }
                        taskInput.text = ""
                        timeInput.text = ""
                        taskDescription.text2 = ""
                    }
                }
                CustomButton {
                    textColor: "white"
                    text: qsTr( !taskObject ? "Done" : "Cancel")
                    backgroundColor: !taskObject ? "green" : "red"
                    onClicked: {
                        taskInput.text = ""
                        taskDescription.text2 = ""
                        timeInput.text = ""
                        taskPage.destroy()

                    }
                }
            }

        }

        NumberAnimation on height {
            id: addTaskAnimation
            duration: 500
            from: 0
            to: addTask.height
        }
    }

    Rectangle{
        id: header
        anchors {
            top: parent.top
            topMargin: 20 * parent.height/480
            horizontalCenter: parent.horizontalCenter
        }
        radius: 5
        border.color: 'lightgray'
        width: parent.width * 0.9
        height: 60
        border.width:2
        Text {
            id: title
            text: qsTr( !taskObject ? "Add Your Task" : "Edit Your Task" )
            font.pixelSize: 28
            font.bold: true
            padding: 10
        }
        CustomButton {
            text: qsTr("Back")
            textColor: 'blue'
            anchors {
                right: parent.right
                rightMargin: 10
                verticalCenter: parent.verticalCenter
            }
            onClicked: {
                taskPage.destroy()
            }
        }
    }

}



