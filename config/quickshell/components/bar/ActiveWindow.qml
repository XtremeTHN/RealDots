import "root:/components"
import "root:/services"

Label {
    text: (Wc.activeToplevel == undefined || Wc.activeToplevel.title == "") ? "ArchLinux" : Wc.activeToplevel.title
}