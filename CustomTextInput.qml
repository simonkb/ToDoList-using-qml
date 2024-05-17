import QtQuick
Rectangle {
    anchors.horizontalCenter: parent.horizontalCenter
    width: parent.width * 0.9
    height: input.visible ? input.height :  Math.max(input2.height, 100)
    radius: 5
    property alias text:  input.text
    property alias text2: input2.text
    property string type;
    TextInput {
        id: input
        visible: type !=="details"
        padding: 10
        width: parent.width
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.Wrap
        font.pixelSize: 16
        font.bold: type === "title"
        PlaceHolder {
            text: `Enter task ${type}`
        }
    }
    TextEdit {
        id:input2
        visible: type ==="details"
        padding: 10
        width: parent.width
        wrapMode: Text.Wrap
        PlaceHolder {
            text: "Enter task details"
        }
    }

    component PlaceHolder : Text {
        verticalAlignment: Text.AlignVCenter
        text: "Enter task title"
        visible: parent.text === "" && !parent.activeFocus
        color: 'gray'
        padding: 10
    }
}


