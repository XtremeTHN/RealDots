pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Services.Mpris

import "root:/components"
import "root:/"

BarContainer {
    id: music

    color: Colors.surface_container
    padding: 8

    topLeftRadius: 16
    bottomLeftRadius: 16
    topRightRadius: 4
    bottomRightRadius: 4

    property var activePlayer: {
        if (Mpris.players.length == 0)
            return;
        let playing = Mpris.players.values.find(p => p.isPlaying);
        return playing ?? Mpris.players[0];
    }

    function trackLabel(player) {
        if (!player)
            return "";

        let parts = [];
        if (player.trackTitle)
            parts.push(player.trackTitle);
        if (player.trackArtist)
            parts.push(player.trackArtist);
        return parts.join(" - ");
    }

    property string lastLabel: ""

    visible: opacity > 0
    opacity: activePlayer != null ? 1 : 0

    contentItem: RowLayout {
        spacing: 5

        Image {
            id: sourceItem
            source: music.activePlayer ? music.activePlayer.trackArtUrl : ""
            fillMode: Image.PreserveAspectCrop

            width: 16
            height: 16
            visible: false
        }

        MultiEffect {
            source: sourceItem
            // anchors.fill: sourceItem
            width: sourceItem.width
            height: sourceItem.height

            maskEnabled: true
            maskSource: mask

            maskThresholdMin: 0.5
            maskSpreadAtMin: 1.0

            visible: {
                if (!music.activePlayer) return false
                return music.activePlayer.trackArtUrl != ""
            }

            NumberAnimation on rotation {
                from: 0
                to: 360
                duration: 6000
                loops: Animation.Infinite
                running: music.activePlayer ? music.activePlayer.isPlaying : false
            }
        }

        Item {
            id: mask
            width: sourceItem.width
            height: sourceItem.height
            layer.enabled: true
            visible: false
            layer.smooth: true

            Rectangle {
                width: sourceItem.width
                height: sourceItem.height
                radius: 9999
                color: "black"
            }
        }

        Label {
            Layout.maximumWidth: 200
            id: trackLabelText

            text: music.activePlayer != null ? music.trackLabel(music.activePlayer) : music.lastLabel

            elide: Text.ElideRight
            maximumLineCount: 1

            onTextChanged: {
                if (music.activePlayer != null)
                    music.lastLabel = trackLabelText.text;
            }
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 200
        }
    }
}
