import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.ToolBar {
    id: control

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             contentItem.implicitHeight + topPadding + bottomPadding)

    padding: Theme.padding

    background: Rectangle {
        color: Theme.colors.sunken

        Shadow {
            source: parent
        }
    }
}
