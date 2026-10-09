import QtQuick

pragma ComponentBehavior: Bound

Item {
    id: root
    
    property real selectionStartX
    property real selectionStartY
    property bool handlesVisible: false

    readonly property point startPoint: Qt.point(selectionRect.x, selectionRect.y)
    readonly property point endPoint: Qt.point(selectionRect.x + selectionRect.width,
                                                selectionRect.y + selectionRect.height)
    readonly property var selectionBox: selectionRect

    function restart() {
        selectionBox.x = 0
        selectionBox.y = 0
        selectionBox.width = 0
        selectionBox.height = 0
    }


    Item {
        id: dim
        anchors.fill: parent

        property color shade: Qt.rgba(0, 0, 0, 0.5)

        Rectangle {
            color: dim.shade
            x: 0
            y: 0
            width: dim.width
            height: Math.max(0, selectionRect.y)
        }

        Rectangle {
            color: dim.shade
            x: 0
            y: selectionRect.y + selectionRect.height
            width: dim.width
            height: Math.max(0, dim.height - y)
        }

        Rectangle {
            color: dim.shade
            x: 0
            y: selectionRect.y
            width: Math.max(0, selectionRect.x)
            height: selectionRect.height
        }

        Rectangle {
            color: dim.shade
            x: selectionRect.x + selectionRect.width
            y: selectionRect.y
            width: Math.max(0, dim.width - x)
            height: selectionRect.height
        }
    }

    MouseArea {
        id: panel
        anchors.fill: parent

        onPressed: mouse => {
            root.selectionStartX = mouse.x
            root.selectionStartY = mouse.y
            root.handlesVisible = false
            selectionRect.x = mouse.x
            selectionRect.y = mouse.y
            selectionRect.width = 0
            selectionRect.height = 0
        }

        onPositionChanged: mouse => {
            if (pressed) {
                selectionRect.x = Math.min(mouse.x, root.selectionStartX)
                selectionRect.y = Math.min(mouse.y, root.selectionStartY)
                selectionRect.width = Math.abs(mouse.x - root.selectionStartX)
                selectionRect.height = Math.abs(mouse.y - root.selectionStartY)
            }
        }

        onReleased: {
            root.handlesVisible = true

            selectionRect.width = Math.max(selectionRect.width, 32)
            selectionRect.height = Math.max(selectionRect.height, 32)
        }

        onCanceled: {
            root.handlesVisible = true
        }
    }

    Rectangle {
        id: selectionRect
        color: "transparent"
        border.color: "white"
        border.width: 2

        Behavior on width {
            NumberAnimation { duration: 50 }
        }

        Behavior on height {
            NumberAnimation { duration: 50 }
        }

        Behavior on x {
            NumberAnimation { duration: 50 }
        }

        Behavior on y {
            NumberAnimation { duration: 50 }
        }

        MouseArea {
            anchors.fill: parent

            property real grabX
            property real grabY

            onPressed: mouse => {
                var p = mapToItem(selectionRect.parent, mouse.x, mouse.y)
                grabX = p.x - selectionRect.x
                grabY = p.y - selectionRect.y
            }

            onPositionChanged: mouse => {
                if (!pressed) return
                var p = mapToItem(selectionRect.parent, mouse.x, mouse.y)
                selectionRect.x = p.x - grabX
                selectionRect.y = p.y - grabY
            }
        }

        Item {
            visible: root.handlesVisible
            enabled: root.handlesVisible

            Repeater {
                model: ["nw", "ne", "sw", "se", "n", "s"]

                delegate: SelectionHandle {
                    required property var modelData

                    target: selectionRect
                    handleType: modelData
                    x: {
                        if (modelData === "nw" || modelData === "sw")
                            return 0 - width / 2
                        if (modelData === "ne" || modelData === "se")
                            return selectionRect.width - width / 2
                        return selectionRect.width / 2 - width / 2
                    }
                    y: {
                        if (modelData === "nw" || modelData === "ne" || modelData === "n")
                            return 0 - height / 2
                        return selectionRect.height - height / 2
                    }
                }
            }
        }
    }
}