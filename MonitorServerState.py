import platform
import argparse
import logging
import sys
import subprocess
import os
import time
import dbus
import requests
import json

dbusSettingsPath = "com.victronenergy.settings"
dbusSystemPath = "com.victronenergy.system"
# accommodate both Python 2 and 3
# if the Python 3 GLib import fails, import the Python 2 gobject
try:
    from gi.repository import GLib  # for Python 3
except ImportError:
    import gobject as GLib  # for Python 2

# add the path to our own packages for import
# use an established Victron service to maintain compatiblity
sys.path.insert(
    1, os.path.join("/opt/victronenergy/dbus-systemcalc-py", "ext", "velib_python")
)
from vedbus import VeDbusService
from ve_utils import wrap_dbus_value
from settingsdevice import SettingsDevice


class ServerMonitor:
    def background(self):
        try:
            response = requests.get("http://127.0.0.1:1880/proxmox/status")
            if response.status_code != 200:
                logging.error(f"Error in background method: {response.status_code}")
                self.serverState = "down"
                self.DbusSettings["monitorServerState"] = "down"
                return

            body = json.loads(response.text)

            if "success" in body:
                self.serverState = "up"
                self.DbusSettings["monitorServerState"] = "up"
            else:
                self.serverState = "down"
                self.DbusSettings["monitorServerState"] = "down"
        except Exception as e:
            logging.error(f"Error in background method: {e}")
        return

    def __init__(self):

        self.theBus = dbus.SystemBus()
        self.serverState = ""

        # create / attach local settings
        settingsList = {
            "monitorServerState": ["/Settings/MonitorServe/ServerState", 0,0,0],
        }
        self.DbusSettings = SettingsDevice(
            bus=self.theBus,
            supportedSettings=settingsList,
            timeout=10,
            eventCallback=None,
        )
        GLib.timeout_add(5000, self.background)
        return None


def main():

    from dbus.mainloop.glib import DBusGMainLoop

    # set logging level to include info level entries
    logging.basicConfig(level=logging.INFO)

    # Have a mainloop, so we can send/receive asynchronous calls to and from dbus
    DBusGMainLoop(set_as_default=True)

    installedVersion = "(no version installed)"
    versionFile = "/etc/venus/installedVersion-GuiMods"
    if os.path.exists(versionFile):
        try:
            proc = subprocess.Popen(
                ["cat", versionFile], stdout=subprocess.PIPE, stderr=subprocess.PIPE
            )
        except:
            pass
        else:
            proc.wait()
            # convert from binary to string
            stdout, stderr = proc.communicate()
            stdout = stdout.decode().strip()
            stderr = stderr.decode().strip()
            returnCode = proc.returncode
            if proc.returncode == 0:
                installedVersion = stdout

    logging.info(
        ">>>>>>>>>>>>>>>> MonitorServerState starting "
        + installedVersion
        + " <<<<<<<<<<<<<<<<"
    )

    ServerMonitor()

    mainloop = GLib.MainLoop()
    mainloop.run()


main()
