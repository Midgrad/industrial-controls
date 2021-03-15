import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.ToolBar {
    id: control

    padding: Theme.padding

    background: Rectangle {
        color: Theme.colors.sunken

        Shadow {
            source: parent
        }
    }
}
