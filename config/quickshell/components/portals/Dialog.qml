import Quickshell
import Quickshell.Io
import QtQuick.Layouts
import QtQuick.Controls as Controls
import QtQuick

import "root:/components"
import "root:/"

PanelWindow {
    id: root
    property string category
    property string title
    property string subtitle
    property string body

    property IpcHandler ipc
    property var extraWidget

    default property alias content: buttonRow.children

    visible: false

    implicitHeight: content.implicitHeight
    implicitWidth: content.implicitWidth

    color: "transparent"

    function finished(dismissed: bool) {
        ipc.finished(dismissed)
        root.visible = false
    }
    
    Controls.Control {
        id: content
        padding: 28
        background: Rectangle {
            color: Colors.surface_container_high
            radius: 28
        }

        contentItem: ColumnLayout {
            spacing: 10

            Column {
                Label {
                    text: root.category
                    color: Colors.primary
                    font.letterSpacing: 2
                }

                Label {
                    text: root.title
                    font.pixelSize: 18
                    font.weight: 700
                }

                Label {
                    text: root.subtitle
                    font.pixelSize: 16
                    font.weight: 550
                }
            }

            Label {
                text: root.body
                
                opacity: 0.8
            }

            Item {
                id: extraItem

                Layout.fillWidth: true
                implicitWidth: root.extraWidget ? root.extraWidget.implicitWidth : 0
                implicitHeight: root.extraWidget ? root.extraWidget.implicitHeight : 0
                data: [root.extraWidget]
            }

            Binding {
                target: root.extraWidget
                property: "width"
                value: extraItem.width
                when: root.extraWidget !== null && root.extraWidget !== undefined
            }

            // ColumnLayout {
            //     spacing: 0

            //     Repeater {
            //         id: usbRepeater
                    
            //         delegate: UsbDevice {
            //             required property var modelData

            //             writable: modelData.writable
            //             deviceName: modelData.name.replace("\\x20", " ")
            //             deviceVendor: modelData.vendor.replace("\\x20", " ").replace("x20", " ")
            //         }
            //     }
            // }

            RowLayout {
                id: buttonRow

                // Controls.Button {
                //     padding: 10
                //     leftPadding: 18
                //     rightPadding: 18
                //     background: ButtonBackground {
                //         idleColor: Colors.surface_container_high
                //         hoverColor: Colors.surface_container_high

                //         radius: 99
                //         border.width: 1
                //         border.color: parent.hovered ? Colors.outline : Colors.surface_container_high
                //         Behavior on border.color {
                //             ColorAnimation { duration: 100 }
                //         }
                //     }

                //     contentItem: Label {
                //         text: "Deny"
                //     }

                //     onClicked: {
                //         root.finished(true)
                //     }
                // }

                // Controls.Button {
                //     padding: 10
                //     leftPadding: 18
                //     rightPadding: 18
                //     background: ButtonBackground {
                //         idleColor: Colors.primary_container
                //         hoverColor: Colors.primary_container
                //         clickedColor: Colors.primary_container

                //         radius: 99
                //         border.width: 1
                //         border.color: parent.hovered ? Colors.outline : Colors.surface_container_high
                //         Behavior on border.color {
                //             ColorAnimation { duration: 100 }
                //         }
                //     }

                //     contentItem: Label {
                //         text: "Allow"
                //     }

                //     onClicked: {
                //         root.finished(false)
                //     }
                // }
            }
        }
    }
}