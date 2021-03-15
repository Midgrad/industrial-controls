import QtQuick 2.6
import QtQuick.Controls 2.4 as T

import Industrial.Controls 1.0

T.Dialog {
    id: control

    property color backgroundColor: Theme.colors.raised

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            header && header.visible ? header.implicitWidth : 0,
                            footer && footer.visible ? footer.implicitWidth : 0,
                            contentWidth > 0 ? contentWidth + leftPadding + rightPadding : 0)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             (header && header.visible ? header.implicitHeight + spacing : 0)
                             + (footer && footer.visible ? footer.implicitHeight + spacing : 0)
                             + (contentHeight > 0 ? contentHeight + topPadding + bottomPadding : 0))

    contentWidth: contentItem.implicitWidth || (contentChildren.length === 1 ? contentChildren[0].implicitWidth : 0)
    contentHeight: contentItem.implicitHeight || (contentChildren.length === 1 ? contentChildren[0].implicitHeight : 0)

    padding: Theme.padding
    clip: false

    background: Rectangle {
        color: backgroundColor
        radius: 2

        Shadow {
            source: parent
        }
    }

    header: Label {
            text: control.title
            visible: control.title
            elide: Label.ElideRight
            font.bold: true
            padding: 12
            background: Rectangle {
                x: 1; y: 1
                width: parent.width - 2
                height: parent.height - 1
                color: Theme.colors.sunken
            }
        }

    footer: DialogButtonBox {}

    T.Overlay.modal: Rectangle {
        color: Qt.rgba(Theme.colors.shadow.r, Theme.colors.shadow.g, Theme.colors.shadow.b, Theme.colors.shadow.a * 0.5)
    }

    T.Overlay.modeless: Rectangle {
        color: Qt.rgba(Theme.colors.shadow.r, Theme.colors.shadow.g, Theme.colors.shadow.b, Theme.colors.shadow.a * 0.12)
    }
}
