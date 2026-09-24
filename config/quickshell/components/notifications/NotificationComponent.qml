import Quickshell
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick

import "../../services"
import "../../constants"
import "../"

Container {
    id: root
    // center: false

    padding: 20
    required property var notif;
    // property string iconName: Utils.getLocalIcon("alert")

    Row {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        NotificationIcon {
            anchors.verticalCenter: parent.verticalCenter
            iconPath: {
                let parts = root.notif.image.replace("image://", "").split("/")
                if (root.notif.image == "") return "file://" + Utils.getLocalIcon("alert")
                if (parts.length == 2) return "file://" + Utils.getLocalIcon(parts[1])
                return root.notif.image
            }
            implicitSize: 48
            padding: 10
        }

        ColumnLayout {
            RowLayout {
                spacing: 40
                Text {
                    text: root.notif.summary
                    color: Colors.on_background
                    font.bold: true
                    font.pixelSize: 16
                    
                }

                Item {
                    Layout.fillWidth: true
                }

                Button {
                    icon.source: Utils.getLocalIcon("close")
                    icon.color: Colors.on_background
                    background: Rectangle {
                        color: Colors.surface_container_highest
                        radius: 16
                    }
                }
            }

            Text {
                color: Colors.on_background
                text: root.notif.body
                wrapMode: Text.WrapAnywhere
                Layout.maximumWidth: 500
            }
        }
    }
}