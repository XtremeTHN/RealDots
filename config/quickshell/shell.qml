//@ pragma IconTheme Adwaita

import Quickshell
import QtQml
import QtQuick

import "components"
import "components/bar"
import "components/notifications"
import "services"

Scope {
    id: root

    PersistentProperties {
        id: props
        reloadableId: "propsState"

        property bool hasShownTransition: false

        onLoaded: {
            if (!props.hasShownTransition) {
                props.hasShownTransition = true
                timer.start()
            } else {
                transitioner.visible = false
                bar.exclusiveZone = 25
            }
        }
    }

    Timer {
        id: timer
        interval: 2000
        repeat: false

        onTriggered: {
            transitioner.start()
        }
    }
    
    Transitioner {
        id: transitioner
        onFinished: {
            bar.exclusiveZone = 25
        }
    }

    Bar {
        id: bar
        exclusiveZone: -1
    }

    NotificationList {}
}