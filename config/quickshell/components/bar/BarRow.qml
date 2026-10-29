import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root

    property real outerRadius: 16
    property real innerRadius: 4

    Layout.maximumHeight: 30
    spacing: 2

    function radiiTarget(c) {
        if (c.topLeftRadius !== undefined)
            return c
        if (c.background && c.background.topLeftRadius !== undefined)
            return c.background
        return null
    }

    function updateRadii() {
        const items = Array.from(visibleChildren)
            .map(radiiTarget)
            .filter(t => t !== null)

        items.forEach((t, i) => {
            const first = i === 0
            const last = i === items.length - 1

            t.topLeftRadius = first ? outerRadius : innerRadius
            t.bottomLeftRadius = first ? outerRadius : innerRadius
            t.topRightRadius = last ? outerRadius : innerRadius
            t.bottomRightRadius = last ? outerRadius : innerRadius
        })
    }

    onVisibleChildrenChanged: updateRadii()
    onOuterRadiusChanged: updateRadii()
    onInnerRadiusChanged: updateRadii()
    Component.onCompleted: updateRadii()
}