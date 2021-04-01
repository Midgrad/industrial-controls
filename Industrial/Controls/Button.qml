import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.Button {
    id: control

    //type
    //type: "primary"
    //type: "secondary"
    //type: "red"
    //type: "yellow"
    //type: "green"
    property string type: "primary"

    property bool round: false
    property bool pressedImpl: false
    property bool topCropped: false
    property bool bottomCropped: false
    property bool leftCropped: false
    property bool rightCropped: false
    property bool toolTipAlwaysVisible: false
    property color color: Theme.colors.control
    property color highlightColor: Theme.colors.highlight
    property color selectionColor: Theme.colors.selection
    property color disabledColor: Theme.colors.disabled
    property string tipText

    property alias iconSource: content.iconSource
    property alias iconColor: content.iconColor
    property alias iconSize: content.iconSize
    property alias textSize: content.textSize
    property alias textColor: content.textColor
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
            if (!control.enabled) return control.flat ? "transparent" : control.disabledColor;
            //if (control.pressed || control.pressedImpl) return control.highlightColor; //////////////////////////////////////////////
            if (control.pressed || control.pressedImpl) {
                if (type === "primary") return control.highlightColor;
                if (type === "secondary") return control.highlightColor;
                if (type === "red") return Theme.colors.negative;
                if (type === "yellow") return Theme.colors.neutral;
                if (type === "green") return Theme.colors.positive;
            }
            //if (control.highlighted || control.checked) return control.selectionColor; /////////////////////////////////////////
            if (control.highlighted || control.checked) {
                if (type === "primary") return control.selectionColor;
                if (type === "secondary") return control.selectionColor;
                if (type === "red") return Theme.colors.negative;
                if (type === "yellow") return Theme.colors.neutral;
                if (type === "green") return Theme.colors.positive;
            }
            return control.flat ? "transparent" : control.color; /////////////////////////////////
            /*
            if (control.flat) { return "transparent"; } else {
                if (type === "primary") return control.color;
                if (type === "secondary") return control.color;
                if (type === "red") return Theme.colors.negative;
                if (type === "yellow") return Theme.colors.neutral;
                if (type === "green") return Theme.colors.positive;
            }
            */
        }
        hoverColor: {
            if (type === "primary") return Theme.colors.highlight;
            if (type === "secondary") return Theme.colors.highlight;
            /*
            if (type === "red") return !control.flat ? "#ffffff" : Theme.colors.negative;
            if (type === "yellow") return !control.flat ? "#ffffff" : Theme.colors.neutral;
            if (type === "green") return !control.flat ? "#ffffff" : Theme.colors.positive;
            */
            if (type === "red") return Theme.colors.negative;
            if (type === "yellow") return Theme.colors.neutral;
            if (type === "green") return Theme.colors.positive;
        }
    }

    contentItem: ContentItem {
        id: content
        anchors.fill: parent
        anchors.margins: control.padding
        text: control.text
        font: control.font
        textColor: {
            if (!enabled) return control.flat ? Theme.colors.disabled : Theme.colors.background;
            if (control.pressed || control.pressedImpl) return Theme.colors.highlightedText;
            if (control.checked) return Theme.colors.selectedText;
            if (control.highlighted || control.hovered) return Theme.colors.controlText;
            //return Theme.colors.controlText; /////////////////////////////////////////////////////////
            if (control.flat) {
                if (type === "primary") return Theme.colors.controlText;
                if (type === "secondary") return Theme.colors.description;
                if (type === "red") return Theme.colors.negative;
                if (type === "yellow") return Theme.colors.neutral;
                if (type === "green") return Theme.colors.positive;
            } else { return Theme.colors.controlText; }
        }
    }

    ToolTip {
        id: toolTip
        visible: (toolTipAlwaysVisible || (control.hovered || control.down)) && tipText
        text: tipText
        delay: 0
    }
}
