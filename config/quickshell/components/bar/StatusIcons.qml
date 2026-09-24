import QtQuick
import Quickshell
import Quickshell.Networking
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower

import "../"
import "../../constants"
import "../../services"

Row {
    spacing: 5
    anchors.centerIn: parent

    Icon {
        implicitSize: 16
        color: Colors.on_background

        function getIcon(strength) {
            if (strength < 0.20) return getLocalIcon("network-wireless-signal-none")
            if (strength < 0.40) return getLocalIcon("network-wireless-signal-bad")
            if (strength < 0.60) return getLocalIcon("network-wireless-signal-ok")
            return getLocalIcon("network-wireless-signal-good")
        }

        icon_name: {
            let wifi = Networking.devices.values.find(item => item.type == DeviceType.Wifi)
            let wired = Networking.devices.values.find(item => item.type == DeviceType.Wired)

            if (wired != undefined && wired.network != undefined) {
                let active_network = wired.network

                switch (active_network.state) {
                    case ConnectionState.Connecting | ConnectionState.Disconnecting:
                        return "network-wired-acquiring-symbolic"
                    case ConnectionState.Connected:
                        return "network-wired-symbolic"
                    case ConnectionState.Disconnected:
                        return "network-wired-disconnected-symbolic"
                    default:
                        return "network-wired-no-route-symbolic"
                }
            }

            if (wifi != undefined) {
                let active_network = undefined;
                for (let x of wifi.networks.values) {
                    if (x.connected) active_network = x;
                }

                if (active_network == undefined) {
                    return getLocalIcon("network-wireless-offline")
                }

                return getIcon(active_network.signalStrength)
            }

            if (wifi == undefined || wired == undefined) {
                return "network-wireless-disabled"
            }
        }
    }

    Icon {
        implicitSize: 16
        color: Colors.on_background

        PwObjectTracker {
            objects: [Pipewire.defaultAudioSink]
        }

        icon_name: {
            if (!Pipewire.ready) return getLocalIcon("audio-volume-muted");

            let sink = Pipewire.defaultAudioSink
            let audio = sink.audio

            if (!sink.ready) return getLocalIcon("audio-volume-off");

            if (sink == undefined || audio == undefined) {
                return getLocalIcon("audio-volume-muted")
            }

            let vol = audio.volume
            if (vol === 0) return getLocalIcon("audio-volume-muted")
            if (vol < 0.6) return getLocalIcon("audio-volume-low")
            return getLocalIcon("audio-volume-high")
        }
    }

    Icon {
        id: battery_icon
        anchors.verticalCenter: parent.verticalCenter
        implicitSize: 18
        color: Colors.on_background

        icon_name: {
            let percent = UPower.displayDevice.percentage * 100

            if (percent <= 5) return getLocalIcon("battery-0")
            if (percent <= 10) return getLocalIcon("battery-1")
            if (percent <= 20) return getLocalIcon("battery-2")
            if (percent <= 30) return getLocalIcon("battery-3")
            if (percent <= 50) return getLocalIcon("battery-4")
            if (percent <= 75) return getLocalIcon("battery-5")
            if (percent <= 90) return getLocalIcon('battery-6')
            if (percent <= 100) return getLocalIcon("battery-full")

            console.warn(percent)
        }
    }

    Text {
        color: Colors.on_background
        text: `${Math.round(UPower.displayDevice.percentage * 100)}%`
    }

    Scope {
        Temperature {
            id: gpuTemp
            deviceName: "amdgpu"
        }

        Temperature {
            id: cpuTemp
            deviceName: "k10temp"
        }
    }

    Icon {
        id: icon_
        color: Colors.on_background
        implicitSize: 16
        icon_name: {
            if (gpuTemp.temperature > 70000 || cpuTemp.temperature > 70000) return getLocalIcon("heat")
            if (gpuTemp.temperature < 30000 || cpuTemp.temperature < 30000) return getLocalIcon("cold")
            return getLocalIcon("thermostat")
        }
    }

    Repeater {
        model: [gpuTemp, cpuTemp]
        
        delegate: Text {
            required property var modelData
            color: Colors.on_background
            text: `${Math.round(modelData.temperature / 1000)} °C`
        }
    }
}