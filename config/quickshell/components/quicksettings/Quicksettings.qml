import QtQuick.Controls as Controls
import Quickshell.Services.UPower
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
    implicitHeight: 300

    Controls.Control {
        id: content

        background: Rectangle {
            color: Qt.alpha(Colors.background, 1)
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

                QuickNetwork {}

                QuickBluetooth {}
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

                QuickBacklightSlider {
                    Layout.fillWidth: true
                }
            }

            RowLayout {
                PowerButton {}

                Rectangle {
                    Layout.fillWidth: true
                }

                Label {
                    visible: UPower.displayDevice.isLaptopBattery
                    text: {
                        let percentage = Math.round(UPower.displayDevice.percentage * 100)
                        let battery = UPower.displayDevice
                        let charging = battery.state == UPowerDeviceState.Charging
                        let time = Utils.formatTime(charging ? battery.timeToFull : battery.timeToEmpty)
                        return `${percentage}% - ${time} ${charging ? "left to charge" : "left"}`
                    }
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
