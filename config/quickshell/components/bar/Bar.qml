pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick

import "root:/"
import "root:/services"
import "root:/components"
import "root:/components/statusicons"

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    WlrLayershell.namespace: "quickshell-bar"
    WlrLayershell.layer: WlrLayer.Bottom

    implicitHeight: 45
    color: "transparent"

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Control {
        anchors.fill: parent
        background: Rectangle {
            color: Qt.alpha(Colors.background, Settings.s.bar.opacity)
        }

        contentItem: RowLayout {
            id: content

            RowLayout {
                Layout.alignment: Qt.AlignLeft
                Layout.leftMargin: 10
                Layout.maximumHeight: 30
                spacing: 2

                BarContainer {
                    Layout.fillHeight: true
                    padding: 8
                    
                    isFirst: true

                    contentItem: Workspaces {}
                }

                BarContainer {
                    Layout.fillHeight: true

                    padding: 6

                    isLast: true
                    
                    contentItem: RowLayout {
                        ActiveWindow {
                            Layout.maximumWidth: 400
                        }
                    }
                }
            }

            RowLayout {
                Layout.maximumHeight: 30
                Layout.alignment: Qt.AlignRight
                Layout.rightMargin: 10
                spacing: 2

                Music {
                    Layout.fillHeight: true
                    id: music
                }

                BarContainer {
                    Layout.fillHeight: true
                    padding: 7

                    topLeftRadius: music.visible ? 4 : 16 
                    bottomLeftRadius: music.visible ? 4 : 16
                    topRightRadius: 4
                    bottomRightRadius: 4

                    contentItem: TempIcons {}

                    Behavior on topLeftRadius {
                        NumberAnimation { duration: 100 }
                    }

                    Behavior on bottomLeftRadius {
                        NumberAnimation { duration: 100 }
                    }
                }

                BarContainer {
                    Layout.fillHeight: true
                    radius: 4
                    padding: 7

                    contentItem: Label {
                        text: Qt.formatDateTime(clock.date, "MMM dd")
                    }
                }

                Button {
                    Layout.fillHeight: true
                    id: quicksettings_btt
                    padding: 6

                    background: ButtonBackground {
                        btt: quicksettings_btt
                        
                        topLeftRadius: 4
                        bottomLeftRadius: 4
                        topRightRadius: 16
                        bottomRightRadius: 16
                    }

                    contentItem: RowLayout {
                        Layout.fillHeight: true
                        spacing: 5
                        
                        Label {
                            text: Qt.formatDateTime(clock.date, "hh:mm AP")
                        }
                        
                        NetworkIcon {
                            size: 16
                        }

                        AudioIcon {
                            size: 16
                        }

                        BatteryIcon {
                            size: 16
                        }
                    }
                }
            }
        }
    }
}