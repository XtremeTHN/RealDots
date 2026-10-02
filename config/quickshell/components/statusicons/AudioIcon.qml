import Quickshell.Services.Pipewire
import "root:/components"
import "root:/"

Icon {
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    iconName: Utils.getAudioIcon()
}