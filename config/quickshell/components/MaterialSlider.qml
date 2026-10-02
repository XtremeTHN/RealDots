import QtQuick.Controls
import QtQuick

import "root:/"

Slider {
    property alias iconName: icon.iconName

    id: control
    from: 0
    to: 100
    value: 50

    background: Item {
        anchors.fill: parent

        readonly property real trackHeight: 32
        readonly property real handleGap: 2
        readonly property real handleWidth: 4

        readonly property real handleCenterX: control.leftPadding
            + control.availableWidth * control.visualPosition

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            x: parent.handleCenterX + parent.handleWidth / 2 + parent.handleGap
            width: Math.max(0, parent.width - x)
            height: parent.trackHeight

            topRightRadius: 6
            bottomRightRadius: 6
            color: Colors.surface_container
        }

        Rectangle {
            width: 5
            height: 5
            radius: 9

            color: Colors.secondary

            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 6
            z: 0
        }

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            x: 0
            width: Math.max(0, parent.handleCenterX - parent.handleWidth / 2 - parent.handleGap)
            height: parent.trackHeight
            topLeftRadius: 6
            bottomLeftRadius: 6
            color: Colors.primary
            z: 1
        }

        Icon {
            id: icon

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 8
            iconName: iconName
            color: control.visualPosition * control.availableWidth <= 10
                ? Colors.on_secondary_container
                : Colors.on_primary
            size: 18
            z: 2
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.availableWidth * control.visualPosition - width / 2
        y: (control.height - height) / 2
        z: 10
        implicitWidth: 3
        implicitHeight: 42
        radius: 2
        color: control.pressed ? Colors.primary_container : Colors.primary

        Behavior on implicitHeight { NumberAnimation { duration: 100 } }

        states: State {
            when: control.pressed
            PropertyChanges { target: parent; implicitHeight: 24 }
        }
    }
}