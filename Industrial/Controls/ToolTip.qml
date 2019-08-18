import QtQuick 2.6
import QtQuick.Controls 2.2 as T

T.ToolTip {
    id: control

    contentItem: Label {
        text: control.text
        font: control.font
        color: Industrial.colors.tipText
        horizontalAlignment: Qt.AlignHCenter
    }

    background: Rectangle {
        color: Industrial.colors.tip
        radius: 3

        MouseArea {
            anchors.fill: parent
            onPressed: control.close()
        }
    }
}
