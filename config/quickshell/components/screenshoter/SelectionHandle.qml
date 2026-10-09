import QtQuick

Rectangle {
    id: handle
    width: 14
    height: 14
    radius: 7
    color: "white"

    property var target: null
    property string handleType: "se"

    property real dragOriginX: 0
    property real dragOriginY: 0
    property real startLeft: 0
    property real startTop: 0
    property real startRight: 0
    property real startBottom: 0

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.SizeAllCursor

        onPressed: mouse => {
            if (!handle.target) return

            var p = mapToItem(handle.target.parent, mouse.x, mouse.y)
            handle.dragOriginX = p.x
            handle.dragOriginY = p.y
            handle.startLeft = handle.target.x
            handle.startTop = handle.target.y
            handle.startRight = handle.target.x + handle.target.width
            handle.startBottom = handle.target.y + handle.target.height
        }

        onPositionChanged: mouse => {
            if (!pressed || !handle.target) return

            var p = mapToItem(handle.target.parent, mouse.x, mouse.y)
            var dx = p.x - handle.dragOriginX
            var dy = p.y - handle.dragOriginY

            var left = handle.startLeft
            var top = handle.startTop
            var right = handle.startRight
            var bottom = handle.startBottom

            if (handle.handleType.includes("w")) {
                left = Math.min(handle.startLeft + dx, right - 64)
            }

            if (handle.handleType.includes("e")) {
                right = Math.max(handle.startRight + dx, left + 64)
            }

            if (handle.handleType.includes("n")) {
                top = Math.min(handle.startTop + dy, bottom - 64)
            }

            if (handle.handleType.includes("s")) {
                bottom = Math.max(handle.startBottom + dy, top + 64)
            }

            handle.target.x = left
            handle.target.y = top
            handle.target.width = Math.max(0, right - left)
            handle.target.height = Math.max(0, bottom - top)
        }
    }
}
