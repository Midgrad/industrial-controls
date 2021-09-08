import QtQuick 2.6
import QtQuick.Layouts 1.3

import Industrial.Controls 1.0

Rectangle {
    id: control

    property bool expanded: false
    property bool selected: false
    property bool hovered: false
    property int amount: 0
    property int leftPadding: 0
    property int rightPadding: 0

    property alias expandEnabled: button.enabled //TODO: удалить параметр
    property alias buttonText: button.text
    property alias labelText: label.text
    property alias amountVisible: amountLabel.visible

    signal pressed()

    height: Theme.baseSize
    radius: Theme.rounding

    color: selected ? Theme.colors.selection : hovered ? Theme.colors.hover : expanded ?
       Theme.colors.line : "transparent"

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
        anchors.leftMargin: leftPadding
        anchors.rightMargin: rightPadding

        Button {
            id: button
            iconSource: control.expanded ? "/icons/down.svg" : "/icons/right.svg"
            iconColor: control.selected ? Theme.colors.controlText : Theme.colors.description
            hoverEnabled: false
            highlightColor: "transparent"
            flat: true
            enabled: false
        }

        Label {
            id: label
            type: Theme.Text
            wrapMode: Text.Wrap
            visible: text.length
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Label {
            id: amountLabel
            type: Theme.Label
            color: control.selected ? Theme.colors.text :Theme.colors.description
            text: "(" + amount + ")"
            visible: false
        }
    }
}
