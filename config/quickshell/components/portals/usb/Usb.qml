import Quickshell
import Quickshell.Io
import QtQuick.Layouts
import QtQuick.Controls as Controls
import QtQuick

import "root:/components"
import "root:/"

PanelWindow {
    id: root
    property string appName
    property var currentDevices: []
    visible: false

    implicitHeight: content.implicitHeight
    implicitWidth: content.implicitWidth

    color: "transparent"

    function finished(dismissed: bool) {
        currentDevices = []
        ipc.finished(dismissed)
        root.visible = false
    }

    IpcHandler {
        id: ipc
        target: "portals-usb"

        signal finished(dismissed: bool)

        function addDevice(name: string, vendor: string, writable: bool) {
            root.currentDevices.push({
                name: name,
                vendor: vendor,
                writable: writable
            })
        }

        function prompt(appName: string) {
            usbRepeater.model = root.currentDevices
            root.appName = appName.replace("x20", " ")
            root.visible = true
        }
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
                    text: "USB"
                    color: Colors.primary
                    font.letterSpacing: 2
                }

                Label {
                    text: `Allow ${root.appName} to access USB?`
                    font.pixelSize: 18
                    font.weight: 700
                }
            }

            Label {
                text: `${root.appName} is requesting access to the following USB devices:`
                
                opacity: 0.8
            }

            ColumnLayout {
                spacing: 0

                Repeater {
                    id: usbRepeater
                    
                    delegate: UsbDevice {
                        required property var modelData

                        writable: modelData.writable
                        deviceName: modelData.name.replace("\\x20", " ")
                        deviceVendor: modelData.vendor.replace("\\x20", " ").replace("x20", " ")
                    }
                }
            }

            RowLayout {
                Rectangle {
                    Layout.fillWidth: true
                }

                Controls.Button {
                    padding: 10
                    leftPadding: 18
                    rightPadding: 18
                    background: ButtonBackground {
                        idleColor: Colors.surface_container_high
                        hoverColor: Colors.surface_container_high

                        radius: 99
                        border.width: 1
                        border.color: parent.hovered ? Colors.outline : Colors.surface_container_high
                        Behavior on border.color {
                            ColorAnimation { duration: 100 }
                        }
                    }

                    contentItem: Label {
                        text: "Deny"
                    }

                    onClicked: {
                        root.finished(true)
                    }
                }

                Controls.Button {
                    padding: 10
                    leftPadding: 18
                    rightPadding: 18
                    background: ButtonBackground {
                        idleColor: Colors.primary_container
                        hoverColor: Colors.primary_container
                        clickedColor: Colors.primary_container

                        radius: 99
                        border.width: 1
                        border.color: parent.hovered ? Colors.outline : Colors.surface_container_high
                        Behavior on border.color {
                            ColorAnimation { duration: 100 }
                        }
                    }

                    contentItem: Label {
                        text: "Allow"
                    }

                    onClicked: {
                        root.finished(false)
                    }
                }
            }
        }
    }
}