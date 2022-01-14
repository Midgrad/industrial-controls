import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.Control {
    id: control

    property bool editable: true
    property bool round: false
    property color color: Theme.colors.text

    property bool isValid: !isNaN(value)
    property real precision: 2
    property real stepSize: 1 / Math.pow(10, precision)
    property real value: 0
    property real from: Number.MIN_VALUE
    property real to: Number.MAX_VALUE

    property real stepSizeDefault: 1
    property real stepSizeTwo: 10
    property real stepSizeThree: 100

    property real _stepSizeModifier: stepSizeDefault
    property real _stepSizeImpl: _stepSizeModifier * stepSize
    property bool _mouseDown: false
    property bool _mouseSlide: true
    property int _startX: 0
    property int _oldX: 0

    readonly property bool _increaseEnabled: value < to
    readonly property bool _decreaseEnabled: value > from

    property alias table: background.table
    property alias underline: background.underline
    property alias caution: background.caution
    property alias backgroundColor: background.color
    property alias labelText: background.text
    property alias labelFontPixelSize: background.fontPixelSize
    property alias flat: background.flat

    property var validator: DoubleValidator {
        decimals: control.precision
        bottom: control.from
        top: control.to
        locale: "en_EN"
        notation: DoubleValidator.StandardNotation
    }

    signal valueModified(real value)

    function finishInput() {
        var newValue = valueFromText(input.text);
        rebind();
        return newValue;
    }

    function valueFromText(text) { return Math.min(to, Math.max(from, parseFloat(text))); }

    function textFromValue(value) {
        var decimals = Math.pow(10, precision);
        return (Math.round(value * decimals) / decimals).toFixed(precision);
    }

    function increase() { modify(finishInput() + _stepSizeImpl); }
    function decrease() { modify(finishInput() - _stepSizeImpl); }

    function modify(newValue) {
        var eps = Math.pow(0.1, precision + 1);
        if (Math.abs(value - newValue) < eps)
            return;

        value = newValue;
        valueModified(value);
    }

    function rebind() {
        caution = false;
        _mouseSlide = true;
        input.text = Qt.binding(function() { return control.textFromValue(value); });
    }

    Component.onCompleted: rebind()

    // TODO: key codes to config
    Keys.onPressed: {
        if (event.key === Qt.Key_Z) _stepSizeModifier = stepSizeTwo;
        else if (event.key === Qt.Key_X) _stepSizeModifier = stepSizeThree;
        else return;
        event.accepted = true;
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Z || event.key === Qt.Key_X) _stepSizeModifier = stepSizeDefault;
        else return;
        event.accepted = true;
    }

    clip: true
    implicitWidth: Math.max(background.implicitWidth, row.height)
    implicitHeight: labelText.length > 0 ? Theme.baseSize * 1.25 : Theme.baseSize
    font.pixelSize: Theme.mainFontSize

    background: BackgroundInput {
        id: background
        hovered: control.hovered
        anchors.fill: parent
        highlighted: input.focus
        isValid: control.isValid
        textAlignment: Text.AlignHCenter
    }

    contentItem: RowLayout {
        id: row
        spacing: 1

        Button {
            id: downButton
            flat: true
            round: control.round
            highlightColor: Theme.colors.selection
            autoRepeat: true
            focusPolicy: Qt.NoFocus
            enabled: _decreaseEnabled
            rightCropped: true
            bottomCropped: true
            iconSource: {
                if (_stepSizeModifier === stepSizeThree) return "qrc:/icons/left_3.svg"
                if (_stepSizeModifier === stepSizeTwo) return "qrc:/icons/left_2.svg"
                return "qrc:/icons/left.svg"
            }
            iconColor: {
                if (!enabled) return Theme.colors.disabled;
                if (pressed) return Theme.colors.highlightedText;
                if (hovered) return Theme.colors.text;
                if (control.caution) return Theme.colors.neutral;
                if (!control.isValid) return Theme.colors.negative;
                return Theme.colors.description;
            }
            onClicked: if (editable) control.decrease();
            Layout.fillHeight: true
            Layout.bottomMargin: background.highlighterHeight
        }

        NumericInput {
            id: input
            topPadding: labelText.length > 0 ? (Theme.auxFontSize / 1.2 - Theme.border) : 0
            verticalAlignment: Text.AlignVCenter
            overwriteMode: false
            onEditingFinished: modify(finishInput())
            onTextEdited: caution = true;
            onActiveFocusChanged: if (!activeFocus && caution) rebind()
            selectionColor: background.highlighterColor
            selectedTextColor: control.activeFocus ? Theme.colors.selectedText : Theme.colors.text
            validator: control.validator
            Keys.onPressed: {
                switch(event.key) {
                case Qt.Key_Up:
                    control.increase();
                    break;
                case Qt.Key_Down:
                    control.increase();
                    break;
                default:
                    return;
                }
                event.accepted = true;
            }
            Layout.fillWidth: true
            Layout.fillHeight: true

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                cursorShape: editable ? Qt.SplitHCursor : Qt.IBeamCursor;

                onPressed: {
                    if (!control.activeFocus) {
                        _mouseSlide = true;
                        control.forceActiveFocus();
                    }
                    if (control.activeFocus && _mouseSlide && editable) {
                        _mouseDown = true;
                    }
                    else {
                        mouse.accepted = false;
                    }
                    input.focus = false;
                    _startX = mouse.x;
                    _oldX = _startX;
                }

                onPositionChanged: {
                    if (input.activeFocus) return;
                    if (_mouseDown && _mouseSlide) {

                        if ((mouse.x - _oldX) > 0 && _increaseEnabled)
                            control.increase();
                        else if ((mouse.x - _oldX) < 0 && _decreaseEnabled)
                            control.decrease();
                        _oldX = mouse.x;
                    }
                }

                onReleased: {
                    _mouseDown = false;
                    if (_startX === _oldX && _mouseSlide) {
                        _mouseSlide = false;
                        input.focus = true;
                        input.forceActiveFocus();
                        input.selectAll();
                    }
                }
            }
        }

        Button {
            id: upButton
            flat: true
            round: control.round
            highlightColor: Theme.colors.selection
            autoRepeat: true
            focusPolicy: Qt.NoFocus
            enabled: _increaseEnabled
            rightCropped: true
            bottomCropped: true
            iconSource: {
                if (_stepSizeModifier === stepSizeThree) return "qrc:/icons/right_3.svg"
                if (_stepSizeModifier === stepSizeTwo) return "qrc:/icons/right_2.svg"
                return "qrc:/icons/right.svg"
            }
            iconColor: {
                if (!enabled) return Theme.colors.disabled;
                if (pressed) return Theme.colors.highlightedText;
                if (hovered) return Theme.colors.text;
                if (control.caution) return Theme.colors.neutral;
                if (!control.isValid) return Theme.colors.negative;
                return Theme.colors.description;
            }
            onClicked: if (editable) control.increase();
            Layout.fillHeight: true
            Layout.bottomMargin: background.highlighterHeight
        }
    }
}
