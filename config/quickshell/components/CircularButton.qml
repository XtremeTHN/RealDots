import QtQuick.Controls
import QtQuick

import "root:/components"
import "root:/"

Button {
    id: btt
    property alias _flat: background.flat
    background: ButtonBackground {
        id: background
        btt: btt

        radius: 99
    }
}