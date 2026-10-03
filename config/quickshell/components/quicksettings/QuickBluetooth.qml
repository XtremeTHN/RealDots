import QtQuick.Layouts
import Quickshell.Bluetooth
import "root:/components/statusicons"
import "root:/components"

QuickButton {
    Layout.fillWidth: true
    property var adapter: Bluetooth.defaultAdapter
    property var connectedDevice: {
        for (let x of adapter.devices.values) {
            if (x.connected) return x
        }
    }

    title: {
        if (!connectedDevice) return "Bluetooth"
        return connectedDevice.name
    }
    subtitle: adapter.enabled ? "On" : "Off"
    checked: connectedDevice != undefined

    onToggle: cond => adapter.enabled = cond

    iconItem: BluetoothIcon {
        size: 24
    }
}