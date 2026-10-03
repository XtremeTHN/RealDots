pragma Singleton

import Quickshell
import Quickshell.Networking
import Quickshell.Services.Pipewire

Singleton {
    readonly property var wifiDevice: Networking.devices.values.find(item => item.type == DeviceType.Wifi)
    readonly property var wiredDevice: Networking.devices.values.find(item => item.type == DeviceType.Wired)

    function getActiveNetwork() {
        for (let x of wifiDevice.networks.values) {
            if (x.connected) return x;
        }
    }

    function getAudioIcon() {
        if (!Pipewire.ready) return "volume_mute"

        let sink = Pipewire.defaultAudioSink
        let audio = sink.audio

        if (!sink.ready) return "volume_off"

        if (sink == undefined || audio == undefined) {
            return "volume_mute"
        }

        let vol = audio.volume
        if (vol === 0) return "volume_mute"
        if (vol < 0.6) return "volume_down"
        return "volume_up"
    }

    function toTitleCase(text) {
        return String(text ?? "").toLowerCase().replace(/\b\w/g, character => character.toUpperCase())
    }

    function getLocalIcon(icon_name) {
        return Quickshell.shellDir + "/icons/" + icon_name + ".svg"
    }

    function joinPath(...parts) {
        if (parts.length === 0) return ""

        let result = ""

        for (const part of parts) {
            if (part === "") continue

            if (part.startsWith("/")) {
                result = part
            } else if (result === "" || result.endsWith("/")) {
                result += part
            } else {
                result += "/" + part
            }
        }


        return result
    }
}