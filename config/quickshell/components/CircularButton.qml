import QtQuick.Controls
import QtQuick

import "root:/components"
import "root:/"

Button {
    id: btt
    implicitWidth: Math.max(implicitContentWidth, implicitContentHeight) + padding * 2
    implicitHeight: implicitWidth
    property alias _flat: background.flat
    property alias hoverColor: background.hoverColor
    property alias idleColor: background.idleColor
    background: ButtonBackground {
        id: background
        btt: btt

        radius: 99
    }
}