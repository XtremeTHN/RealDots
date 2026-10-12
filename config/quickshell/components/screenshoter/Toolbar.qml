import QtQuick.Controls
import QtQuick.Layouts
import QtQuick

import "root:/components"
import "root:/services"
import "root:/"

Control {
    id: root

    property bool doneEnabled: false

    enum Mode {
        Fullscreen = 4,
        Free = 0,
        Window = 1
    }

    property int mode

    signal done()
    signal close()

    function setTarget(target: string) {
        switch (target) {
            case "screen":
                fullscreenBtt.enabled = true
                windowBtt.enabled = false
                freeBtt.enabled = false
            case "area":
                fullscreenBtt.enabled = false
                windowBtt.enabled = false
                freeBtt.enabled = true
            case "window" || "activeWindow":
                fullscreenBtt.enabled = false
                windowBtt.enabled = true
                freeBtt.enabled = false
        }
    }

    function restart() {
        fullscreenBtt.enabled = true
        windowBtt.enabled = true
        freeBtt.enabled = true
    }

    x: (parent.width / 2) - implicitWidth / 2
    y: parent.height / 16

    padding: 14

    background: Rectangle {
        color: Colors.surface_container
        border.color: Colors.outline_variant
        radius: 32
    }

    contentItem: RowLayout {
        spacing: 20

        ButtonGroup {
            buttons: operation.children
        }

        ButtonGroup {
            buttons: selection_type.children
            onClicked: button => {
                root.mode = button.mode
            }
        }

        Control {
            background: Rectangle {
                color: Colors.surface_container_high
                radius: 16
            }

            contentItem: RowLayout {
                id: operation
                spacing: 0

                CircularRadioButton {
                    id: screenshot_op

                    idleColor: Colors.surface_container_high
                    indicator: null
                    iconName: "photo_camera"
                }

                CircularRadioButton {
                    id: video_op
                    indicator: null
                    idleColor: Colors.surface_container_high

                    iconName: "videocam"
                }
            }
        }

        Rectangle {
            width: 1
            height: 20

            color: Colors.outline_variant
        }

        RowLayout {
            id: selection_type
            spacing: 8

            CircularRadioButton {
                id: fullscreenBtt
                property int mode: Toolbar.Mode.Fullscreen
                indicator: null
                iconName: "fullscreen"
            }

            CircularRadioButton {
                id: freeBtt
                property int mode: Toolbar.Mode.Free
                indicator: null
                iconName: "highlight_alt"
            }

            CircularRadioButton {
                id: windowBtt
                property int mode: Toolbar.Mode.Window
                enabled: Wc.isHyprland
                indicator: null
                iconName: "select_window_2"
            }
        }

        Rectangle {
            width: 1
            height: 20
            color: Colors.outline_variant
        }

        RowLayout {
            CircularButton {
                onClicked: root.close()
                contentItem: Icon {
                    iconName: "close"
                    size: 20
                }
            }

            CircularButton {
                id: check_btt
                enabled: fullscreenBtt.checked ? true : root.doneEnabled
                hoverColor: check_btt.enabled ? Colors.surface_container_high : Colors.surface_container

                onClicked: root.done()

                contentItem: Icon {
                    iconName: "check"
                    color: check_btt.enabled ? Colors.on_background : Colors.outline_variant
                    size: 20
                }
            }
        }
    }
}