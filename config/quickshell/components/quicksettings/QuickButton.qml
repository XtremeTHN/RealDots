import QtQuick.Controls
import QtQuick.Layouts
import QtQuick

import "../"
import "../../constants"

Button {
    id: root
    implicitHeight: layout.height + 30
    property string title
    property string subtitle
    property string iconName
    property bool hasMenu: true

    property color textColor: Color.on_surface
    Layout.fillWidth: true

    background: Rectangle {
        Behavior on color {
            ColorAnimation {
                duration: 100
            }
        }
        color: {
            if (root.pressed || root.checked) {
                root.textColor = Colors.on_primary
                return Colors.primary
            }
            root.textColor = Colors.on_surface
            return Colors.surface_container
        }
        radius: 18
    }

    contentItem: Item {
        RowLayout {
            id: layout
            anchors.verticalCenter: parent.verticalCenter
            width: root.width
            spacing: 10

            Icon {
                Layout.alignment: Qt.AlignLeft
                Layout.leftMargin: 10
                icon_name: root.iconName
                implicitSize: 22
                color: root.textColor
            }
            
            ColumnLayout {
                spacing: 0
                Text {
                    font.pixelSize: 14
                    font.weight: 600

                    color: root.textColor
                    text: root.title
                }

                Text {
                    color: root.textColor
                    text: root.subtitle
                }
            }

            Rectangle {
                Layout.fillWidth: true
            }

            Icon {
                Layout.rightMargin: 8
                Layout.alignment: Qt.AlignRight
                icon_name: getLocalIcon("right")
                color: root.textColor
                visible: root.hasMenu
                implicitSize: 24
            }
        }
    }
}