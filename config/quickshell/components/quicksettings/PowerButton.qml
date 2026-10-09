import QtQuick
import Quickshell
import QtQuick.Controls
import QtQuick.Layouts

import "root:/components"
import "root:/"

Row {
    spacing: 2
    Button {
        id: power
        padding: 6
        background: ButtonBackground {
            btt: power

            topLeftRadius: 99
            bottomLeftRadius: 99
        }

        contentItem: Icon {
            size: 16
            iconName: "mode_off_on"
        }
    }

    Button {
        id: power_menu
        padding: 6

        background: ButtonBackground {
            btt: power_menu
            topRightRadius: 99
            bottomRightRadius: 99
        }

        contentItem: Icon {
            size: 16
            iconName: "keyboard_arrow_down"
        }

        PowerPopup {
            id: pop_menu
            anchorItem: power_menu
        }

        onClicked: {
            pop_menu.visible = !pop_menu.visible
        }
    }
}