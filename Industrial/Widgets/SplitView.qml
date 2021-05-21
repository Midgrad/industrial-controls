import QtQuick 2.6
import QtQuick.Layouts 1.0
import Industrial.Controls 1.0 as Controls

Item {
    id: root

    property Component topItemDelegate: Item {}
    property Component bottomItemDelegate: Item {}
    property real minHandleY: 0
    property real maxHandleY: height - handle.height

    property alias currentHandleY: handle.y
    property alias handleHeight: handle.height
    property alias heightWidth: handle.width
    property alias handleColor: handleRectangle.color

    implicitHeight: topElement.item.implicitHeight + bottomElement.item.implicitHeight + handle.height

    Loader {
        id: topElement
        anchors.top: root.top
        anchors.bottom: handle.top
        anchors.left: root.left
        anchors.right: root.right
        sourceComponent: topItemDelegate
    }

    Item {
        id: handle
        height: Controls.Theme.sliderSize
        width: parent.width
        y: parent.height / 2 - height / 2

        Rectangle {
            id: handleRectangle
            anchors.fill: parent
            color: Controls.Theme.colors.sunken
        }

        Controls.ColoredIcon {
            id: icon
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: Controls.Theme.iconSize
            width: height
            color: Controls.Theme.colors.control
            source: "qrc:/icons/more.svg"
        }

        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.SizeVerCursor
            hoverEnabled: true
            drag.threshold: 0
            drag.target: handle
            drag.axis: Drag.YAxis
            drag.minimumY: minHandleY
            drag.maximumY: maxHandleY
        }
    }

    Loader {
        id: bottomElement
        anchors.top: handle.bottom
        anchors.bottom: root.bottom
        anchors.left: root.left
        anchors.right: root.right
        sourceComponent: bottomItemDelegate
    }
}
