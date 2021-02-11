import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0 as Controls

Rectangle {
    id: control

    property bool expanded: false
    property bool selected: false
    property bool hovered: false
    property int amount: 0
    property color _selectedColor: Qt.hsla(Controls.Theme.colors.selection.hslHue,
                                         Controls.Theme.colors.selection.hslSaturation,
                                         Controls.Theme.colors.selection.hslLightness, 0.5)
    property color _hoveredColor: Qt.hsla(Controls.Theme.colors.highlight.hslHue,
                                         Controls.Theme.colors.highlight.hslSaturation,
                                         Controls.Theme.colors.highlight.hslLightness, 0.2)
    property alias text: label.text
    property alias amountVisible: amountLabel.visible
    property alias rightPadding: rightPaddingItem.width

    signal mouseAreaPressed()

    height: Controls.Theme.baseSize

    color: selected ? _selectedColor : hovered ? _hoveredColor : expanded ?
       Controls.Theme.colors.raised : "transparent"

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        propagateComposedEvents: true
        onPressed: {
            control.mouseAreaPressed()
            mouse.accepted = false
        }
    }

    RowLayout {
        id: layout
        anchors.fill: parent

        Controls.Button {
            id: button
            flat: true
            iconSource: control.expanded ? "/icons/down.svg"
                                                 : "/icons/right.svg"
            iconColor: control.selected ?
                           Qt.hsla(Controls.Theme.colors.selection.hslHue,
                              Controls.Theme.colors.selection.hslSaturation,
                              Controls.Theme.colors.selection.hslLightness, 0.5) :
                           Controls.Theme.colors.description

            onClicked: control.expanded = !control.expanded

            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                height: parent.height
                width: Controls.Theme.border
                color: control.selected ? Controls.Theme.colors.highlight
                                                : "transparent"
            }
        }

        Controls.Label {
            id: label
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: Controls.Theme.margins
            wrapMode: Text.Wrap
        }

        Controls.Label {
            id: amountLabel
            font.pixelSize: Controls.Theme.auxFontSize
            color: Controls.Theme.colors.description
            text: "(" + amount + ")"
            visible: false
        }

        Item {
            id: rightPaddingItem
            width: 0
        }
    }
}
