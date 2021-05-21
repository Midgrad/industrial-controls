import QtQuick 2.6
import QtQuick.Layouts 1.3

import Industrial.Controls 1.0

Rectangle {
    id: control

    property bool expanded: false
    property bool selected: false
    property bool hovered: false
    property int amount: 0
    property color _selectedColor: Qt.hsla(Theme.colors.selection.hslHue,
                                         Theme.colors.selection.hslSaturation,
                                         Theme.colors.selection.hslLightness, 0.5)
    property color _hoveredColor: Qt.hsla(Theme.colors.highlight.hslHue,
                                         Theme.colors.highlight.hslSaturation,
                                         Theme.colors.highlight.hslLightness, 0.2)

    property alias expandEnabled: button.enabled
    property alias buttonText: button.text
    property alias labelText: label.text
    property alias amountVisible: amountLabel.visible
    property alias rightPadding: rightPaddingItem.width

    signal pressed()

    height: Theme.baseSize

    color: selected ? _selectedColor : hovered ? _hoveredColor : expanded ?
       Theme.colors.raised : "transparent"

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        propagateComposedEvents: true
        onPressed: {
            control.pressed();
            mouse.accepted = false;
        }
    }

    RowLayout {
        id: layout
        spacing: 0
        anchors.fill: parent

        Button {
            id: button
            flat: true
            horizontalAlignment: Text.AlignLeft
            iconSource: control.expanded ? "/icons/down.svg" : "/icons/right.svg"
            iconColor: control.selected ?
                           Qt.hsla(Theme.colors.selection.hslHue,
                                   Theme.colors.selection.hslSaturation,
                                   Theme.colors.selection.hslLightness, 0.5) :
                           Theme.colors.description

            onClicked: control.expanded = !control.expanded

            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                height: parent.height
                width: Theme.border
                color: control.selected ? Theme.colors.highlight
                                                : "transparent"
            }
            Layout.fillWidth: text.length
        }

        Label {
            id: label
            wrapMode: Text.Wrap
            visible: text.length
            Layout.fillWidth: visible
            Layout.fillHeight: true
            Layout.leftMargin: Theme.margins
        }

        Label {
            id: amountLabel
            font.pixelSize: Theme.auxFontSize
            color: Theme.colors.description
            text: "(" + amount + ")"
            visible: false
        }

        Item {
            id: rightPaddingItem
            width: 0
        }
    }
}
