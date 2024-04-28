// New for GuiMods to show relay info on a separate Overview page

import QtQuick 1.1
import com.victron.velib 1.0
import "utils.js" as Utils

OverviewPage {
    id: root

    property VBusItem serverIp: VBusItem { bind: "com.victronenergy.settings/Settings/MonitorServer/ServerIp" }
    property VBusItem serverPort: VBusItem { bind: "com.victronenergy.settings/Settings/MonitorServer/ServerPort" }
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
        height: 200
        color: serverState.value === 'up' ? 'green' : 'red'
        anchors {
            top: parent.top
            topMargin: 7
            horizontalCenter: parent.horizontalCenter
        }

        Text {
            anchors.centerIn: parent
            text: serverState.value === 'up' ? 'Proxmox Server Status: Up' : 'Proxmox Server Status: Down'
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            color: 'black'
        }

        Button {
            id: proxmoxOnButton
            text: "Proxmox Server ON"
            width: 100
            height: 100
            anchors {
            left: parent.left
            top: parent.top
            topMargin: 10
            }
            onClicked: {
            var request = new XMLHttpRequest();
            request.open("GET", "https://192.168.1.120:1881/proxmox/start");
            request.send();
            }
        }

        Button {
            id: proxmoxOffButton
            text: "Proxmox Server OFF"
            width: 100
            height: 100
            anchors {
                right: parent.right
                bottom: parent.bottom
                bottomMargin: 10
            }
            onClicked: {
                var request = new XMLHttpRequest();
                request.open("GET", "https://192.168.1.120:1881/proxmox/stop");
                request.send();
            }
        }
    }



    function updateNodeRed() {

    }
}