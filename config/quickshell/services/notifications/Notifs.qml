pragma Singleton
import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root

    property var entries: []
    readonly property var popups: entries.filter(e => e.popup)

    NotificationServer {
        keepOnReload: true
        actionsSupported: true
        bodyMarkupSupported: true
        imageSupported: true

        onNotification: n => {
            n.tracked = true

            const entry = entryComp.createObject(root, { notification: n })
            let index = root.entries.indexOf(entry)
            if (index != -1 ) {
                let existingEntry = root.entries[index]
                existingEntry.popup = true
                existingEntry.timer.reset()
            } 
            
            root.entries = [entry, ...root.entries]

            n.closed.connect(() => {
                root.entries = root.entries.filter(e => e !== entry)
                entry.destroy()
            })
        }
    }

    Component { id: entryComp; NotifEntry {} }

    function clearAll() {
        for (const e of [...entries]) e.notification.dismiss()
    }
}