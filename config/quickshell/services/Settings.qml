pragma Singleton
import Quickshell.Io
import Quickshell

Singleton {
    property var s: settings.adapter

    FileView {
        id: settings
        path: Quickshell.shellPath("config.json")
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()
        watchChanges: true

        JsonAdapter {
            id: adapter
            property JsonObject bar: JsonObject {
                property real opacity: 1
            }

            property JsonObject quickSettings: JsonObject {
                property real opacity: 1
                property int delayBeforeShutdown: 20000
            }
        }
    }
}