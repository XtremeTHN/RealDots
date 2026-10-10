import QtQuick.Controls
import QtQuick

import Quickshell.Wayland

import "root:/components"
import "root:/services"
import "root:/"

Rectangle {
    id: root
    color: "transparent"
    
    property Toplevel selectedWindow

    function refresh() {
        Wc.refreshToplevels()
    }

    Repeater {
        model: Wc.toplevels.filter(t => t.workspace ? t.workspace.id == Wc.focusedWorkspace.id : false)
        
        delegate: Rectangle {
            id: rectangle

            required property var modelData
            property var window: modelData.lastIpcObject
            property bool ready: window.at != null
            property color enterColor: Qt.alpha(Colors.primary, 0.1)
            property color exitColor: Qt.alpha(Colors.primary, 0.3)

            radius: 8

            x: ready ? window.at[0] : 0
            y: ready ? window.at[1] : 0

            width: ready ? window.size[0] : 0
            height: ready ? window.size[1] : 0
            
            color: exitColor

            Behavior on color {
                ColorAnimation { duration: 200 }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true

                onClicked: {
                    root.selectedWindow = rectangle.modelData.wayland
                }

                onEntered: {
                    rectangle.color = rectangle.enterColor
                }

                onExited: {
                    rectangle.color = rectangle.exitColor
                }
            }

            Rectangle {
                id: check
                anchors.centerIn: parent

                opacity: root.selectedWindow == rectangle.modelData.wayland ? 1 : 0

                Behavior on opacity {
                    NumberAnimation { duration: 200; }
                }

                width: 42
                height: 42
                radius: 99

                color: Colors.background

                Icon {
                    anchors.centerIn: check
                    iconName: "check"
                    size: 16
                }
            }
        }
    }
}