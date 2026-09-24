import Quickshell.Wayland
import Quickshell
import QtQuick

PanelWindow {
    id: transitioner
    WlrLayershell.layer: WlrLayer.Overlay

    function start() {
        animator.start()
    }

    anchors {
        left: true
        bottom: true
        right: true
        top: true
    }

    signal finished()

    color: "transparent"

    Rectangle {
        id: rect

        color: "black"

        anchors.fill: parent

        PropertyAnimation {
            id: animator
            target: rect
            property: "opacity"
            from: 1
            to: 0
            duration: 1500
            easing.type: Easing.InOutQuart
            onFinished: {
                transitioner.visible = false
                transitioner.finished()
            }
        }
    }
}