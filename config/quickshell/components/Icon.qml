import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets

IconImage {
    id: icon
    property string icon_name
    property color color

    function getLocalIcon(icon_name) {
        return Quickshell.shellDir + "/icons/" + icon_name + ".svg"
    }

    source: Quickshell.iconPath(icon_name, "image-missing")

    backer.layer.enabled: true
    backer.layer.effect: MultiEffect {
        colorization: color != undefined ? 1 : 0
        colorizationColor: icon.color != undefined ? icon.color : "white" // your desired icon color
    }
}