import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Templates 2.4 as T

T.Popup {
    id: control

    property color backgroundColor: Theme.colors.raised

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentWidth > 0 ? contentWidth + leftPadding + rightPadding : 0)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             contentHeight > 0 ? contentHeight + topPadding + bottomPadding : 0)

    contentWidth: contentItem.implicitWidth || (contentChildren.length === 1 ? contentChildren[0].implicitWidth : 0)
    contentHeight: contentItem.implicitHeight || (contentChildren.length === 1 ? contentChildren[0].implicitHeight : 0)

    T.Overlay.modal: Rectangle {
        color: Qt.rgba(Theme.colors.shadow.r, Theme.colors.shadow.g, Theme.colors.shadow.b, Theme.colors.shadow.a * 0.5)
    }

    T.Overlay.modeless: Rectangle {
        color: Qt.rgba(Theme.colors.shadow.r, Theme.colors.shadow.g, Theme.colors.shadow.b, Theme.colors.shadow.a * 0.12)
    }

    padding: Theme.padding * 2
    clip: false

    background: Rectangle {
        id: backgroundRect
        color: backgroundColor
        radius: Theme.baseSize / 8

        Shadow {
            source: parent
            glowRadius: Theme.shadowSize * 4
            anchors.verticalCenterOffset: Theme.baseSize / 8
        }
    }
}
