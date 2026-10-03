pragma Singleton

import DBus 1.0
import Quickshell
import Quickshell.Io

import "root:/"

Singleton {
    id: root

    property string classPath: "/sys/class/"
    property string deviceName: "amdgpu_bl1"
    property string subsystem: "backlight"
    property string backlightDevicePath: Utils.joinPath(classPath, subsystem, deviceName)
    property int maxBrightness
    property int currBrightness

    property int brightnessPercentage: {
        ((currBrightness * 100) / maxBrightness)
    }

    DBus {
        id: session
        service: "org.freedesktop.login1"
        path: "/org/freedesktop/login1/session/auto"
        iface: "org.freedesktop.login1.Session"
        connection: SystemBus
    }

    FileView {
        path: Utils.joinPath(root.backlightDevicePath, "brightness")
        watchChanges: true

        onFileChanged: reload()
        onLoaded: {
            root.currBrightness = parseInt(text())
        }
    }

    FileView {
        path: Utils.joinPath(root.backlightDevicePath, "max_brightness")
        onLoaded: {
            root.maxBrightness = parseInt(text())
        }
    }

    function setBrightness(value) {
        session.setBrightness(subsystem, deviceName, (value * maxBrightness) / 100)
    }
}