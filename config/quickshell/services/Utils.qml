pragma Singleton

import Quickshell

Scope {
    function getLocalIcon(icon_name) {
        return Quickshell.shellDir + "/icons/" + icon_name + ".svg"
    }
}