pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick

import "root:/"
import "root:/components"
import "root:/components/statusicons"

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 45
    color: Qt.alpha(Colors.background, 0.8)

    BackgroundEffect.blurRegion: Region { item: content }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    RowLayout {
        id: content
        anchors.fill: parent

        RowLayout {
            Layout.alignment: Qt.AlignLeft
            Layout.leftMargin: 10
            spacing: 2

            BarContainer {
                padding: 8
                
                isFirst: true

                contentItem: Workspaces {}
            }

            BarContainer {
                padding: 7

                isLast: true
                
                contentItem: ActiveWindow {}
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignRight
            Layout.rightMargin: 10
            spacing: 2

            Music {
                id: music
            }

            BarContainer {
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
                radius: 4
                padding: 8

                contentItem: Label {
                    text: Qt.formatDateTime(clock.date, "MMM dd")
                }
            }

            Button {
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
                }
            }
        }
    }
}