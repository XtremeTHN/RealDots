import Quickshell.Bluetooth
import "root:/components"

Icon {
    iconName: (Bluetooth.defaultAdapter != undefined) ? Bluetooth.defaultAdapter.enabled ? "bluetooth" : "bluetooth_disabled" : "bluetooth_disabled"
}