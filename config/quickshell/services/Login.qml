pragma Singleton
import DBus
import Quickshell
import QtQuick

import "root:/services"
import "root:/"

Singleton {
    DBus {
        id: manager
        connection: SystemBus
        
        service: "org.freedesktop.login1"
        path: "/org/freedesktop/login1"
        iface: "org.freedesktop.login1.Manager"
    }

    DBus {
        id: session
        connection: SystemBus
        
        service: "org.freedesktop.login1"
        path: "/org/freedesktop/login1/session/auto"
        iface: "org.freedesktop.login1.Session"
    }

    Timer {
        id: timer
        property var callback

        interval: Settings.s.quickSettings.delayBeforeShutdown
        onTriggered: {
            callback([false])
        }
    }

    function setOnTimer(cb, canOperation, operation) {
        let main = () => {
            if (timer.callback != undefined) timer.stop()
            timer.callback = cb

            Utils.notify("System", `The system will ${operation} in ${Settings.s.quickSettings.delayBeforeShutdown / 1000} seconds`, [
                {
                    label: "Skip",
                    cb: () => {
                        timer.stop()
                        cb()
                    }
                },
                {
                    label: "Cancel",
                    cb: () => timer.stop()
                }
            ])
        }

        if (!canOperation) {
            main()
            return
        }
        
        let reply = canOperation()

        reply.finished.connect(() => {
            if (reply.isError) {
                Utils.notify("System", `Couldn't ${operation}: ${reply.error.message}`)
                return
            }
            if (reply.value == "no") {
                Utils.notify("System", `Can't ${operation} right now`)
                return
            }

            main()
        })
    }

    function reboot() {
        setOnTimer(manager.reboot, manager.canreboot, "reboot")
    }

    function powerOff() {
        setOnTimer(manager.poweroff, manager.canpoweroff, "shutdown")
    }

    function suspend() {
        setOnTimer(manager.suspend, manager.cansuspend, "suspend")
    }
    
    function logOut() {
        setOnTimer(session.terminate, undefined, "log off")
    }
}