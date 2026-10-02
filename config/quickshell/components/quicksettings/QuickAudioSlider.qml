import Quickshell.Services.Pipewire

import "root:/components"
import "root:/"

MaterialSlider {
    iconName: Utils.getAudioIcon()
    value: Pipewire.ready ? Pipewire.defaultAudioSink.audio.volume * 100 : 0
    onMoved: {
        Pipewire.defaultAudioSink.audio.volume = value / 100
    }
}