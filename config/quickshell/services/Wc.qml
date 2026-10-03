pragma Singleton

import Quickshell.Hyprland
import Quickshell

Singleton {
    id: wm
    
    property string hi: "hi"
    readonly property bool isHyprland: !!Quickshell.env("HYPRLAND_INSTANCE_SIGNATURE")
    readonly property string mango_title: Mango.active_window_title

    function portTag(tag) {
        return {
            id: tag.index,
            name: `${tag.index}`
        };
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
}
