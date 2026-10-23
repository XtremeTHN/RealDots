import QtQuick.Controls as Controls
import QtQuick

import "root:/components"
import "root:/"

Controls.Button {
    id: root
    property string label
    property bool suggestedAction

    padding: 10
    leftPadding: 18
    rightPadding: 18
    background: ButtonBackground {
        idleColor: root.suggestedAction ? Colors.primary_container : Colors.surface_container_high
        hoverColor: root.suggestedAction ? Colors.primary_container : Colors.surface_container_high
        clickedColor: root.suggestedAction ? Colors.primary_container : Colors.surface_container_highest

        radius: 99
        border.width: 1
        border.color: parent.hovered ? Colors.outline : Colors.surface_container_high
        Behavior on border.color {
            ColorAnimation { duration: 100 }
        }
    }

    contentItem: Label {
        text: root.label
    }
}