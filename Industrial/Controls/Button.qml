import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.Button {
    id: control

    property var types: {
        "primary": 0,
        "secondary": 1,
        "red": 2,
        "yellow": 3,
        "green": 4,
        "link_primary": 5,
        "link_secondary": 6
    }

    property var type: types.primary

    property bool round: false
    property bool pressedImpl: false
    property bool topCropped: false
    property bool bottomCropped: false
    property bool leftCropped: false
    property bool rightCropped: false
    property bool toolTipAlwaysVisible: false
    property string tipText

    property color color: Theme.colors.control
    property color highlightColor: Theme.colors.highlight
    property color selectionColor: Theme.colors.selection
    property color disabledColor: Theme.colors.disabled

    property color textColor: Theme.colors.controlText
    property color highlightTextColor: Theme.colors.highlightedText
    property color selectionTextColor: Theme.colors.selectedText
    property color checkedTextColor: Theme.colors.selectedText
    property color disabledTextColor: Theme.colors.background

    property alias iconSource: content.iconSource
    property alias iconColor: content.iconColor
    property alias iconSize: content.iconSize
    property alias textSize: content.textSize
    property alias contentWidth: content.width
    property alias horizontalAlignment: content.horizontalAlignment
    property alias radius: backgroundItem.radius
    property alias backgroundOpacity: backgroundItem.opacity
    property alias hoverColor: backgroundItem.hoverColor
    property alias toolTipX: toolTip.x
    property alias toolTipY: toolTip.y
    property alias toolTipWidth: toolTip.width

    implicitWidth: Math.max(implicitHeight, content.implicitWidth + control.padding * 2)
    implicitHeight: Theme.baseSize
    focusPolicy: Qt.NoFocus
    hoverEnabled: true
    padding: text.length > 0 ? Theme.padding : 0
    font.pixelSize: Theme.mainFontSize

    background: BackgroundItem {
        id: backgroundItem
        hovered: control.hovered
        flat: control.flat
        radius: round ? Math.min(width, height) / 2 : Theme.rounding
        topCropping: topCropped ? radius : 0
        bottomCropping: bottomCropped ? radius : 0
        leftCropping: leftCropped ? radius : 0
        rightCropping: rightCropped ? radius : 0
        borderColor: control.activeFocus ? Theme.colors.highlight : "transparent"
        color: {
            if (!control.enabled) {
                if (control.flat) return "transparent";
                if (type === types.link_primary) return "transparent";
                if (type === types.link_secondary) return "transparent";
                return control.disabledColor;
            }
            if (control.pressed || control.pressedImpl) {
                if (type === types.primary) return control.highlightColor;
                if (type === types.secondary) return control.highlightColor;
                if (type === types.red) return Theme.colors.negative;
                if (type === types.yellow) return Theme.colors.neutral;
                if (type === types.green) return Theme.colors.positive;
                if (type === types.link_primary) return control.highlightColor;
                if (type === types.link_secondary) return control.highlightColor;
            }
            if (control.highlighted || control.checked) {
                if (type === types.primary) return control.selectionColor;
                if (type === types.secondary) return control.selectionColor;
                if (type === types.red) return Theme.colors.negative;
                if (type === types.yellow) return Theme.colors.neutral;
                if (type === types.green) return Theme.colors.positive;
                if (type === types.link_primary) return "transparent";
                if (type === types.link_secondary) return "transparent";
            }
            if (!control.flat) {
                if (type === types.link_primary) return "transparent";
                if (type === types.link_secondary) return "transparent";
                return control.color;
            } else return "transparent";
        }
        hoverColor: {
            if (type === types.primary) return control.highlightColor;
            if (type === types.secondary) return control.highlightColor;
            if (type === types.red) return Theme.colors.negative;
            if (type === types.yellow) return Theme.colors.neutral;
            if (type === types.green) return Theme.colors.positive;
            if (type === types.link_primary) return control.highlightColor;
            if (type === types.link_secondary) return control.highlightColor;
        }
    }

    contentItem: ContentItem {
        id: content
        anchors.fill: parent
        anchors.margins: control.padding
        text: control.text
        font: control.font
        textColor: {
            if (!enabled) return control.flat ? Theme.colors.disabled : control.disabledTextColor;
            if (control.pressed || control.pressedImpl) return control.highlightTextColor;
            if (control.highlighted || control.hovered) return control.textColor;
            if (control.checked) return control.checkedTextColor;
            if (control.flat) {
                if (type === types.primary) return Theme.colors.controlText;
                if (type === types.secondary) return Theme.colors.description;
                if (type === types.red) return Theme.colors.negative;
                if (type === types.yellow) return Theme.colors.neutral;
                if (type === types.green) return Theme.colors.positive;
                if (type === types.link_primary) return Theme.colors.controlText;
                if (type === types.link_secondary) return Theme.colors.description;
            }
            else {
                if (type === types.link_primary) return Theme.colors.controlText;
                if (type === types.link_secondary) return Theme.colors.description;
                return control.textColor;
            }
        }
    }

    ToolTip {
        id: toolTip
        visible: (toolTipAlwaysVisible || (control.hovered || control.down)) && tipText
        text: tipText
        delay: 0
    }
}
