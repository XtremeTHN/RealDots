import QtQuick

Rectangle {
    property int padding: 0

    implicitWidth: children[0].implicitWidth + padding
    implicitHeight: children[0].implicitHeight + padding
}