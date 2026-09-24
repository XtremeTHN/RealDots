pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import QtQuick
import Qt.labs.folderlistmodel 2.15

Scope {
    id: root

    property ListModel model: ListModel {}
    property string deviceName;

    property real temperature;

    FolderListModel {
        id: folderModel
        folder: "file:///sys/class/hwmon"
        showDirs: true
        showFiles: false
        showDotAndDotDot: false
        nameFilters: ["hwmon*"]

        onStatusChanged: {
            if (status !== FolderListModel.Ready) return
            for (let i=0; i<count; i++) {
                let path = get(i, "filePath")
                nameReader.createObject(root, { deviceDir: path })
            }
        }
    }

    Component {
        id: nameReader
        
        FileView {
            property string deviceDir

            path: deviceDir + "/name"

            onLoaded: {
                if (!loaded) return

                if (text().trim() == root.deviceName) {
                    tempReader.path = deviceDir + "/temp1_input"
                    poll.running = true
                }

                destroy()
            }
        }
    }

    Timer {
        id: poll

        interval: 10000 // maybe too much
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            tempReader.reload()
        }
    }

    FileView {
        id: tempReader
        onLoaded: {
            if (!loaded && text.length == 0) return

            root.temperature = parseFloat(text().trim())
        }
    }

    FileView {
        id: maxTempReader
        onLoaded: {
            if (!loaded && text.length == 0) return
            root.temperature = parseFloat(text().trim())
        }
    }
}