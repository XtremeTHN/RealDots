pragma Singleton

import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell

Singleton {
    id: wm
    
    readonly property bool isHyprland: !!Quickshell.env("HYPRLAND_INSTANCE_SIGNATURE")
    readonly property string mango_title: Mango.active_window_title

    function portTag(tag) {
        return {
            id: tag.index,
            name: `${tag.index}`
        };
    }

    function refreshToplevels() {
        if (!isHyprland) return
        Hyprland.refreshToplevels()
    }

    property var activeToplevel: {
        if (isHyprland) {
            return Hyprland.activeToplevel
        } else {
            return {
                title: Mango.active_window_title
            }
        }
    }

    property var focusedWorkspace: {
        if (isHyprland) return Hyprland.focusedWorkspace
        
        let tag = Mango.tags[Mango.active_workspace_index]
        if (!tag) return
        let ported = portTag(tag)
        ported.id -= 1
        return ported
    }

    property var workspaces: isHyprland ? Hyprland.workspaces.values : Mango.tags.filter(tag => tag.client_count > 0 || tag.is_active).map(portTag)
    property var toplevels: isHyprland ? Hyprland.toplevels.values : Mango.clients.map(c => ({
        workspace: { id: c.tags[0] },
        lastIpcObject: {
            at: [c.x, c.y],
            size: [c.width, c.height]
        },
        wayland: ToplevelManager.toplevels.values.find(t => t.title == c.title && t.appId == c.appid)
    }))
}