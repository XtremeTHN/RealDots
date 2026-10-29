import QtQuick
import Quickshell

import Quickshell.Services.Notifications
import Quickshell.Wayland

import "root:/services/notifications"

PanelWindow {
    color: "transparent"
    
    mask: Region { item: view }

    implicitHeight: 1080
    implicitWidth: 400

    WlrLayershell.namespace: "quickshell-notifications"

    anchors {
        top: true
        right: true
    }

    margins {
        top: 10
        right: 10
    }

    ListView {
        id: view

        model: ScriptModel { values: Notifs.popups }
        spacing: 8
        height: contentHeight

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        
        delegate: NotificationCard {
            required property var modelData
            width: ListView.view.width
            notification: modelData.notification
        }

        add: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 200 }
            NumberAnimation { property: "scale"; from: 0.95; to: 1; duration: 200 }
        }
        remove: Transition {
            NumberAnimation { property: "opacity"; to: 0; duration: 150 }
        }
        displaced: Transition {
            NumberAnimation { property: "y"; duration: 200; easing.type: Easing.OutCubic }
        }
    }
}