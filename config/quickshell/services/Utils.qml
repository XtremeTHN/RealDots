pragma Singleton

import Quickshell

Singleton {
    function toTitleCase(text) {
        return String(text ?? "").toLowerCase().replace(/\b\w/g, character => character.toUpperCase())
    }

    function getLocalIcon(icon_name) {
        return Quickshell.shellDir + "/icons/" + icon_name + ".svg"
    }

    function joinPath(...parts) {
        if (parts.length === 0) return ""

        let result = ""

        for (const part of parts) {
            if (part === "") continue

            if (part.startsWith("/")) {
                result = part
            } else if (result === "" || result.endsWith("/")) {
                result += part
            } else {
                result += "/" + part
            }
        }


        return result
    }
}