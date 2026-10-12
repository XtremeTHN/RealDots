import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Controls as Controls
import QtQuick

import "root:/components"
import "root:/"

PanelWindow {
    id: root
    color: "transparent"
    visible: false

    implicitHeight: content.implicitHeight
    implicitWidth: content.implicitWidth

    exclusionMode: ExclusionMode.Ignore

    property string imageUri

    IpcHandler {
        id: ipc
        target: "portals-wallpaper"

        property bool showing: root.visible
        signal finished(args: string)

        function showPreview(imageUri: string, setOn: string): string {
            if (showing) return "There is another dialog running"

            root.imageUri = imageUri            
            root.visible = true
            showing = true
        }

        function setWallpaper(imageUri: string, setOn: string) {
            root.imageUri = imageUri
            matugen.running = true
        }
    }

    Process {
        id: matugen
        command: ["matugen", "image", root.imageUri.split("://")[1], "--prefer", "lightness"]
    }

    function finished(dismissed: bool) {
        ipc.finished(dismissed)
        root.visible = false
        ipc.showing = false
    }

    Controls.Control {
        id: content

        padding: 32
        bottomPadding: 20
        background: Rectangle {
            color: Colors.surface_container_high
            radius: 28
        }

        Controls.ButtonGroup {
            id: group
            buttons: set_buttons.children
        }

        contentItem: ColumnLayout {
            spacing: 16
            Column {
                Label {
                    text: "PREVIEW"
                    color: Colors.primary
                    font.letterSpacing: 2
                }
                Label {
                    text: "Wallpaper"
                    font.pixelSize: 16
                }
            }

            ClippingRectangle {
                radius: 16
                Layout.preferredWidth: 600
                Layout.preferredHeight: 360

                border.width: 6
                border.color: Colors.outline

                Image {
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: root.imageUri
                }

                Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: 20

                    color: Colors.background
                }
            }

            ColumnLayout {
                Label {
                    text: "Set on:"
                    opacity: 0.8
                }

                RowLayout {
                    id: set_buttons

                    Controls.RadioButton {
                        id: background_btt
                        property string name: "background";

                        Layout.fillWidth: true
                        indicator: null
                        padding: 10
                        background: Rectangle {
                            topLeftRadius: 16
                            bottomLeftRadius: 16
                            border.width: 1
                            border.color: Colors.outline_variant

                            Behavior on color {
                                ColorAnimation { duration: 200 }
                            }

                            color: background_btt.checked ? Colors.primary_container : background_btt.hovered ? Colors.surface_container : Colors.surface_container_high
                        }

                        contentItem: Label {
                            text: "Background"
                            horizontalAlignment: Text.AlignHCenter
                            color: background_btt.checked ? Colors.on_primary_container : Colors.on_surface
                        }
                    }

                    Controls.RadioButton {
                        id: lock
                        property string name: "lockscreen";

                        Layout.fillWidth: true
                        padding: 10
                        indicator: null
                        background: Rectangle {
                            topRightRadius: 16
                            bottomRightRadius: 16
                            border.width: 1
                            border.color: Colors.outline_variant

                            Behavior on color {
                                ColorAnimation { duration: 200 }
                            }

                            color: lock.checked ? Colors.primary_container : lock.hovered ? Colors.surface_container : Colors.surface_container_high
                        }

                        contentItem: Label {
                            text: "Lockscreen"
                            horizontalAlignment: Text.AlignHCenter
                            color: lock.checked ? Colors.on_primary_container : Colors.on_surface
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.leftMargin: -content.leftPadding
                Layout.rightMargin: -content.rightPadding
                Layout.preferredHeight: 1
                color: Colors.outline_variant
            }

            RowLayout {
                Rectangle {
                    Layout.fillWidth: true
                }
                Controls.Button {
                    padding: 14
                    leftPadding: 18
                    rightPadding: 18
                    background: ButtonBackground {
                        radius: 99
                        idleColor: Colors.surface_container_high
                        border.color: parent.hovered ? Colors.outline_variant : idleColor

                        Behavior on border.color {
                            ColorAnimation { duration: 100 }
                        }
                    }

                    contentItem: Label {
                        text: "Cancel"
                        color: Colors.primary
                    }

                    onClicked: {
                        root.finished(true)
                    }
                }

                Controls.Button {
                    id: set_wall_btt
                    padding: 14
                    leftPadding: 18
                    rightPadding: 18
                    background: Rectangle {
                        radius: 99
                        color: Colors.primary_container
                        border.color: set_wall_btt.hovered ? Colors.outline : Colors.primary_container
                    }

                    contentItem: Label {
                        text: "Set wallpaper"
                        color: Colors.on_primary_container
                    }

                    onClicked: {
                        root.finished(false)
                        matugen.running = true
                    }
                }
            }
        }
    }
}