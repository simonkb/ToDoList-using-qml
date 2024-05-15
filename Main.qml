import QtQuick
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("To Do List")
    property int selectedCount: 0
    property int numberOfTasks: 0
    Loader {
        id: pageLoader
        anchors.fill: parent
    }
    Component.onCompleted: {
        pageLoader.source = "home.qml"
    }
    function navigateTo (pageUrl){
        pageLoader.source = pageUrl
    }
    ListModel {
        id: listModel
        ListElement {task:"Task title"; details: "This is an example task."; time: "10 : 00 pm"; selected: false}
        ListElement {task:"Task title"; details: "This is an example task."; time: "11 : 00 pm"; selected: false}

    }

}
