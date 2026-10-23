import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property bool reveal: false
    property bool block: false
    property int duration: 250
    default property alias content: container.data

    clip: true
    implicitWidth: container.implicitWidth
    implicitHeight: block ? 0 : reveal ? container.implicitHeight : 0
    visible: implicitHeight > 0 || heightAnim.running

    Behavior on implicitHeight {
        NumberAnimation {
            id: heightAnim
            duration: root.duration
            easing.type: Easing.OutCirc
        }
    }

    ColumnLayout {
        id: container
        width: parent.width          // follows the revealer's width
        opacity: root.reveal ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: root.duration }
        }
    }
}