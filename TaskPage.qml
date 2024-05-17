import QtQuick
Item {
    property var taskObject: null
    id:taskPage
    height: parent.height
    width: parent.width
    property var callback : () => { }
    MouseArea {anchors.fill: parent}
    Rectangle {
        anchors { fill: parent; margins: 20; topMargin: 100 }
        color: 'lightgreen'
        radius: 10
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
                text: taskObject  ? taskObject.details: ""
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
                    background {color: "blue"; visible: true}
                    label { text: !taskObject ? "Add": "Save changes"; color: "white"}
                    onClicked: {
                        if(taskInput.text !== "" && timeInput.text !=="" && taskDescription.text !== ""){
                            if(taskObject){
                                callback({ task: taskInput.text, details: taskDescription.text, time: timeInput.text, selected: false }, taskObject.index)
                            }else {
                                callback({ task: taskInput.text, details: taskDescription.text, time: timeInput.text, selected: false})
                            }
                            taskPage.destroy()
                        }
                    }
                }
                CustomButton {
                    label { text: !taskObject ? "Done" : "Cancel"; color: "white" }
                    background {color: !taskObject ? "green" : "red"; visible: true}
                    onClicked: taskPage.destroy()
                }
            }

        }
    }
    Header {
        title: !taskObject ? "Add Your Task" : "Edit Your Task"
        button {
            label {text:"Back"; color: "blue"}
            onClicked: {
                taskPage.destroy()
            }
        }
    }
}



