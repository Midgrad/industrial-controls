import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.TextField {
    id: control

    property alias table: background.table
    property alias flat: background.flat
    property alias underline: background.underline
    property alias backgroundColor: background.color
    property alias caution: background.caution
    property alias isValid: background.isValid
    property alias labelText: background.text
    property alias labelFontPixelSize: background.fontPixelSize
    property alias labelTextAlignment: background.textAlignment
    readonly property alias highlighted: background.highlighted

    clip: true
    implicitWidth: background.implicitWidth
    implicitHeight: labelText.length > 0 ? Theme.baseSize * 1.25 : Theme.baseSize
    font.pixelSize: Theme.mainFontSize
    color: control.enabled ? Theme.colors.text : Theme.colors.disabled
    selectionColor: background.highlighterColor
    selectedTextColor: Theme.colors.selectedText
    selectByMouse: true
    leftPadding: Theme.padding
    rightPadding: Theme.padding
    horizontalAlignment: Text.AlignLeft
    topPadding: labelText.length > 0 ? (Theme.auxFontSize / 1.2 - Theme.border) : 0
    verticalAlignment: Text.AlignVCenter

    validator: RegExpValidator {
        regExp: /[A-zЁёА-я0-9 !@#$&()\-`.+,\/\"=№;%:?*{}|’<>~°']*/
    }

    onTextChanged: {
         if (!activeFocus) cursorPosition = 0;
    }

    background: BackgroundInput {
        id: background
        hovered: control.hovered
        anchors.fill: parent
        inputed: displayText.length > 0 || placeholderText.length > 0 || control.activeFocus
        highlighted: control.activeFocus
        clip: true
    }

    Label {
        id: placeholderLabel
        anchors.fill: parent
        visible: control.displayText.length == 0 && control.placeholderText.length > 0
        text: control.placeholderText
        font.pixelSize: Theme.mainFontSize
        color: control.enabled ? (!control.activeFocus ? Theme.colors.description : Theme.colors.disabled) : Theme.colors.disabled
        leftPadding: Theme.padding
        rightPadding: Theme.padding
        width: control.width
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }
}
