import QtQuick.Controls as Controls
import QtQuick.Layouts
import QtQuick

import "root:/services/notifications"
import "root:/components"
import "root:/"

Controls.Button {
    id: root

    property int size: 18
    Layout.fillHeight: true

    visible: opacity > 0
    opacity: Notifs.entries.length > 0 ? 1 : 0

    background: ButtonBackground {}

    Behavior on opacity {
        NumberAnimation { duration: 100 }
    }

    contentItem: Item {
        implicitWidth: root.size + 5
        implicitHeight: root.size

        Rectangle {
            anchors.centerIn: parent
            width: root.size
            height: root.size
            radius: width / 2
            color: Colors.primary

            Label {
                anchors.centerIn: parent
                text: `${Notifs.entries.length > 0 ? Notifs.entries.length : 1}`
                color: Colors.on_primary
            }
        }
    }
}