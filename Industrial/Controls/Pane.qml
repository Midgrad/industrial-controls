import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.Pane {
    id: control

    property color backgroundColor: Theme.colors.background
    property int radius: Theme.rounding

    property bool topCropped: false
    property bool bottomCropped: false
    property bool leftCropped: false
    property bool rightCropped: false

    implicitWidth: Math.max(background ? background.implicitWidth : 0, contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0, contentHeight + topPadding + bottomPadding)

    contentWidth: contentItem.implicitWidth || (contentChildren.length === 1 ? contentChildren[0].implicitWidth : 0)
    contentHeight: contentItem.implicitHeight || (contentChildren.length === 1 ? contentChildren[0].implicitHeight : 0)

    padding: Theme.padding * 2
    focusPolicy: Qt.ClickFocus

    background: Item {
        anchors.fill: parent
        clip: true

        Rectangle {
            id: background
            anchors.fill: parent
            anchors.topMargin: topCropped ? -radius : 0
            anchors.bottomMargin: bottomCropped ? -radius : 0
            anchors.leftMargin: leftCropped ? -radius : 0
            anchors.rightMargin: rightCropped ? -radius : 0
            radius: control.radius
            color: control.backgroundColor
        }
    }
}
