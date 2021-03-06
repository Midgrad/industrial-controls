import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.MenuItem {
    id: control

    property string iconSource: ""
    property bool selected: false

    property alias textColor: label.color
    property alias iconColor: icon.color
    property alias horizontalAlignment: label.horizontalAlignment

    implicitWidth: label.implicitWidth + leftPadding + rightPadding
    implicitHeight: Theme.baseSize
    height: visible ? implicitHeight : 0

    focusPolicy: Qt.NoFocus
    padding: Theme.padding
    leftPadding: icon.source == "" ? Theme.padding * 2 : icon.x + icon.width + Theme.padding
    rightPadding: Theme.padding * 2
    font.pixelSize: Theme.mainFontSize
    hoverEnabled: true

    background: BackgroundItem {
        radius: 0
        hovered: control.hovered
        color: {
            if (selected) return Theme.colors.selection;
            if (control.pressed) return Theme.colors.highlight;
            return "transparent";
        }
    }

    indicator: ColoredIcon {
        id: icon
        x: control.padding
        y: control.padding
        source: {
            if (!checkable) return control.iconSource;
            if (control.checked) return control.iconSource.length > 0 ? control.iconSource: "qrc:/icons/ok.svg";
            return "";
        }
        height: Theme.iconSize
        width: height
        color: {
            if (!enabled) return Theme.colors.disabled;
            if (control.pressed) return Theme.colors.highlightedText;
            if (selected || (checked && selected)) return Theme.colors.selectedText;
            if (checked) return Theme.colors.highlight;
            return Theme.colors.description;
        }
    }

    contentItem: Label {
        id: label
        font: control.font
        text: control.text
        color: {
            if (!enabled) return Theme.colors.disabled;
            if (control.pressed) return Theme.colors.highlightedText;
            if (selected || (checked && selected)) return Theme.colors.selectedText;
            return Theme.colors.text;
        }
    }
}
