import QtQuick
import "root:/"

Text {
    id: root

    property alias size: root.font.pixelSize
    property alias iconName: root.text

    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    color: Colors.on_background
    font.family: "Material Symbols Rounded"
}