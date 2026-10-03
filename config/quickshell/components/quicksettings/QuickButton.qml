import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "root:/components/statusicons"
import "root:/components"
import "root:/"

RowLayout {
    id: root

    property bool checked: btt.checked
    property alias iconItem: iconHost.data

    required property string title
    property string subtitle: ""

    readonly property color backgroundColor: checked ? Colors.primary : Colors.surface_container
    readonly property color foregroundColor: checked ? Colors.on_primary : Colors.on_surface

    spacing: 0

    signal toggle(cond: bool)

    function click() {
        let cond = !btt.checked

        btt.checked = cond
        menu.checked = cond

        toggle(cond)
    }

    Button {
        id: btt
        Layout.fillWidth: true
        
        background: ButtonBackground {
            btt: btt
            topLeftRadius: 16
            bottomLeftRadius: 16

            color: root.backgroundColor
        }

        padding: 13
        leftPadding: 15

        onClicked: root.click()

        contentItem: RowLayout {
            spacing: 10

            Item {
                Layout.alignment: Qt.AlignCenter
                id: iconHost

                implicitWidth: childrenRect.width
                implicitHeight: childrenRect.height

                Binding {
                    target: iconHost.children.length > 0 ? iconHost.children[0] : null
                    property: "color"
                    value: root.foregroundColor
                }
            }

            ColumnLayout {
                spacing: 0
                Label {
                    Layout.maximumWidth: 80
                    text: root.title
                    font.pixelSize: 16
                    font.weight: 650
                    color: root.foregroundColor
                    elide: Text.ElideRight
                    maximumLineCount: 1
                }

                Label {
                    text: root.subtitle
                    visible: root.subtitle != undefined || root.subtitle != "" 
                    font.weight: 400
                    font.pixelSize: 11
                    color: root.foregroundColor
                }
            }
        }
    }

    Button {
        id: menu
        checked: root.checked
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignCenter
        background: ButtonBackground {
            btt: menu

            bottomRightRadius: 16
            topRightRadius: 16

            color: root.backgroundColor
        }

        onClicked: {
            if (!root.hasMenu) {
                root.click()
                return
            }

            // TODO
        }
        
        contentItem: Item {
            implicitHeight: 24
            implicitWidth: 28

            Icon {
                anchors.centerIn: parent
                iconName: "keyboard_arrow_right"
                size: 24

                color: root.foregroundColor
            }
        }
    }
}
