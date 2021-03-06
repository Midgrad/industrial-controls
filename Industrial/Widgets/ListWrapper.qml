import QtQuick 2.6
import Industrial.Controls 1.0 as Controls

Rectangle {
    id: listRoot

    property string emptyText: qsTr("No items")
    property int offset: 2
    property var faderColor: undefined

    property alias list: list
    property alias contentY: list.contentY
    property alias spacing: list.spacing
    property alias model: list.model
    property alias header: list.header
    property alias footer: list.footer
    property alias highlight: list.highlight
    property alias delegate: list.delegate
    property alias currentIndex: list.currentIndex
    property alias count: list.count

    property bool alwaysShowFooterFader: false

    function toBeginning() { list.positionViewAtBeginning() }
    function toIndex(index, mode = ListView.Contain) { list.positionViewAtIndex(index, mode) }
    function toEnd() { list.positionViewAtEnd() }

    implicitWidth: list.contentWidth
    implicitHeight: Math.max(list.contentHeight, Controls.Theme.baseSize)
    color: "transparent"
    radius: Controls.Theme.rounding
    clip: true

    ListView {
        id: list
        anchors.fill: parent
        headerPositioning: ListView.OverlayHeader
        footerPositioning: ListView.OverlayFooter
        flickableDirection: Flickable.AutoFlickIfNeeded
        boundsBehavior: Flickable.StopAtBounds
        highlightResizeDuration: 0
        currentIndex: -1
        highlightMoveDuration: Controls.Theme.animationTime
        property bool showFooter: true

        onContentYChanged: {
            var currentBottomIndex = indexAt(1, contentY + height - Controls.Theme.baseSize)
            list.showFooter = currentBottomIndex + 1 !== listRoot.count
        }

        Controls.ScrollBar.vertical: Controls.ScrollBar {
            visible: list.contentHeight > list.height
        }

        header: ListFader {
            width: parent.width
            faderOffset: offset
            faderHeight: list.contentY
            visible: list.count > 0

            Binding on faderColor {
                when: listRoot.faderColor !== undefined
                value: listRoot.faderColor
            }
        }

        footer: ListFader {
            visible: list.count > 0 && (listRoot.alwaysShowFooterFader || list.showFooter)
            width: parent.width
            faderOffset: offset
            faderHeight: (list.contentHeight - list.height) - list.contentY
            mirrored: true

            Binding on faderColor {
                when: listRoot.faderColor !== undefined
                value: listRoot.faderColor
            }
        }

        Controls.Label {
            anchors.centerIn: parent
            text: emptyText
            type: Controls.Theme.Label
            visible: list.count === 0
        }
    }
}
