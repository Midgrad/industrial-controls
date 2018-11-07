import QtQuick 2.6
import QtQuick.Controls 2.2 as T

T.Popup {
    id: control

    property color backgroundColor: Theme.containerColor

    padding: Theme.padding

    background:  Rectangle {
        color: backgroundColor
        radius: 2

        Shadow {
            source: parent
        }
    }
}
