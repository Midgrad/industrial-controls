import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.Button {
    id: control

    enum Type {
        Primary,
        Secondary,
        Negative,
        Neutral,
        Positive,
        LinkPrimary,
        LinkSecondary
    }

    property int type: Button.Type.Primary

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
            if (!control.enabled)
                return control.flat ? "transparent" : control.disabledColor;

            switch (control.type) {
            case Button.Type.Primary: // no break
            case Button.Type.Secondary:
                if (control.pressed || control.pressedImpl)
                    return control.highlightColor;
                if (control.highlighted || control.checked)
                    return control.selectionColor;
                break;
            case Button.Type.Negative:
                if (control.pressed || control.pressedImpl || control.highlighted || control.checked)
                    return control.negative;
                break;
            case Button.Type.Neutral:
                if (control.pressed || control.pressedImpl || control.highlighted || control.checked)
                    return control.neutral;
                break;
            case Button.Type.Positive:
                if (control.pressed || control.pressedImpl || control.highlighted || control.checked)
                    return control.positive;
                break;
            }

            return control.flat ? "transparent" : control.color;
        }
        hoverColor: {
            switch (control.type) {
            case Button.Type.Primary: // no break
            case Button.Type.Secondary:
                return Theme.colors.highlight;
            case Button.Type.Negative:
                return Theme.colors.negative;
            case Button.Type.Neutral:
                return Theme.colors.neutral;
            case Button.Type.Positive:
                return Theme.colors.positive;
            }
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
                switch (control.type) {
                case Button.Type.Primary:
                case Button.Type.LinkPrimary:
                    return Theme.colors.controlText;
                case Button.Type.Secondary:
                case Button.Type.LinkSecondary:
                    return Theme.colors.description;
                case Button.Type.Negative:
                    return Theme.colors.negative;
                case Button.Type.Neutral:
                    return Theme.colors.neutral;
                case Button.Type.Positive:
                    return Theme.colors.positive;
                }
            } else {
                if (type === Button.Type.LinkPrimary)
                    return Theme.colors.controlText;
                else if (type === Button.Type.LinkSecondary)
                    return Theme.colors.description;
                return Theme.colors.controlText;
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
