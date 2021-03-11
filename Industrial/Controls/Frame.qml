import QtQuick 2.6
import QtQuick.Templates 2.2 as T

T.Frame {
    id: control

    property color backgroundColor: Theme.colors.background

    implicitWidth: Math.max(background ? background.implicitWidth : 0, contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0, contentHeight + topPadding + bottomPadding)

    contentWidth: contentItem.implicitWidth || (contentChildren.length === 1 ? contentChildren[0].implicitWidth : 0)
    contentHeight: contentItem.implicitHeight || (contentChildren.length === 1 ? contentChildren[0].implicitHeight : 0)

    padding: Theme.padding * 2

    background: Rectangle {
        id: backgroundRect
        color: backgroundColor

        Shadow {
            source: parent
        }
    }
}
