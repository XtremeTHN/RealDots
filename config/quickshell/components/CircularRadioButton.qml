import QtQuick.Controls
import QtQuick
import "root:/"

RadioButton {
    property string iconName
    property color idleColor: Colors.surface_container
    
    id: root
    implicitWidth: Math.max(implicitContentWidth, implicitContentHeight) + padding * 2
    background: ButtonBackground {
        radius: 99
        color: root.checked ? Colors.primary : root.idleColor
    }

    contentItem: Icon {
        size: 20
        color: root.enabled ? root.checked ? Colors.on_primary : Colors.on_background : Colors.outline_variant
        iconName: root.iconName
    }
}