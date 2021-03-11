import QtQuick 2.6
import QtQuick.Templates 2.2 as T

T.DialogButtonBox {
    id: control

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             contentItem.implicitHeight + topPadding + bottomPadding)

    spacing: Theme.spacing
    padding: Theme.padding

    alignment: count === 1 ? Qt.AlignRight : undefined

    contentItem: ListView {
        implicitWidth: control.count === 1 ? 200 : contentWidth
        implicitHeight: 40

        model: control.contentModel
        spacing: control.spacing
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        snapMode: ListView.SnapToItem
    }

    background: Rectangle {
        color: backgroundColor
    }

    delegate: Button {
        width: (control.width - control.padding * 2 - Theme.spacing) / control.count
    }
}

