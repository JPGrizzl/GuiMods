/////// new menu for all Gui Mods Power Gauges

import QtQuick 1.1
import "utils.js" as Utils
import com.victron.velib 1.0

MbPage {
	id: root
	title: qsTr("Gui Mods Server Monitoring")
    property string bindPrefixGuiMods: "com.victronenergy.settings/Settings/MonitorServer"

	model: VisualItemModel
    {
        MbEditBox
        {
            description: qsTr ("Server IP Address")
            maximumLength: 15
            item.bind: Utils.path (bindPrefixGuiMods, "/ServerIp")
            matchString: "0123456789."
            overwriteMode: false
            writeAccessLevel: User.AccessUser
        }

        MbEditBox
        {
            description: qsTr ("Server Port")
            maximumLength: 6
            item.bind: Utils.path (bindPrefixGuiMods, "/ServerPort")
            matchString: "0123456789"
            overwriteMode: false
            writeAccessLevel: User.AccessUser
        }
    }
}
