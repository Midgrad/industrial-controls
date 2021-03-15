import QtQuick 2.6

import Industrial.Controls 1.0

Rectangle {
    id: root

    property alias glowRadius: shadow.glowRadius

    implicitWidth: Theme.baseSize * 0.25
    implicitHeight: width
    radius: width / 2

    Behavior on color { PropertyAnimation { duration: Theme.animationTime } }

    Shadow {
        id: shadow
        source: parent
        color: parent.color

        Behavior on glowRadius { PropertyAnimation { duration: Theme.animationTime } }
    }
}

