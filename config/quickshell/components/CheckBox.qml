// credits: claude
import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts

import "root:/components"
import "root:/"

Controls.CheckBox {
    id: control

    property int boxSize: 18
    readonly property bool marked: checkState !== Qt.Unchecked

    implicitWidth: implicitContentWidth + leftPadding + rightPadding
    implicitHeight: Math.max(40, implicitContentHeight)
    spacing: 4
    leftPadding: 0
    rightPadding: 12

    indicator: Item {
        x: control.leftPadding
        y: (control.height - height) / 2
        width: 40
        height: 40

        Rectangle {
            id: box
            anchors.centerIn: parent
            width: control.boxSize
            height: control.boxSize

            radius: 3
            color: control.marked ? Colors.primary : "transparent"
            border.width: control.marked ? 0 : 2
            border.color: control.hovered ? Colors.on_surface : Colors.on_surface_variant

            scale: control.down ? 0.85 : 1

            Behavior on scale {
                NumberAnimation { duration: 300; easing.type: Easing.OutBack; easing.overshoot: 2 }
            }
            Behavior on radius {
                NumberAnimation { duration: 250; easing.type: Easing.OutBack; easing.overshoot: 1.6 }
            }
            Behavior on color { ColorAnimation { duration: 120 } }
            Behavior on border.color { ColorAnimation { duration: 120 } }

            Icon {
                anchors.centerIn: parent
                iconName: control.checkState === Qt.PartiallyChecked ? "remove" : "check"
                size: control.boxSize - 4
                color: Colors.on_primary

                opacity: control.marked ? 1 : 0
                scale: control.marked ? 1 : 0.2

                Behavior on opacity { NumberAnimation { duration: 100 } }
                Behavior on scale {
                    NumberAnimation { duration: 300; easing.type: Easing.OutBack; easing.overshoot: 2.5 }
                }
            }
        }
    }

    contentItem: Label {
        text: control.text
        leftPadding: control.indicator.width
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        opacity: control.enabled ? 1 : 0.38
        color: Colors.on_surface
    }
}