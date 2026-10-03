import Quickshell.Services.UPower
import "root:/components"

Icon {
    visible: UPower.displayDevice.isLaptopBattery
    iconName: {
        let percentage = UPower.displayDevice.percentage

        if (UPower.displayDevice.state == UPowerDeviceState.Charging) return "battery_android_bolt"

        if (percentage < 0.05) return "battery_android_0"
        if (percentage < 0.10) return "battery_android_1"
        if (percentage < 0.25) return "battery_android_2"
        if (percentage < 0.35) return "battery_android_3"
        if (percentage < 0.50) return "battery_android_4"
        if (percentage < 0.85) return "battery_android_5"
        return "battery_android_full"
    }
}