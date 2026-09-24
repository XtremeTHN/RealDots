pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Widgets

import "../"
import "../../services"
import "../../constants"

AutoRectangle {
    color: iconPath.startsWith("file://") ? Colors.surface_container_highest : "transparent"
    property alias implicitSize: icon.implicitSize
    required property string iconPath

    radius: 999

    Icon {
        id: icon
        source: iconPath
        backer.layer.enabled: false
        anchors.centerIn: parent
    }
}