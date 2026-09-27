import QtQuick
import Quickshell
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import QtQuick.Controls
import QtQuick.Layouts

import "../"
import "../../constants"
import "../../services"
import "../statusicons"

PanelWindow {
    anchors {
        bottom: true
        right: true
    }

    margins {
        bottom: 20
        right: 10
    }


    color: "transparent"

    implicitWidth: 400
    implicitHeight: 500

    StackView {
        id: navStack
        initialItem: mixerPage
        anchors.bottom: parent.bottom

        implicitWidth: currentItem ? currentItem.implicitWidth : 0
        implicitHeight: currentItem ? currentItem.implicitHeight : 0

        Behavior on implicitHeight { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
        Behavior on implicitWidth { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
    }
    
    Component {
        id: mixerPage
        QuickMixer {}
    }

    Component {
        id: main

        Rectangle {
            color: Colors.background
            anchors.bottom: parent.bottom
            anchors.right: parent.right
        
            implicitHeight: column.height + 40
            implicitWidth: column.width

            radius: 16

            ColumnLayout {
                id: column
                anchors.margins: 18
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                spacing: 20

                implicitWidth: 400
                
                GridLayout {
                    columns: 2
                    columnSpacing: 10
                    rowSpacing: 10

                    QuickButton {
                        title: "Wifi"
                        subtitle: "Strong"
                        iconName: Utils.getLocalIcon("network-wireless-signal-good")
                    }
                    QuickButton {
                        title: "Dnd"
                        subtitle: "Off"
                        iconName: Utils.getLocalIcon("dnd-off")
                        hasMenu: false
                    }
                    QuickButton {
                        title: "Bluetooth"
                        subtitle: "On"
                        iconName: Utils.getLocalIcon("bluetooth")
                    }
                    QuickButton {
                        title: "Power"
                        subtitle: "Balanced"
                        iconName: Utils.getLocalIcon("balance")
                        checked: true
                    }
                }
                
                ColumnLayout {
                    spacing: 8

                    RowLayout {
                        Layout.alignment: Qt.AlignBottom

                        spacing: 15
                        
                        AudioIcon {
                            implicitSize: 22
                        }
                        MaterialSlider {
                            Layout.fillWidth: true
                            value: Pipewire.ready ? Pipewire.defaultAudioSink.audio.volume * 100 : 0
                            onMoved: {
                                Pipewire.defaultAudioSink.audio.volume = value / 100
                            }
                        }
                        Icon {
                            Layout.alignment: Qt.AlignVCenter
                            icon_name: getLocalIcon("right")
                            color: Colors.on_background
                            implicitSize: 26
                        }
                    }

                    RowLayout {
                        Layout.alignment: Qt.AlignBottom

                        spacing: 15
                        
                        BrightnessIcon {
                            implicitSize: 22
                        }
                        MaterialSlider {
                            Layout.fillWidth: true
                            value: Backlight.brightnessPercentage

                            onMoved: {
                                Backlight.setBrightness(value)
                            }
                        }
                        Icon {
                            Layout.alignment: Qt.AlignVCenter
                            icon_name: getLocalIcon("right")
                            color: Colors.on_background
                            implicitSize: 26
                        }
                    }
                }
                
                RowLayout {
                    Layout.alignment: Qt.AlignBottom
                    
                    Button {
                        id: circleButton

                        implicitWidth: 52
                        implicitHeight: 32

                        background: Rectangle {
                            radius: width / 2
                            color: circleButton.pressed ? Colors.primary_container : Colors.surface_container

                            Behavior on color { ColorAnimation { duration: 100 } }
                        }

                        contentItem: RowLayout {
                            spacing: 0
                            Icon {
                                Layout.leftMargin: 4
                                icon_name: getLocalIcon("system-shutdown")
                                color: circleButton.pressed ? Colors.on_primary_container : Colors.on_surface
                                implicitSize: 16
                            }

                            Icon {
                                icon_name: getLocalIcon("down")
                                color: circleButton.pressed ? Colors.on_primary_container : Colors.on_surface
                                implicitSize: 16
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                    }

                    Text {
                        function formatTime(totalSeconds) {
                            const hours = Math.floor(totalSeconds / 3600);
                            const minutes = Math.floor((totalSeconds % 3600) / 60);
                            const seconds = Math.floor(totalSeconds % 60);

                            const mm = minutes.toString().padStart(2, '0');
                            const ss = seconds.toString().padStart(2, '0');

                            return hours > 0 ? `${hours}:${mm}:${ss}` : `${minutes}:${ss}`;
                        }

                        color: Colors.on_background
                        text: `${Math.round(UPower.displayDevice.percentage * 100)}% - ${formatTime(UPower.displayDevice.timeToEmpty)} left`
                    }

                    Button {
                        id: settings

                        implicitWidth: 32
                        implicitHeight: 32

                        background: Rectangle {
                            radius: width / 2
                            color: settings.pressed ? Colors.primary_container : Colors.surface_container

                            Behavior on color { ColorAnimation { duration: 100 } }
                        }

                        contentItem: RowLayout {
                            spacing: 0
                            Icon {
                                Layout.alignment: Qt.AlignHCenter
                                icon_name: getLocalIcon("settings")
                                color: settings.pressed ? Colors.on_primary_container : Colors.on_surface
                                implicitSize: 18
                            }
                        }
                    }
                }
            }
        }
    }
}