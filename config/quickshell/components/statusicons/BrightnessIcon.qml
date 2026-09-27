import "../../services"
import "../../constants"
import "../"

Icon {
    color: Colors.on_background
    icon_name: {
        let idx = Math.min(7, Math.floor(Backlight.brightnessPercentage / 14.285714285714286))
        if (Number.isNaN(idx) || idx == 0) return getLocalIcon("brightness-1")
        return getLocalIcon(`brightness-${idx}`)
    }
}