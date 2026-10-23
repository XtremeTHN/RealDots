import Quickshell.Io
import QtQuick.Layouts
import QtQuick

import "root:/components/portals"
import "root:/components"
import "root:/"

Dialog {
    id: root
    property string appName
    property var currentDevices: []
    
    function finished(dismissed: bool) {
        currentDevices = []
        ipc.finished(dismissed)
        root.visible = false
    }

    ipc: IpcHandler {
        target: "portals-usb"

        signal finished(dismissed: bool)

        function addDevice(name: string, vendor: string, writable: bool) {
            root.currentDevices.push({
                name: name,
                vendor: vendor,
                writable: writable
            })
        }

        function prompt(appName: string) {
            usbRepeater.model = root.currentDevices
            root.appName = appName.replace("x20", " ")
            root.visible = true
        }
    }

    category: "USB"
    title: `Allow ${root.appName} to access USB?`
    body: `${root.appName} is requesting access to the following USB devices:`
    // visible: true

    extraWidget: ColumnLayout {
        spacing: 0

        Repeater {
            id: usbRepeater
            
            delegate: UsbDevice {
                required property var modelData

                writable: modelData.writable
                deviceName: modelData.name.replace("\\x20", " ")
                deviceVendor: modelData.vendor.replace("\\x20", " ").replace("x20", " ")
            }
        }
    }

    Rectangle {
        Layout.fillWidth: true
    }

    PortalButton {
        label: "Allow"
        suggestedAction: true

        onClicked: {
            root.finished(false)
        }
    }

    PortalButton {
        label: "Deny"
        
        onClicked: {
            root.finished(true)
        }
    }
}