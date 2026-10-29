import QtQuick
import QtQuick.Controls

import "root:/services"
import "root:/"

Control {
    id: root
    property bool shown: false

    opacity: shown ? 1 : 0
    scale: shown ? 1 : 0.85

    Behavior on scale {
        SpringAnimation {
            spring: root.shown ? 4.5 : 6
            damping: root.shown ? 0.22 : 0.5
            epsilon: 0.001
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: root.shown ? 160 : 120
            easing.type: Easing.OutCubic
        }
    }

    background: Rectangle {
        color: Qt.alpha(Colors.background, Settings.s.quickSettings.opacity)
        radius: 16
    }

    padding: 14
    topPadding: 16
    bottomPadding: 16
}