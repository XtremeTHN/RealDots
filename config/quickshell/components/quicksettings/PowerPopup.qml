import Quickshell

import QtQuick.Controls as Controls
import QtQuick.Layouts
import QtQuick

import "root:/components"
import "root:/services"
import "root:/"

PopupWindow {
    id: pop_menu

    required property var anchorItem

    anchor.item: anchorItem
    anchor.rect.y: anchorItem.y + 35
    implicitWidth: 140
    implicitHeight: content.implicitHeight
    color: "transparent"

    Controls.Control {
        id: content
        
        anchors.fill: parent
        padding: 5
        background: Rectangle {
            color: Colors.surface_container
            radius: 12
        }

        contentItem: ColumnLayout {
            PopupButton {
                iconName: "restart_alt"
                label: "Reboot"

                onClicked: {
                    Login.reboot()
                }
            }

            PopupButton {
                iconName: "bedtime"
                label: "Suspend"

                onClicked: {
                    Login.suspend()
                }
            }

            PopupButton {
                iconName: "logout"
                label: "Log out"

                onClicked: {
                    Login.logOut()
                }
            }
        }
    }
}