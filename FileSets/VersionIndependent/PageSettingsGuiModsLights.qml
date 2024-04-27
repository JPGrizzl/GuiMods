/////// new menu for all Gui Mods Power Gauges

import QtQuick 1.1
import "utils.js" as Utils
import com.victron.velib 1.0

MbPage {
	id: root
	title: qsTr("Gui Mods Lights Settings")
    property string bindPrefixGuiMods: "com.victronenergy.settings/Settings/GuiMods"

	model: VisualItemModel
    {
        MbEditBox
        {
            description: qsTr ("Controller 1 IP Address")
            maximumLength: 15
            item.bind: Utils.path (bindPrefixGuiMods, "/LightsController/1/IpAddress")
            matchString: "0123456789."
            overwriteMode: false
            writeAccessLevel: User.AccessUser
        }

        MbEditBox
        {
            description: qsTr ("Controller 2 IP Address")
            maximumLength: 15
            item.bind: Utils.path (bindPrefixGuiMods, "/LightsController/2/IpAddress")
            matchString: "0123456789."
            overwriteMode: false
            writeAccessLevel: User.AccessUser
        }
    }
}
