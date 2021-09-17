import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.Button {
    id: control

    property int type: Theme.Primary

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
    property alias borderColor: backgroundItem.borderColor
    property alias borderWidth: backgroundItem.borderWidth
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
        borderColor: {
            if (control.activeFocus) return Theme.colors.highlight;
            if (control.type === Theme.Secondary) {
                if (!control.enabled)
                    return control.flat ? "transparent" : control.disabledColor;
                if (control.pressed || control.pressedImpl || control.highlighted ||
                    control.checked || control.flat)
                    return "transparent";
                return Theme.colors.controlBorder;
            }
            return "transparent";
        }
        color: {
            if (!control.enabled) {
                if (control.type === Theme.Secondary) return "transparent";
                if (control.type === Theme.LinkPrimary) return "transparent";
                if (control.type === Theme.LinkSecondary) return "transparent";
                return control.flat ? "transparent" : control.disabledColor;
            }

            switch (control.type) {
            case Theme.Primary:
                if (control.pressed || control.pressedImpl)
                    return control.highlightColor;
                if (control.highlighted || control.checked)
                    return control.selectionColor;
                break;
            case Theme.Secondary:
                if (control.pressed || control.pressedImpl)
                    return control.highlightColor;
                if (control.highlighted || control.checked)
                    return control.selectionColor;
                return "transparent";
            case Theme.LinkPrimary: // no break
            case Theme.LinkSecondary:
                if (control.pressed || control.pressedImpl)
                    return control.highlightColor;
                if (control.highlighted || control.checked)
                    return "transparent";
                break;
            case Theme.Negative:
                if (control.pressed || control.pressedImpl || control.highlighted || control.checked)
                    return Theme.colors.negative;
                break;
            case Theme.Neutral:
                if (control.pressed || control.pressedImpl || control.highlighted || control.checked)
                    return Theme.colors.neutral;
                break;
            case Theme.Positive:
                if (control.pressed || control.pressedImpl || control.highlighted || control.checked)
                    return Theme.colors.positive;
                break;
            }

            if (!control.flat) {
                if (control.type === Theme.LinkPrimary) return "transparent";
                if (control.type === Theme.LinkSecondary) return "transparent";
                return control.color;
            }

            return "transparent";
        }
        hoverColor: {
            switch (control.type) {
            case Theme.Primary: // no break
            case Theme.Secondary: // no break
            case Theme.LinkPrimary: // no break
            case Theme.LinkSecondary:
                return Theme.colors.highlight;
            case Theme.Negative:
                return Theme.colors.negative;
            case Theme.Neutral:
                return Theme.colors.neutral;
            case Theme.Positive:
                return Theme.colors.positive;
            }

            return "transparent";
        }
    }

    contentItem: ContentItem {
        id: content
        anchors.fill: parent
        anchors.margins: control.padding
        text: control.text
        font: control.font
        textColor: {
            if (!enabled) {
                if (control.type === Theme.Secondary) return control.disabledColor;
                if (control.type === Theme.LinkPrimary) return control.disabledColor;
                if (control.type === Theme.LinkSecondary) return control.disabledColor;
                return control.flat ? control.disabledColor : control.disabledTextColor;
            }
            if (control.pressed || control.pressedImpl) return control.highlightTextColor;
            if (control.highlighted || control.hovered) return control.textColor;
            if (control.checked) return control.checkedTextColor;
            if (control.flat) {
                switch (control.type) {
                case Theme.Primary:
                case Theme.LinkPrimary:
                    return Theme.colors.controlText;
                case Theme.Secondary:
                case Theme.LinkSecondary:
                    return Theme.colors.description;
                case Theme.Negative:
                    return Theme.colors.negative;
                case Theme.Neutral:
                    return Theme.colors.neutral;
                case Theme.Positive:
                    return Theme.colors.positive;
                }
            } else {
                switch (control.type) {
                case Theme.Secondary:
                    return Theme.colors.description;
                case Theme.LinkPrimary:
                    return Theme.colors.controlText;
                case Theme.LinkSecondary:
                    return Theme.colors.description;
                }
            }
            return Theme.colors.controlText;
        }
    }

    ToolTip {
        id: toolTip
        visible: (toolTipAlwaysVisible || (control.hovered || control.down)) && tipText
        text: tipText
        delay: 0
    }
}
