import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import "root:/"

PanelWindow {
    id: root
    visible: false

    onVisibleChanged: {
        if (!visible) return
        view.captureFrame()
    }

    anchors {
        top: true
        left: true
        bottom: true
        right: true
    }

    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore

    property int operation

    color: "transparent"

    // property bool frozen: false
    property bool isReady: false
    property bool portal: false
    property string portalOutPath

    readonly property rect selection: Qt.rect(
        Math.min(selector.startPoint.x, selector.endPoint.x),
        Math.min(selector.startPoint.y, selector.endPoint.y),
        Math.abs(selector.endPoint.x - selector.startPoint.x),
        Math.abs(selector.endPoint.y - selector.startPoint.y))
    
    function restart() {
        root.visible = false
        view.visible = true
        selector.restart()
        t.restart()
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    ScreencopyView {
        id: view
        captureSource: root.screen
        anchors.fill: parent
        live: false
        paintCursor: false
    }

    ShaderEffectSource {
        id: crop
        sourceItem: view
        live: false
        opacity: 0
        width: sourceRect.width
        height: sourceRect.height
        hideSource: true
        textureSize: Qt.size(
            width * root.screen.devicePixelRatio,
            height * root.screen.devicePixelRatio)
    }

    StackLayout {
        currentIndex: t.mode
        anchors.fill: parent

        onCurrentIndexChanged: {
            if (view.captureSource != root.screen && currentIndex != Toolbar.Mode.Window) view.captureSource = root.screen
            if (currentIndex == Toolbar.Mode.Window) winSelector.refresh()
        }

        Selector {
            id: selector

            onStartPointChanged: {
                root.isReady = (selector.startPoint.x != 0 && selector.startPoint.y != 0)
                                || (selector.endPoint.x != 0 && selector.endPoint.y != 0)
            }
        }

        WindowSelector {
            id: winSelector
            onSelectedWindowChanged: {
                if (selectedWindow == null) {
                    root.isReady = false
                    return
                }

                root.isReady = true
                view.captureSource = selectedWindow
            }
        }
    }

    Toolbar {
        id: t
        // visible: root.frozen
        doneEnabled: root.isReady
        
        onClose: {
            root.restart()
            if (portal) ipc.finished(true)
        }

        onDone: {
            let item = null

            if (mode == Toolbar.Mode.Free) {
                crop.sourceRect = root.selection
                crop.scheduleUpdate()
                item = crop
            }
            
            if (mode == Toolbar.Mode.Window || mode == Toolbar.Mode.Fullscreen) item = view;
            if (mode == Toolbar.Mode.Fullscreen) {
                view.captureSource = root.screen
            }

            item.grabToImage(res => {
                if (!portal) {
                    let xdg_screenshots = Quickshell.env("XDG_SCREENSHOT_DIR")
                    let xdg_pictures = Quickshell.env("XDG_PICTURES_DIR")
                    
                    let pictures = Utils.joinPath(Quickshell.env("HOME"), "Pictures")

                    // use xdg screenshots, fallback to xdg pictures, fallback to pictures folder
                    let baseDir = xdg_screenshots ? xdg_screenshots : (xdg_pictures ? xdg_pictures : pictures)
                    let name = `Screenshot ${Qt.formatDateTime(clock.date, "yyyy-MM-dd")} at ${Qt.formatDateTime(clock.date, "hh.mm.ss")}.png`

                    res.saveToFile(Utils.joinPath(baseDir, name))
                } else {
                    res.saveToFile(root.portalOutPath)
                    ipc.finished(false)
                }

                root.restart()
            })
        }
    }

    IpcHandler {
        id: ipc
        target: "screenshot"

        signal finished(dismissed: bool)

        function toggle() {
            root.visible = !root.visible 
        }

        function screenshot(target: string, path: string) {
            root.portal = true
            root.portalOutPath = path
            t.setTarget(target)
            root.visible = true
        }
    }
}