import QtQuick.Controls
import Quickshell.Wayland
import QtQuick.Layouts
import Quickshell
import QtQuick

import "root:/components/statusicons"
import "root:/components"
import "root:/"

PanelWindow {
    anchors {
        right: true
        top: true
    }

    margins {
        top: 10
        right: 10
    }

    WlrLayershell.namespace: "quickshell-quicksettings"

    mask: Region {
        item: content
    }

    color: "transparent"
    implicitWidth: 355
    implicitHeight: 200

    Control {
        id: content

        background: Rectangle {
            color: Qt.alpha(Colors.background, 0.8)
            radius: 16
        }

        padding: 14
        topPadding: 16
        bottomPadding: 16

        implicitWidth: 355

        contentItem: ColumnLayout {
            spacing: 15
            GridLayout {
                Layout.fillWidth: true

                columns: 2
                columnSpacing: 5
                uniformCellWidths: true

                QuickButton {
                    Layout.fillWidth: true
                    title: "Ethernet"
                    subtitle: "Connected"
                    
                    iconItem: NetworkIcon {
                        size: 24
                    }
                }

                QuickButton {
                    Layout.fillWidth: true
                    title: "Bluetooth"
                    subtitle: "Off"

                    iconItem: Icon {
                        iconName: "bluetooth"
                        size: 24
                    }
                }
            }

            ColumnLayout {
                RowLayout {
                    spacing: 10
                    QuickAudioSlider {
                        Layout.fillWidth: true
                    }

                    CircularButton {
                        leftPadding: 6
                        rightPadding: 6
                        _flat: true

                        contentItem: Icon {
                            iconName: "keyboard_arrow_right"
                            size: 24
                        }
                    }
                }
            }

            RowLayout {
                PowerButton {}

                Rectangle {
                    Layout.fillWidth: true
                }

                CircularButton {
                    padding: 6
                    leftPadding: 8
                    rightPadding: 8

                    contentItem: Icon {
                        iconName: "settings"
                        size: 16
                    }
                }
            }
        }
    }
}