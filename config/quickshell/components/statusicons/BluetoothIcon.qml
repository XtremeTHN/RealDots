import Quickshell.Bluetooth
import "root:/components"

Icon {
    iconName: Bluetooth.defaultAdapter.enabled ? "bluetooth" : "bluetooth_disabled"
}