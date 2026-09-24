pragma Singleton

import Quickshell.Io
import Quickshell
import QtQuick
import QtQml

Singleton {
    id: mango

    property string active_window_title
    property int active_workspace_index

    property string socket_dir: Quickshell.env("MANGO_INSTANCE_SIGNATURE") ?? ""

    Socket {
        id: mango_socket
        path: mango.socket_dir
        connected: true

        property bool sentWatchCommand: false
        
        onConnectionStateChanged: {
            if (sentWatchCommand) {
                return
            }

            write("watch all-monitors\n")
            sentWatchCommand = true
        }

        parser: SplitParser {
            onRead: msg => {
                let root = JSON.parse(msg)

                let monitors = root.monitors
                let primary = monitors[0]

                mango.active_window_title = primary.active_client.title

                for (let tag of primary.tags) {
                    if (!tag.is_active) continue;
                    
                    mango.active_workspace_index = tag.index
                }
            }
        }
    }
}