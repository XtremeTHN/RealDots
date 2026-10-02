import QtQuick
import QtQuick.Controls

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
    }
}