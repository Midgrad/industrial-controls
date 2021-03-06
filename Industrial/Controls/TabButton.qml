import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.TabButton {
    id: control

    property bool flat: false
    property color backgroundColor: Theme.colors.background
    property alias iconSource: content.iconSource
    property alias iconColor: content.iconColor
    property alias iconSize: content.iconSize
    property alias textColor: content.textColor

    font.pixelSize: Theme.auxFontSize
    font.weight: Font.Bold
    font.capitalization: Font.AllUppercase
    implicitWidth: Math.max(Theme.baseSize, contentItem.implicitWidth + control.padding * 2)
    implicitHeight: Theme.baseSize
    focusPolicy: Qt.NoFocus
    hoverEnabled: true
    padding: Theme.padding

    background: BackgroundItem {
        id: backgroundItem
        bottomCropping: radius
        borderColor: control.activeFocus ? Theme.colors.highlight : "transparent"
        hovered: !control.checked && control.hovered
        color: !control.flat && control.checked ? backgroundColor : "transparent"

        Rectangle {
            id: highlighter
            anchors.bottom: parent.bottom
            width: parent.width
            height: Theme.border
            visible: control.flat
            color: control.textColor
        }
    }

    contentItem: ContentItem {
        id: content
        text: control.text
        font: control.font
        textColor: {
            if (!enabled) return Theme.colors.disabled;
            if (control.checked) return Theme.colors.text;
            if (control.hovered) return Theme.colors.text;
            return Theme.colors.description;
        }
    }
}
