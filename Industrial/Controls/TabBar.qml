import QtQuick 2.6
import QtQuick.Controls 2.2 as T


T.TabBar { // TODO: replace with model-based bar
    id: control

    implicitWidth: Theme.baseSize * count * 6
    implicitHeight: Theme.baseSize

    background: Item {
        clip: true

        Rectangle {
            id: bg
            color: Theme.colors.sunken
            anchors.fill: parent
            radius: Theme.rounding
            anchors.bottomMargin: -radius
        }
    }
}
