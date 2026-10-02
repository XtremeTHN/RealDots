import Quickshell.Hyprland
import "root:/components"

Label {
    text: Hyprland.activeToplevel == undefined ? "ArchLinux" : Hyprland.activeToplevel.title
}