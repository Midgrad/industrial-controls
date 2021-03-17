import QtQuick 2.6
import QtQuick.Templates 2.4 as T

T.TabBar { // TODO: replace with model-based bar
    id: control

    property alias backgroundColor: backgroundRect.color

//    implicitWidth: Math.max(background ? background.implicitWidth : 0,
//                            contentWidth + leftPadding + rightPadding)
//    implicitHeight: Math.max(background ? background.implicitHeight : 0,
//                             contentHeight + topPadding + bottomPadding)

    spacing: 1

    contentItem: ListView {
        model: control.contentModel
        currentIndex: control.currentIndex

        spacing: control.spacing
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        flickableDirection: Flickable.AutoFlickIfNeeded
        snapMode: ListView.SnapToItem

        highlightMoveDuration: 0
        highlightRangeMode: ListView.ApplyRange
        preferredHighlightBegin: 40
        preferredHighlightEnd: width - 40
    }

    implicitWidth: Theme.baseSize * count * 6
    implicitHeight: Theme.baseSize

    background: Item {
        clip: true

        Rectangle {
            id: backgroundRect
            color: Theme.colors.sunken
            anchors.fill: parent
            radius: Theme.rounding
            anchors.bottomMargin: -radius
        }
    }
}
