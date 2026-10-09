import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import "root:/"

Controls.Button {
    Layout.fillWidth: true

    property alias iconName: icon.iconName
    property alias label: lbl.text    

    padding: 10
    background: ButtonBackground {
        radius: 8
        flat: true
        idleColor: Colors.surface_container
    }

    contentItem: RowLayout {
        spacing: 0
        Icon {
            Layout.minimumWidth: 24
            Layout.preferredWidth: 24
            Layout.maximumWidth: 24
            horizontalAlignment: Text.AlignLeft

            id: icon
            size: 16
        }
        Label {
            id: lbl
            text: "Reboot"
            Layout.fillWidth: true
        }
    }
}