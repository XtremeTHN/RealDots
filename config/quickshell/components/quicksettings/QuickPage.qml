import QtQuick
import QtQuick.Layouts
import "../"
import "../../constants"


Rectangle {
    id: root
    property string title
    color: Colors.background
    radius: 16

    ColumnLayout {
        width: root.width

        RowLayout {
            Layout.alignment: Qt.AlignTop
            // Layout.margins: 15
            Layout.topMargin: 20
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            Layout.bottomMargin: 15
            spacing: 20

            Icon {
                Layout.alignment: Qt.AlignCenter
                icon_name: getLocalIcon("left")
                color: Colors.on_background
                implicitSize: 26
            }

            Text {
                Layout.alignment: Qt.AlignCenter
                font.pixelSize: 18
                font.weight: 500
                font.family: "Roboto"
                
                color: Colors.on_background
                text: root.title
            }
        }

        Rectangle {
            Layout.fillWidth: true
            color: Colors.outline_variant
            implicitHeight: 1
        }
    }
}