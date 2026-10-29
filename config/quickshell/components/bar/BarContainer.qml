import QtQuick
import QtQuick.Controls

import "root:/"

Control {
    id: root

    property color color: Colors.surface_container
    property alias radius: back.radius;

    property alias topRightRadius: back.topRightRadius
    property alias topLeftRadius: back.topLeftRadius
    property alias bottomLeftRadius: back.bottomLeftRadius
    property alias bottomRightRadius: back.bottomRightRadius

    property bool isFirst
    property bool isLast

    property int leftRadius: isFirst ? 16 : 4
    property int rightRadius: isLast ? 16 : 4

    topLeftRadius: leftRadius
    bottomLeftRadius: leftRadius
    topRightRadius: rightRadius
    bottomRightRadius: rightRadius

    Behavior on topLeftRadius {
        NumberAnimation { duration: 100 }
    }

    Behavior on bottomLeftRadius {
        NumberAnimation { duration: 100 }
    }

    Behavior on topRightRadius {
        NumberAnimation { duration: 100 }
    }

    Behavior on bottomRightRadius {
        NumberAnimation { duration: 100 }
    }

    background: Rectangle {
        id: back
        color: root.color
    }
}