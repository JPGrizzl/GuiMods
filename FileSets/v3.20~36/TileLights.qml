// New for GuiMods to display and control relays on separate overview page

import QtQuick 1.1
import "utils.js" as Utils

Tile {
	id: root

    Component.onCompleted: updateFunction ()

    color: "#d9d9d9"

	values: Item
    {
        Column
        {
            width: root.width
            height: contentHeight + 4
            x: 3
            spacing: 4
            visible: true
            anchors
            {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
            }
            Text
            {
                font.pixelSize: 12
                font.bold: true
                color: "black"
                anchors
                {
                    horizontalCenter: parent.horizontalCenter
                }
                horizontalAlignment: Text.AlignHCenter
                text: "Light " + (lightNumber + 1)
            }
            Button
            {
                id: onButton
                baseColor: "green"
                pressedColor: "#979797"
                height: 40
                width: parent.width - 6
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "http://172.24.24.91/white/" + (lightNumber + 3));
                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    xhr.send("turn=on");
                }
                content: TileText
                {
                    text: "I"; font.bold: true;
                    color: "black"
                }
            }
            Slider
            {
                id: lightSlider
                orientation: Qt.Vertical
                height: root.height - 80
                width: 20
                minimumValue: 0
                maximumValue: 100
                onValueChanged: {
                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "http://172.24.24.91/white/" + (lightNumber + 3));
                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    xhr.send("turn=on&brightness=" + Math.round(value));
                }
            }
            Button
            {
                id: offButton
                baseColor: "red"
                pressedColor: "#979797"
                height: 40
                width: parent.width - 6
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "http://172.24.24.91/white/" + (lightNumber + 3));
                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    xhr.send("turn=off");
                }
                content: TileText
                {
                    text: "O"; font.bold: true;
                    color: "black"
                }
            }
        }
	}

    function updateFunction ()
    {
        onButton.visible = true 
        offButton.visible = true
        lightSlider.visible = true 
    }
}
