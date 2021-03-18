import QtQuick 2.6

import Industrial.Controls 1.0

Label {
    id: control

    onLinkActivated: Qt.openUrlExternally(link)
    linkColor: Theme.colors.link

    MouseArea {
        anchors.fill: control
        acceptedButtons: Qt.NoButton
        cursorShape: control.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
    }
}
