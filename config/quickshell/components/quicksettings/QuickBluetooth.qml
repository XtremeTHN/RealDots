import QtQuick.Layouts
import Quickshell.Bluetooth
import "root:/components/statusicons"
import "root:/components"

QuickButton {
    Layout.fillWidth: true
    property var adapter: Bluetooth.defaultAdapter
    property var connectedDevice: {
        if (adapter == undefined) return
        for (let x of adapter.devices.values) {
            if (x.connected) return x
        }
    }

    title: {
        if (!connectedDevice) return "Bluetooth"
        return connectedDevice.name
    }
    subtitle: adapter ? adapter.enabled ? "On" : "Off" : "Disabled"
    checked: connectedDevice != undefined

    onToggle: cond => adapter ? adapter.enabled = cond : undefined

    iconItem: BluetoothIcon {
        size: 24
    }
}