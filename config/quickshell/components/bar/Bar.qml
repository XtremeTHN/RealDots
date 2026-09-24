import Quickshell
import QtQml
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import Quickshell.Networking
import Quickshell.Wayland
import Quickshell.Services.Mpris

import "../../constants"
import "../../services"
import "../"

PanelWindow {
    id: window

    WlrLayershell.layer: WlrLayer.Bottom
    anchors {
        bottom: true
        left: true
        right: true
    }
    
    margins {
        top: -10
    }


    implicitHeight: 40
    color: "transparent";

    Container {
        padding: 15
        anchors.left: parent.left
        anchors.leftMargin: 10

        Row {
            id: child
            spacing: 4
            anchors.centerIn: parent

            Repeater {
                model: 9

                delegate: Rectangle {
                    id: dot
                    Layout.alignment: Qt.AlignVCenter

                    required property int modelData
                    property bool isActive: Mango.active_workspace_index == modelData + 1

                    width: isActive ? 32 : 14
                    height: 14
                    radius: height / 2
                    color: isActive ? Colors.primary : Colors.on_primary

                    Behavior on width {
                        NumberAnimation {
                            duration: 150
                            easing.type: Easing.OutCubic
                        }
                    }

                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
            }
        }
    }

    Container {
        padding: 15
        anchors.centerIn: parent

        Text {
            id: active_window
            text: Mango.active_window_title == "" ? "Fedora" : Mango.active_window_title
            color: Colors.on_background
            anchors.centerIn: parent
        }
    }
    
    Row {
        spacing: 15

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10

        Container {
            id: music
            padding: 15

            property var activePlayer: {
                if (Mpris.players.length == 0) return

                let playing = Mpris.players.values.find(p => p.isPlaying)
                return playing ?? Mpris.players[0]
            }

            visible: activePlayer != null

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.centerIn: parent
                color: Colors.on_background

                text: {
                    let members = []
                    let activePlayer = music.activePlayer

                    if (activePlayer == undefined) return ""

                    if (activePlayer.trackTitle != undefined)
                        members.push(activePlayer.trackTitle)
                    
                    if (activePlayer.trackArtist != undefined)
                        members.push(activePlayer.trackArtist)

                    return members.join(" - ")
                }
            }
        }

        Container {
            padding: 15
            Text {
                text: Qt.formatDateTime(clock.date, "hh:mm AP ddd MM/d/yy")
                color: Colors.on_background
                anchors.centerIn: parent

                SystemClock {
                    id: clock
                    precision: SystemClock.Seconds
                }
            }
        }

        Container {
            padding: 15

            StatusIcons {}
        }
    }
}