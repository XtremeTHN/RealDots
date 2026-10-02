import Quickshell
import QtQuick

import "root:/components"
import "root:/services"
import "root:/"

Row {
    spacing: 5

    Scope {
        Temperature {
            id: gpuTemp
            deviceName: "amdgpu"
        }

        Temperature {
            id: cpuTemp
            deviceName: "k10temp"
        }
    }

    Icon {
        id: icon_
        size: 15

        iconName: {
            if (gpuTemp.temperature > 70000 || cpuTemp.temperature > 70000) return "emergency_heat"
            if (gpuTemp.temperature < 30000 || cpuTemp.temperature < 30000) return "snowflake"
            return "device_thermostat"
        }
    }

    Repeater {
        model: [gpuTemp, cpuTemp]
        
        delegate: Label {
            anchors.verticalCenter: parent.verticalCenter

            required property var modelData
            color: Colors.on_background
            text: `${Math.round(modelData.temperature / 1000)} °C`
        }
    }
}