import QtQuick.Layouts
import QtQuick

import Quickshell
import Quickshell.Io
import Quickshell.Networking

import "root:/components/statusicons"
import "root:/"

QuickButton {
    Layout.fillWidth: true
    readonly property var activeNetwork: Utils.getActiveNetwork()

    Process {
        id: nmcli
    }

    title: {
        if (activeNetwork == undefined) return "Network"
        return activeNetwork.name
    }

    subtitle: {
        if (activeNetwork == undefined) return "Disconnected"
        if (activeNetwork.deviceType == DeviceType.Wired) return "Connected"
        let strength = activeNetwork.signalStrength
        if (strength < 0.20) return "Low"
        if (strength < 0.60) return "Medium"
        return "Strong"
    }

    checked: activeNetwork != undefined

    onToggle: cond => {
        nmcli.exec(["nmcli", "n", cond ? "on" : "off"])
    }
    
    iconItem: NetworkIcon {
        size: 24
    }
}