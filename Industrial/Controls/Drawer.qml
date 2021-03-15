import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.Drawer {
    id: control

    parent: T.Overlay.overlay

    implicitWidth: Math.max(background ? background.implicitWidth : 0, contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0, contentHeight + topPadding + bottomPadding)

    contentWidth: contentItem.implicitWidth || (contentChildren.length === 1 ? contentChildren[0].implicitWidth : 0)
    contentHeight: contentItem.implicitHeight || (contentChildren.length === 1 ? contentChildren[0].implicitHeight : 0)

    topPadding: control.edge === Qt.BottomEdge
    leftPadding: control.edge === Qt.RightEdge
    rightPadding: control.edge === Qt.LeftEdge
    bottomPadding: control.edge === Qt.TopEdge

    enter: Transition { SmoothedAnimation { velocity: 5 } }
    exit: Transition { SmoothedAnimation { velocity: 5 } }

    T.Overlay.modal: Rectangle {
        color: Qt.rgba(Theme.colors.shadow.r, Theme.colors.shadow.g, Theme.colors.shadow.b, Theme.colors.shadow.a * 0.5)
    }

    T.Overlay.modeless: Rectangle {
        color: Qt.rgba(Theme.colors.shadow.r, Theme.colors.shadow.g, Theme.colors.shadow.b, Theme.colors.shadow.a * 0.12)
    }

    closePolicy: T.Popup.NoAutoClose
    modal: false
    dragMargin: 0

    background: Rectangle {
        color: Theme.colors.sunken

        Shadow {
            source: parent
        }
    }
}
