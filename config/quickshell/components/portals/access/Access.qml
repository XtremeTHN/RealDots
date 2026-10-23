import Quickshell.Io
import QtQuick.Layouts
import QtQuick.Controls as Controls
import QtQuick

import "root:/components/portals"
import "root:/components"
import "root:/"

Dialog {
    id: root

    property var reply: ({})

    function finish(dismissed: bool) {
        root.visible = false
        root.data = getDefaultData()

        reply.dismissed = dismissed
        root.ipc.finished(JSON.stringify(reply))
    }

    function getDefaultData() {
        return {
            title: "",
            subtitle: "",
            body: "",
            options: {},
        }
    }

    property var data: getDefaultData()

    ipc: IpcHandler {
        target: "portals-access"

        signal finished(reply: string)

        function prompt(data: string) {
            /*
                data: {
                    title: string
                    subtitle: string
                    body: string
                    options: {
                        modal: Optional<bool>,
                        deny_label: Optional<string>,
                        grant_label: Optional<string>,
                        icon: Optional<string>,
                        choices: Optional<(
                            id: str,
                            label: str,
                            options: MaybeEmpty<Array<(
                                id: str,
                                label: str
                            )>>,
                            initial_selection: str
                        )>
                    }
                }
            */
            
            root.data = JSON.parse(data)
            root.visible = true
        }
    }

    category: "ACCESS"
    title: data.title
    subtitle: data.subtitle
    body: data.body

    property var grantLabel: data.options.grant_label != undefined ? data.options.grant_label : "Grant"
    property var denyLabel: data.options.deny_label != undefined ? data.options.deny_label : "Deny" 

    readonly property var comboboxItems: {
        let raw_choices = data.options.choices
        if (raw_choices == undefined)
            return
        
        let filtered = raw_choices.filter(p => p[2].length > 0)
        
        let res = []

        for (let x of filtered) {
            res.push({
                id: x[0],
                label: x[1],
                itemIds: x[2].map(v => v[0]),
                items: x[2].map(v => v[1]),
                initialValue: x[2].filter(v => v[0] == x[3])[0][0]
            })
        }

        return res
    }

    readonly property var checkButtonsItems: {
        let raw_choices = data.options.choices
        if (raw_choices == undefined)
            return
        
        let filtered = raw_choices.filter(p => p[2].length == 0)
        
        let res = []

        for (let x of filtered) {
            res.push({
                id: x[0],
                label: x[1],
                initialValue: x[3] == "true" ? true : false
            })
        }

        return res
    }

    Rectangle {
        Layout.fillWidth: true
    }

    extraWidget: ColumnLayout {
        Repeater {
            model: root.comboboxItems

            delegate: ColumnLayout {
                required property var modelData
                
                DropDown {
                    model: modelData.items
                    label: modelData.label

                    currentIndex: modelData.itemIds.indexOf(modelData.initialValue)

                    onCurrentEntryChanged: {
                        root.reply[modelData.id] = modelData.itemIds[modelData.items.indexOf(currentEntry)]
                    }
                }
            }
        }

        Repeater {
            model: root.checkButtonsItems

            delegate: CheckBox {
                required property var modelData
                id: check

                checked: modelData.initialValue === "true"
                text: modelData.label
                onToggled: {
                    root.reply[modelData.id] = String(checked);
                }
            }
        }
    }

    PortalButton {
        label: grantLabel
        suggestedAction: true
        onClicked: {
            root.finish(false)
        }
    }

    PortalButton {
        label: denyLabel
        onClicked: {
            root.finish(true)
        }
    }
}