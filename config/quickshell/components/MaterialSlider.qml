import QtQuick.Controls
import QtQuick

import "../constants"

Slider {
    id: control
    from: 0
    to: 100
    value: 50

    background: Item {
        anchors.fill: parent

        readonly property real trackHeight: 16
        readonly property real handleGap: 6
        readonly property real handleWidth: 4

        // position (0..1) along the track, minus handle width/gap accounted for
        readonly property real handleCenterX: control.leftPadding
            + control.availableWidth * control.visualPosition

        // Inactive track (right side of handle)
        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            x: parent.handleCenterX + parent.handleWidth / 2 + parent.handleGap
            width: Math.max(0, parent.width - x)
            height: parent.trackHeight

            topRightRadius: height / 2
            bottomRightRadius: height / 2
            topLeftRadius: height - 28 / 2
            bottomLeftRadius: height - 28 / 2
            color: Colors.secondary_container
        }

        // Active track (left side of handle)
        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            x: 0
            width: Math.max(0, parent.handleCenterX - parent.handleWidth / 2 - parent.handleGap)
            height: parent.trackHeight
            topRightRadius: height - 28 / 2
            bottomRightRadius: height - 28 / 2
            topLeftRadius: height / 2
            bottomLeftRadius: height / 2
            color: Colors.primary
        }
    }

    handle: Rectangle {
        x: control.leftPadding + control.availableWidth * control.visualPosition - width / 2
        y: (control.height - height) / 2
        implicitWidth: 4
        implicitHeight: 32
        radius: 2
        color: control.pressed ? Colors.primary_container : Colors.primary

        Behavior on implicitHeight { NumberAnimation { duration: 100 } }

        // slightly shrink the handle height while pressed, M3E-style
        states: State {
            when: control.pressed
            PropertyChanges { target: parent; implicitHeight: 24 }
        }
    }
}