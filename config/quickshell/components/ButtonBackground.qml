import QtQuick

import "root:/"

Rectangle {
    property var btt: parent
    property bool flat: false
    property color idleColor: flat ? "transparent" : Colors.surface_container
    property color hoverColor: Colors.surface_container_high
    property color clickedColor: Colors.surface_container_highest

    color: {
        if (btt.pressed) return clickedColor
        if (btt.hovered) return hoverColor
        return idleColor
        // btt.pressed ? Colors.surface_container_highest : Colors.surface_container
    }

    Behavior on color {
        ColorAnimation { duration: 100 }
    }
}