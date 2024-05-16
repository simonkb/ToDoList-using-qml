import QtQuick
Item {
    property var taskObject: null
    anchors.fill: parent
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
            anchors.fill: parent
            anchors.margins: 10
            spacing: 20
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 16
                font.bold: true
                text: qsTr( !taskObject ? "Add Your Task" : "Edit Your Task" )
            }
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.9
                height: taskInput.height
                radius: 5
                TextInput {
                    id: taskInput
                    padding: 10
                    width: parent.width
                    verticalAlignment: Text.AlignVCenter
                    text: taskObject  ? taskObject.task: ""
                    wrapMode: Text.Wrap
                    font.pixelSize: 16
                    font.bold: true
                    PlaceHolder {
                    }
                }
            }
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.9
                height: Math.max(taskDescription.height, 100)
                radius: 5
                TextEdit {
                    id:taskDescription
                    padding: 10
                    width: parent.width
                    text: taskObject  ? taskObject.details: ""
                    wrapMode: Text.Wrap
                    PlaceHolder {
                        text: "Enter task details"
                    }
                }
            }

            Rectangle {
                id: time
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.9
                height: taskInput.height
                radius: 5
                TextInput {
                    id:timeInput
                    padding: 10
                    width: parent.width
                    verticalAlignment: Text.AlignVCenter
                    text: taskObject  ? taskObject.time : ""
                    wrapMode: Text.Wrap
                    PlaceHolder {
                        text: "Enter time"
                    }
                }
            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10
                Rectangle {
                    id: saveButton
                    width: save.width
                    height: save.height
                    color: "blue"
                    radius: 5
                    Text {
                        id: save
                        text: qsTr( !taskObject ? "Add": "Save changes")
                        color: "white"
                        anchors.centerIn: parent
                        padding: 10
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (!taskObject) {
                                if(taskInput.text !== "" && timeInput.text !=="" && taskDescription.text !== ""){
                                    listModel.append({ task: taskInput.text, details: taskDescription.text, time: timeInput.text, selected: false })
                                }
                            } else {
                                if(taskInput.text !== "" && timeInput.text !=="" && taskDescription.text !== ""){
                                    listModel.set(taskObject.index, {
                                                      task: taskInput.text,
                                                      details: taskDescription.text,
                                                      time: timeInput.text,
                                                  })
                                    navigateTo("home.qml")
                                }
                            }
                            taskInput.text = ""
                            timeInput.text = ""
                            taskDescription.text = ""
                        }
                    }
                }

                Rectangle {
                    id: doneButton
                    width: done.width
                    height: done.height
                    color: !taskObject ? "green" : "red"
                    radius: 5

                    Text {
                        id: done
                        text: qsTr( !taskObject ? "Done" : "Cancel")
                        color: "white"
                        anchors.centerIn: parent
                        padding: 10
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            taskInput.text = ""
                            taskDescription.text = ""
                            timeInput.text = ""
                            navigateTo("home.qml")

                        }
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

    Header {
        id: header
    }
    component PlaceHolder : Text {
        verticalAlignment: Text.AlignVCenter
        text: "Enter task title"
        visible: parent.text === "" && !parent.activeFocus
        color: 'gray'
        padding: 10
    }
}
