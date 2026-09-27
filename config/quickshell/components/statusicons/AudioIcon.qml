import Quickshell.Services.Pipewire

import "../../constants"
import "../"

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