import QtQuick.Layouts
import QtQuick.Controls as Controls
import QtQuick

import "root:/components"
import "root:/"

Controls.Control {
    id: root
    property string deviceName
    property string deviceVendor
    property bool writable
    
    Layout.fillWidth: true

    padding: 10

    background: Rectangle {
        // topLeftRadius: 16
        // topRightRadius: 16
        radius: 16
        border.color: Colors.outline_variant

        color: Colors.surface_container
    }

    contentItem: RowLayout {
        spacing: 10

        Controls.Control {
            padding: 4
            leftPadding: 6
            rightPadding: 6

            background: Rectangle {
                color: Colors.surface_container_high
                radius: 8
            }

            contentItem: Icon {
                iconName: "usb"
                size: 26
                Layout.alignment: Qt.AlignVCenter
                color: Colors.on_secondary_container
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            spacing: 0

            Label {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignLeft
                text: root.deviceName
            }

            Label {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignLeft
                text: root.deviceVendor
                opacity: 0.6
                font.pixelSize: 11
            }
        }

        Controls.Control {
            padding: 5
            leftPadding: 7
            rightPadding: 7
            background: Rectangle {
                radius: 99
                color: Colors.secondary_container
            }

            contentItem: Icon {
                size: 16
                color: Colors.on_secondary_container
                iconName: root.writable ? "edit" : "edit_off"
            }
        }
    }
}