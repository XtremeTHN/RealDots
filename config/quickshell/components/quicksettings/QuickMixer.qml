import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire

import "../"
import "../../services"
import "../../constants"

QuickPage {
    title: "Audio Mixer"
    implicitWidth: 400
    implicitHeight: 400   // fixed page height — list scrolls internally, no circular dependency

    ListView {
        anchors.fill: parent
        anchors.topMargin: 80
        anchors.leftMargin: 20
        anchors.rightMargin: 20

        clip: true
        spacing: 8

        model: Pipewire.nodes.values.filter(n => n.isStream)

        delegate: Rectangle {
            required property var modelData

            width: ListView.view.width
            implicitHeight: 100

            radius: 18

            color: Colors.surface_container

            StackLayout {
                anchors.fill: parent
                currentIndex: 0

                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignCenter

                    Icon {
                        icon_name: getLocalIcon("audio-volume-high")
                        implicitSize: 42
                        color: Colors.on_background
                    }

                    Text {
                        text: "Hi"
                        color: Colors.on_background
                    }
                }

                ColumnLayout {
                    spacing: 10

                    Text {
                        color: Colors.on_background
                        font.family: "Roboto"
                        font.pixelSize: 14
                        text: Utils.toTitleCase(modelData.name ?? modelData.description ?? "Unknown")
                    }

                    MaterialSlider {
                        Layout.fillWidth: true
                        value: modelData.audio ? modelData.audio.volume * 100 : 0
                        onMoved: {
                            if (modelData.audio) modelData.audio.volume = value / 100
                        }
                    }
                }
            }
        }
    }
}