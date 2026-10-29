import QtQuick
import Quickshell.Services.Notifications

QtObject {
    id: entry

    required property Notification notification
    property bool popup: true
    property date time: new Date()

    property Timer timer: Timer {
        interval: (entry.notification.expireTimeout > 0 ? entry.notification.expireTimeout : 5) * 1000
        running: entry.popup && entry.notification.urgency !== NotificationUrgency.Critical
        onTriggered: entry.popup = false
    }
}