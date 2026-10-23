// credits: claude
import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import Quickshell

import "root:/components"
import "root:/"

Controls.Control {
    id: root

    property string label: ""
    property var model: []
    property string textRole: ""
    property string valueRole: ""
    property int currentIndex: 0
    property int maxPopupHeight: 280
    property bool open: false

    readonly property var currentEntry:
        model && currentIndex >= 0 && currentIndex < model.length
            ? model[currentIndex] : undefined
    readonly property string currentText: textOf(currentEntry)
    readonly property var currentValue:
        valueRole && currentEntry ? currentEntry[valueRole] : currentEntry

    signal activated(int index)

    function textOf(entry): string {
        if (entry === undefined || entry === null)
            return ""
        if (typeof entry === "object")
            return String(entry[textRole] ?? "")
        return String(entry)
    }

    function select(index: int): void {
        currentIndex = index
        activated(index)
        open = false
    }

    implicitWidth: 220
    implicitHeight: 48
    leftPadding: 18
    rightPadding: 12
    focusPolicy: Qt.StrongFocus

    HoverHandler { id: hover }
    TapHandler { onTapped: root.open = !root.open }

    Keys.onEscapePressed: root.open = false
    Keys.onSpacePressed: root.open = !root.open

    background: Rectangle {
        radius: root.open ? 16 : height / 2
        color: root.open || hover.hovered
            ? Colors.surface_container_highest
            : Colors.surface_container
        border.width: root.visualFocus || root.open ? 2 : 0
        border.color: Colors.primary

        Behavior on radius {
            NumberAnimation { duration: 250; easing.type: Easing.OutBack; easing.overshoot: 1.4 }
        }
        Behavior on color { ColorAnimation { duration: 120 } }
    }

    contentItem: RowLayout {
        spacing: 8

        ColumnLayout {
            spacing: 0
            Layout.fillWidth: true

            Label {
                visible: root.label !== ""
                text: root.label
                font.pixelSize: 11
                color: root.open ? Colors.primary : Colors.on_surface_variant
                elide: Text.ElideRight
                Layout.fillWidth: true
            }

            Label {
                text: root.currentText
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
        }

        Icon {
            iconName: "keyboard_arrow_down"
            size: 20
            rotation: root.open ? 180 : 0

            Behavior on rotation {
                NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
            }
        }
    }

    PopupWindow {
        id: popup

        anchor.item: root
        anchor.edges: Edges.Bottom | Edges.Left
        anchor.gravity: Edges.Bottom | Edges.Right
        anchor.adjustment: PopupAdjustment.Flip

        implicitWidth: root.width
        implicitHeight: Math.min(list.contentHeight + 12, root.maxPopupHeight)
        color: "transparent"

        // Stay mapped until the fade-out has finished
        visible: root.open || card.opacity > 0

        Rectangle {
            id: card
            anchors.fill: parent
            radius: 20
            color: Colors.surface_container
            border.width: 1
            border.color: Colors.outline_variant

            opacity: root.open ? 1 : 0
            scale: root.open ? 1 : 0.92
            transformOrigin: Item.Top
            anchors.top: parent.top
            anchors.topMargin: 3

            Behavior on opacity { NumberAnimation { duration: 120 } }
            Behavior on scale {
                NumberAnimation { duration: 250; easing.type: Easing.OutBack; easing.overshoot: 1.2 }
            }

            ListView {
                id: list
                anchors.fill: parent
                anchors.margins: 6
                clip: true
                spacing: 2
                model: root.model
                boundsBehavior: Flickable.StopAtBounds

                delegate: Item {
                    id: item

                    required property var modelData
                    required property int index

                    readonly property bool selected: index === root.currentIndex

                    width: ListView.view.width
                    height: 44

                    HoverHandler { id: itemHover }
                    TapHandler { onTapped: root.select(item.index) }

                    Rectangle {
                        anchors.fill: parent
                        radius: item.selected ? 14 : 10
                        color: item.selected
                            ? Colors.primary_container
                            : itemHover.hovered
                                ? Colors.surface_container_highest
                                : "transparent"

                        Behavior on color { ColorAnimation { duration: 100 } }
                        Behavior on radius { NumberAnimation { duration: 150 } }
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 16
                        anchors.rightMargin: 16
                        spacing: 10

                        Label {
                            text: root.textOf(item.modelData)
                            elide: Text.ElideRight
                            color: item.selected ? Colors.on_primary_container : Colors.on_surface
                            font.weight: item.selected ? 600 : 400
                            Layout.fillWidth: true
                        }

                        Icon {
                            visible: item.selected
                            iconName: "check"
                            size: 18
                        }
                    }
                }
            }
        }
    }
}