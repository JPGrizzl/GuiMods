// New for GuiMods to show relay info on a separate Overview page

import QtQuick 1.1
import com.victron.velib 1.0
import "utils.js" as Utils

OverviewPage {
    id: root

    property VBusItem serverState: VBusItem { bind: "com.victronenergy.settings/Settings/MonitorServer/ServerState" }

    // Synchronise name text scroll start
    Timer {
        id: marqueeTimer
        interval: 5000
        repeat: true
        running: root.active
    }

    title: qsTr("Node Red Interface")
    clip: true

    Component.onCompleted: updateNodeRed()

    // background
    Rectangle {
        anchors.fill: parent
        color: "#b3b3b3"
    }

    Text {
        font.pixelSize: 14
        font.bold: true
        color: "black"
        anchors {
            top: parent.top
            topMargin: 7
            horizontalCenter: parent.horizontalCenter
        }
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("Servers")
    }

    Rectangle {
        width: root.width
        height: 60
        color: serverState.value === 1 ? 'green' : 'red'
        anchors {
            top: parent.top
            topMargin: 7
            horizontalCenter: parent.horizontalCenter
        }

        Text {
            anchors.centerIn: parent
            text: serverState.value === 1 ? 'Proxmox Server Running' : 'Proxmox Server Offline'
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            color: 'black'
        }

        Button {
            id: proxmoxOnButton
            text: "SWITCH ON"
            width: 120
            height: 50
            anchors {
            left: parent.left
            top: parent.top
            topMargin: 5
            }
            onClicked: {
            var request = new XMLHttpRequest();
            request.open("GET", "http://127.0.0.1:1880/proxmox/start");
            request.send();
            }

            Text {
                anchors.centerIn: parent
                text: "SWITCH ON"
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                color: 'black'
            }
        }

        Button {
            id: proxmoxOffButton
            text: "SHUTDOWN"
            width: 120
            height: 50
            anchors {
                right: parent.right
                top: parent.top
                topMargin: 5
            }
            onClicked: {
                var request = new XMLHttpRequest();
                request.open("GET", "http://127.0.0.1:1880/proxmox/stop");
                request.send();
            }

            Text {
                anchors.centerIn: parent
                text: "SHUTDOWN"
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                color: "black"
            }
        }
    }



    function updateNodeRed() {

    }
}