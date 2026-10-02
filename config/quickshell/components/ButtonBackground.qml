import QtQuick

import "root:/"

Rectangle {
    required property var btt
    property bool flat: false

    color: {
        if (btt.pressed) return Colors.surface_container_highest
        if (btt.hovered) return Colors.surface_container_high
        return flat ? "transparent" : Colors.surface_container
        // btt.pressed ? Colors.surface_container_highest : Colors.surface_container
    }

    Behavior on color {
        ColorAnimation { duration: 100 }
    }
}