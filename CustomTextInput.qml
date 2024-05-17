import QtQuick
Rectangle {
    anchors.horizontalCenter: parent.horizontalCenter
    width: parent.width * 0.9
    height: type === 'details'? Math.max(input.height, 100): input.height
    radius: 5
    property alias text:  input.text
    property string type;
    TextEdit {
        id: input
        padding: 10
        width: parent.width
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.Wrap
        font.pixelSize: 16
        font.bold: type === "title"
        onTextChanged: {
            let max = type === "details" ? 300 : 51
            if(text.length > max){
                text = text.substring(0, max)
                parent.border.color = "red"
            }else if (text.length == 0){
                parent.border.color = "red"
            }else{
                parent.border.color = "white"
            }
        }
        PlaceHolder {
            text: `Enter task ${type}`
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


