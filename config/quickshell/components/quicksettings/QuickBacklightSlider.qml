import "root:/components"
import "root:/services"

MaterialSlider {
    
    iconName: {
        let percent = Backlight.brightnessPercentage

        if (percent < 20) return "brightness_empty"
        if (percent < 80) return "brightness_medium"
        return "brightness_7"
    }

    value: Backlight.brightnessPercentage
    onMoved: {
        Backlight.setBrightness(value)
    }
}