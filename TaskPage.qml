import QtQuick
Item {
    property var taskObject: null
    Rectangle {
        anchors { horizontalCenter: parent.horizontalCenter; top: parent.top; topMargin: 100 }
        id: addTask
        width: parent.width * 0.9
        color: 'lightgray'
        radius: 10
        height: 300
        clip: true

        Column {
            id:column
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 16
                font.bold: true
                text: qsTr("Add Your Task!")
            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                height: parent.height * 0.1
                spacing: 10
                Text {
                    text: "Title"
                    font.pixelSize: 14
                    anchors.verticalCenter: parent.verticalCenter
                }

                Rectangle{
                    width: parent.width * 0.7
                    height: parent.height
                    radius: 5
                    TextInput{
                        id: taskInput
                        anchors.fill: parent
                        padding: 10
                        verticalAlignment: Text.AlignVCenter
                        text: taskObject  ? taskObject.task: ""
                        wrapMode: Text.Wrap
                    }
                }
            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                height: parent.height * 0.3

                spacing: 10
                Text {
                    text: "Details"
                    font.pixelSize: 14
                    anchors.verticalCenter: parent.verticalCenter
                }
                Rectangle{
                    width: parent.width * 0.7
                    height: parent.height
                    radius: 5
                    TextEdit {
                        id:taskDescription
                        anchors.fill: parent
                        padding: 10
                        text: taskObject  ? taskObject.details: ""
                        wrapMode: Text.Wrap


                    }
                }
            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                height: parent.height*0.1
                spacing: 10
                Text {
                    text: "Time"
                    font.pixelSize: 14
                    anchors.verticalCenter: parent.verticalCenter
                }
                Rectangle{
                    width: parent.width * 0.7
                    height: parent.height
                    radius: 5
                    TextInput {
                        id:timeInput
                        anchors.fill: parent
                        leftPadding: 10
                        verticalAlignment: Text.AlignVCenter
                        text: taskObject  ? taskObject.time : ""
                        wrapMode: Text.Wrap


                    }
                }
            }
            Row {
                visible: !taskObject
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10
                Rectangle {
                    id: addButton
                    width: 50
                    height: 25
                    color: "blue"
                    radius: 5

                    Text {
                        id: add
                        text: qsTr("Add")
                        color: "white"
                        anchors.centerIn: parent
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(taskInput.text !== "" && timeInput.text !=="" && taskDescription.text !== ""){
                                listModel.append({
                                                          "task": taskInput.text,
                                                          "details": taskDescription.text,
                                                          "time": timeInput.text,
                                                          "selected": false
                                                      })
                                taskInput.text = ""
                                timeInput.text = ""
                                taskDescription.text = ""
                            }
                        }
                    }
                }

                Rectangle {
                    id: doneButton
                    width: 50
                    height: 25
                    color: "green"
                    radius: 5

                    Text {
                        id: done
                        text: qsTr("Done")
                        color: "white"
                        anchors.centerIn: parent
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            taskInput.text = ""
                            timeInput.text = ""
                            navigateTo("home.qml")

                        }
                    }
                }

            }
            Row {
                visible: taskObject
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10
                Rectangle {
                    id: saveButton
                    width: save.width + 10
                    height: 25
                    color: "blue"
                    radius: 5

                    Text {
                        id: save
                        text: qsTr("Save Changes")
                        color: "white"
                        anchors.centerIn: parent
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(taskInput.text !== "" && timeInput.text !=="" && taskDescription.text !== ""){
                                listModel.set( taskObject.index, {
                                                          "task": taskInput.text,
                                                          "details": taskDescription.text,
                                                          "time": timeInput.text,
                                                          "selected": false
                                                      })
                                taskInput.text = ""
                                timeInput.text = ""
                                taskDescription.text = ""
                                navigateTo("home.qml")
                            }
                        }
                    }
                }
                Rectangle {
                    id: cancelButton
                    width: cancel.width + 10
                    height: 25
                    color: "red"
                    radius: 5

                    Text {
                        id: cancel
                        text: qsTr("Cancel")
                        color: "white"
                        anchors.centerIn: parent
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            taskInput.text = ""
                            timeInput.text = ""
                            navigateTo("home.qml")

                        }
                    }
                }

            }
        }
        NumberAnimation on height {
            id: addTaskAnimation
            from: 0;
            to: 300; duration: 300
        }

    }


}
