import QtQuick

import "root:/services"
import "root:/"

Row {
    spacing: 4

    Repeater {
        model: {
            return Wc.workspaces.filter(o => !o.name.startsWith("special:"))
        }

        delegate: Rectangle {
            required property var modelData
            property bool isActive: Wc.focusedWorkspace != undefined && Wc.focusedWorkspace.id === modelData.id

            width: isActive ? 32 : 14
            height: 14
            radius: 7
            color: isActive ? Colors.primary : Colors.on_primary

            NumberAnimation on opacity {
                from: 0
                to: 1
                duration: 180
                easing.type: Easing.OutCubic
            }

            Behavior on width {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutCubic
                }
            }

            Behavior on color {
                ColorAnimation { duration: 150 }
            }
        }
    }
}
