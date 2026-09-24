import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Notifications
import "../"
import "../../services"
import "../../constants"

PanelWindow {
    id: root
    anchors {
        right: true
        top: true
    }

    color: "transparent"
    implicitWidth: 600
    implicitHeight: 1080

    margins {
        top: 10
    }

    ListModel {
        id: _model
    }

    NotificationServer {
        id: server

        bodySupported: true
        bodyImagesSupported: true
        bodyMarkupSupported: true
        bodyHyperlinksSupported: true
        imageSupported: true

        actionsSupported: true
        actionIconsSupported: true

        persistenceSupported: true
        inlineReplySupported: true

        onNotification: notification => {
            notification.tracked = true
            _model.append({
                notif: notification,
            })
        }
    }

    ListView {
        id: view
        model: _model
        anchors.fill: parent
        spacing: 10

        add: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 250 }
            NumberAnimation { property: "scale"; from: 0.8; to: 1; duration: 250 }
        }

        addDisplaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 250; easing.type: Easing.OutQuad }
        }

        remove: Transition {
            NumberAnimation { property: "opacity"; to: 0; duration: 200 }
            NumberAnimation { property: "scale"; to: 0.8; duration: 200 }
        }

        removeDisplaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 250; easing.type: Easing.OutQuad }
        }

        delegate: NotificationComponent {
            id: notif_comp
            Component.onCompleted: {
                anchors.right = parent.right
                anchors.rightMargin = 10
            }

            Timer {
                interval: 5000
                running: true
                repeat: false

                onTriggered: {
                    view.model.remove(notif_comp.index)
                }
            }
        }
    }
}