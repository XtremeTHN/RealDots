import Quickshell.Networking
import "root:/components"
import "root:/"

Icon {
    function getIcon(strength) {
        if (strength < 0.20) return "signal_wifi_0_bar"
        if (strength < 0.40) return "network_wifi_1_bar"
        if (strength < 0.60) return "network_wifi_3_bar"
        if (strength < 0.80) return "network_wifi"
        return "signal_wifi_4_bar"
    }

    iconName: {
        let wifi = Networking.devices.values.find(item => item.type == DeviceType.Wifi)
        let wired = Networking.devices.values.find(item => item.type == DeviceType.Wired)

        if (wired != undefined && wired.network != undefined) {
            let active_network = wired.network

            switch (active_network.state) {
                case ConnectionState.Connecting | ConnectionState.Disconnecting:
                    return "signal_wifi_0_bar"
                case ConnectionState.Connected:
                    return "settings_ethernet"
                case ConnectionState.Disconnected:
                    return "signal_wifi_bad"
                default:
                    return "signal_wifi_off"
            }
        }

        if (wifi != undefined) {
            let active_network = Utils.getActiveNetwork()

            if (active_network == undefined) {
                return "signal_wifi_bad"
            }

            return getIcon(active_network.signalStrength)
        }

        if (wifi == undefined || wired == undefined) {
            return "signal_wifi_off"
        }
    }
}