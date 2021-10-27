import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0

Item {
    id: control

    property alias borderWidth: backgraund.borderWidth
    property alias borderColor: backgraund.borderColor
    property alias radius: backgraund.radius
    property alias color: backgraund.color
    property alias hoverColor: backgraund.hoverColor

    property alias iconColor: icon.iconColor
    property alias iconSource: icon.iconSource

    property alias labelText: label.text
    property alias labelType: label.type
    property alias labelFont: label.font
    property alias labelSize: label.font.pixelSize
    property alias horizontalAlignment: label.horizontalAlignment

    property alias amountType: amountLabel.type
    property alias amountFont: amountLabel.font
    property alias amountSize: amountLabel.font.pixelSize
    property alias amountVisible: amountLabel.visible

    property bool expanded: false
    property bool selected: false
    property bool hovered: false
    property color labelColor: Theme.colors.text
    property int amount: 0
    property int leftPadding: 0
    property int rightPadding: Theme.padding * 2

    implicitHeight: Theme.baseSize

    signal clicked()

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        propagateComposedEvents: true
        hoverEnabled: true
        onEntered: hovered = true;
        onExited: hovered = false;

        onPressed: {
            control.clicked();
            mouse.accepted = false;
        }
    }

    BackgroundItem {
        id: backgraund
        anchors.fill: parent
        color: selected ? Theme.colors.selection : expanded ? Theme.colors.line : "transparent"
        hovered: control.hovered && !control.selected
    }

    RowLayout {
        id: layout
        spacing: 0
        anchors.fill: parent
        anchors.leftMargin: leftPadding
        anchors.rightMargin: rightPadding

        ContentItem {
            id: icon
            iconSource: control.expanded ? "/icons/down.svg" : "/icons/right.svg"
            iconColor: control.selected ? Theme.colors.controlText : Theme.colors.description
            Layout.preferredWidth: Theme.baseSize
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
