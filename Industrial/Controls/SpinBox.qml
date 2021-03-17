import QtQuick 2.9
import QtQuick.Templates 2.3 as T

T.SpinBox {
    id: control

    property int stepSizeDefault: 1
    property int stepSizeShift: 100
    property int stepSizeControl: 10000
    property bool mouseDown: false
    property bool mouseSlide: true
    property int startX: 0
    property int oldX: 0

    property bool vertical: false
    property bool isValid: text.length
    property color color: Theme.colors.text
    property bool round: false
    property string tipText

    property alias table: background.table
    property alias underline: background.underline
    property alias text: input.text
    property alias caution: background.caution
    property alias backgroundColor: background.color
    property alias labelText: background.text
    property alias flat: background.flat
    property alias labelFontPixelSize: background.fontPixelSize

    property QtObject _input: input

    signal finished()

    value: 0
    from: -100000
    to: 100000
    stepSize: stepSizeDefault

    implicitWidth: !vertical ? Theme.baseSize * 4 : Theme.baseSize
    implicitHeight: !vertical ? (labelText.length > 0 ? Theme.baseSize * 1.25 : Theme.baseSize) :
                                Theme.baseSize * 3

    leftPadding: !vertical ? down.indicator.width : 0
    rightPadding: !vertical ? up.indicator.width : 0
    bottomPadding: !vertical ? 0 : down.indicator.width
    topPadding: !vertical ? (labelText.length > 0 ? (Theme.auxFontSize / 1.2 - Theme.border) : 0) :
                            up.indicator.width

    font.pixelSize: Theme.mainFontSize
    editable: true
    clip: true

    validator: IntValidator {
        bottom: Math.min(control.from, control.to)
        top: Math.max(control.from, control.to)
    }

    function validate() {
        value = valueFromText(input.text, locale);
        caution = false;
        input.text = Qt.binding(function() { return control.textFromValue(value, locale) });
        mouseSlide = true;
    }

    onActiveFocusChanged: {
        if(activeFocus) {
            input.focus = true;
            input.selectAll();
        }
    }

    onFocusChanged: {
        stepSize = stepSizeDefault;
    }

    onFromChanged: {
        var newValue = control.valueFromText(text, control.locale);

        if (control.value !== newValue) {
            control.value = newValue;
        }
    }

    onToChanged: {
        var newValue = control.valueFromText(text, control.locale);

        if (control.value !== newValue) {
            control.value = newValue;
        }
    }

    background: BackgroundInput {
        id: background
        hovered: control.hovered
        highlighted: control.activeFocus
        isValid: control.isValid
        textPadding: down.indicator.width + Theme.padding
        spin: true
        highlighterHeight: !vertical ? Theme.underline : 0
        bottomCropping: !vertical ? radius : 0
    }

    MouseArea{
        id: mouseArea
        anchors.fill: contentItem
        cursorShape: Qt.SplitHCursor;

        onPressed: {
            if (!control.activeFocus) {
                mouseSlide = true;
                control.forceActiveFocus();
            }
            if (control.activeFocus && mouseSlide) {
                mouseDown = true;
            }
            else {
                mouse.accepted = false;
            }
            input.focus = false;
            startX = mouse.x;
            oldX = startX;
        }

        onPositionChanged: {
            if (mouseDown && mouseSlide) {
                if ((mouse.x - oldX) > 0) control.increase();
                else if ((mouse.x - oldX) < 0) control.decrease();
                oldX = mouse.x;
                control.valueModified();
            }
        }

        onReleased: {
            mouseDown = false;
            if (startX === oldX && mouseSlide) {
                mouseSlide = false;
                input.focus = true;
                input.forceActiveFocus();
                input.selectAll();
            }
        }

        onWheel: {
            if (!control.activeFocus) control.forceActiveFocus();
            if (wheel.angleDelta.y > 0) control.increase();
            else control.decrease();
            control.valueModified();
        }
    }

    contentItem: Item {
        anchors.left: !vertical ? down.indicator.right : parent.left
        anchors.top: !vertical ? parent.top : up.indicator.bottom
        anchors.right: !vertical ? up.indicator.left : parent.right
        anchors.bottom: !vertical ? parent.bottom : down.indicator.top

        NumericInput {
            id: input
            anchors.fill: parent
            topPadding: labelText.length > 0 ? (Theme.auxFontSize / 1.2 - Theme.border) : 0
            verticalAlignment: Text.AlignVCenter
            overwriteMode: false
            Binding on text {
                value: control.textFromValue(control.value, control.locale);
                when: !activeFocus;
            }
            onTextEdited: {
                control.value = control.valueFromText(text, control.locale);
            }
            onFinished: control.finished()
            onEditingFinished: {
                input.focus = false;
                control.validate();
                control.valueModified();
            }
            maximumLength: Math.max(from.toString().length, to.toString().length) + 1
            selectionColor: background.highlighterColor
            selectedTextColor: control.activeFocus ? Theme.colors.selectedText : Theme.colors.text
            validator: control.validator
        }
    }

    down.indicator: BackgroundItem {
        x: control.mirrored ? parent.width - width : 0
        y: !vertical ? 0 : parent.height - height
        width: !vertical ? Theme.baseSize : parent.width
        height: !vertical ? (parent.height - Theme.border) : Theme.baseSize
        radius: {
            if (round) return Math.min(width, height) / 2
            if (table) return 0
            return Theme.rounding
        }
        rightCropping: !vertical ? radius : 0
        bottomCropping: !vertical ? (round ? 0 : radius) : 0
        topCropping: !vertical ? 0 : radius
        color: down.pressed && enabled ? Theme.colors.selection : "transparent"
        hovered: down.hovered

        ColoredIcon {
            width: Theme.iconSize
            height: width
            anchors.centerIn: parent
            rotation: !vertical ? 0: -90
            source: {
                if (stepSize == stepSizeDefault) return "qrc:/icons/left.svg"
                if (stepSize == stepSizeShift) return "qrc:/icons/left_2.svg"
                if (stepSize == stepSizeControl) return "qrc:/icons/left_3.svg"
            }
            color: {
                if (down.pressed) return Theme.colors.highlightedText;
                if (down.hovered) return Theme.colors.text;
                if (!enabled) return Theme.colors.disabled;
                if (control.caution) return Theme.colors.neutral;
                if (!control.isValid) return Theme.colors.negative;
                return Theme.colors.description;
            }
        }
    }

    up.indicator: BackgroundItem {
        x: control.mirrored ? 0 : parent.width - width
        width: !vertical ? Theme.baseSize : parent.width
        height: !vertical ? (parent.height - Theme.border) : Theme.baseSize
        radius: {
            if (round) return Math.min(width, height) / 2
            if (table) return 0
            return Theme.rounding
        }
        leftCropping: !vertical ? radius : 0
        bottomCropping: round ? 0 : radius
        color: up.pressed && enabled ? Theme.colors.selection : "transparent"
        hovered: up.hovered

        ColoredIcon {
            width: Theme.iconSize
            height: width
            anchors.centerIn: parent
            rotation: !vertical ? 0: -90
            source: {
                if (stepSize == stepSizeDefault) return "qrc:/icons/right.svg"
                if (stepSize == stepSizeShift) return "qrc:/icons/right_2.svg"
                if (stepSize == stepSizeControl) return "qrc:/icons/right_3.svg"
            }
            color: {
                if (up.pressed) return Theme.colors.highlightedText;
                if (up.hovered) return Theme.colors.text;
                if (!enabled) return Theme.colors.disabled;
                if (control.caution) return Theme.colors.neutral;
                if (!control.isValid) return Theme.colors.negative;
                return Theme.colors.description;
            }
        }
    }

    Connections {
        target: up
        onPressedChanged: {
            if (!control.activeFocus) control.forceActiveFocus();
            control.valueModified();
        }
    }

    Connections {
        target: down
        onPressedChanged: {
            if (!control.activeFocus) control.forceActiveFocus();
            control.valueModified();
        }
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Shift) stepSize = stepSizeShift;
        if (event.key === Qt.Key_Control) stepSize = stepSizeControl;
        else return;
        event.accepted = true;
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Shift) stepSize = stepSizeDefault;
        if (event.key === Qt.Key_Control) stepSize = stepSizeDefault;
        else return;
        event.accepted = true;
    }

    textFromValue: function(value, locale) {
        return (value).toString()
    }

    valueFromText: function(text, locale) {
        var val = parseInt(text);
        if (val < from) return from;
        if (val > to) return to;

        return val;
    }
}
