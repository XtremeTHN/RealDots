import QtQuick
import "root:/"

Text {
    id: root

    property alias size: root.font.pixelSize
    property alias iconName: root.text

    color: Colors.on_background
    font.family: "Material Symbols Rounded"
}