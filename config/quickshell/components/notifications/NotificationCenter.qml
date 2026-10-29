import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls

import "root:/components"
import "root:/services/notifications"
import "root:/"

PopupWindow {
    required property var window

    anchor.window: window


}