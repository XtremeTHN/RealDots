import "root:/components"
import "root:/services"
import QtQuick

Label {
    elide: Text.ElideRight
    text: (Wc.activeToplevel == undefined || Wc.activeToplevel.title == "") ? "ArchLinux" : Wc.activeToplevel.title
}