import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts

import Quickshell.Widgets
import Quickshell

import "root:/components"
import "root:/"

Controls.Control {
    id: root

    property color backgroundColor: Qt.alpha(Colors.surface_container, 0.4)

    property var notification
    property string summary
    property string body
    property string appName
    property string appIcon
    property string image
    property var actions: []
    property var hints: ({})

    readonly property bool hasMaterialIcon: !!hints["materialIcon"]
    readonly property bool hasThemeIcon: !!Quickshell.iconPath(appIcon, true)

    onNotificationChanged: {
        if (!notification) return
        summary = notification.summary
        body = notification.body
        appName = notification.appName
        appIcon = notification.appIcon
        root.image = notification.image
        actions = notification.actions
        hints = notification.hints
    }

    background: Rectangle {
        color: root.backgroundColor
        radius: 16
    }

    padding: 10

    HoverHandler {
        onHoveredChanged: {
            rev.reveal = hovered
        }
    }

    contentItem: ColumnLayout {
        RowLayout {
            StackLayout {
                Layout.fillWidth: false
                currentIndex: root.hasMaterialIcon || !root.hasThemeIcon ? 1 : 0

                IconImage {
                    id: image
                    implicitSize: 16
                    source: Quickshell.iconPath(root.appIcon)
                }

                Icon {
                    text: root.hints["materialIcon"] ?? "computer"
                    size: 16
                }
            }

            Label {
                text: root.appName
                opacity: 0.8
            }

            Label {
                text: "●"
                font.pixelSize: 6
                opacity: 0.8
            }

            Label {
                text: "now"
                opacity: 0.6
            }

            Rectangle {
                Layout.fillWidth: true
            }

            Controls.Button {
                implicitWidth: 24
                implicitHeight: 24
                padding: 0

                onClicked: {
                    root.notification.dismiss()
                }

                background: ButtonBackground {
                    idleColor: Colors.background
                    radius: 99
                }

                contentItem: Item {
                    anchors.fill: parent

                    Icon {
                        anchors.centerIn: parent
                        iconName: "close"
                        size: 14
                    }
                }
            }
        }

        Label {
            text: root.summary
        }

        Label {
            Layout.maximumWidth: 380
            wrapMode: Text.WrapAnywhere
            text: root.body
            opacity: 0.6
            font.weight: 450
        }

        Revealer {
            id: rev
            property bool hasImage: root.image !== ""
            property bool hasActions: root.actions.length > 0
            block: !(hasImage || hasActions)
            Layout.fillWidth: true
            
            ClippingRectangle {
                visible: rev.hasImage

                radius: 16
                Layout.topMargin: 5
                Layout.bottomMargin: 5
                Layout.fillWidth: true
                Layout.preferredHeight: 100

                Image {
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: root.image
                }
            }
        
            RowLayout {
                visible: rev.hasActions
                Repeater {
                    model: root.actions
                    delegate: Controls.Button {
                        id: btt
                        
                        required property var modelData;
                        
                        leftPadding: 10
                        rightPadding: 10
                        padding: 7

                        onClicked: {
                            modelData.invoke()
                        }

                        background: ButtonBackground {
                            opacity: 0
                            // idleColor: root.backgroundColor
                            radius: 8
                        }

                        contentItem: Label {
                            text: modelData.text
                            color: btt.hovered ? Colors.primary : Colors.secondary
                        }
                    }
                }
            }
        }
    }
}