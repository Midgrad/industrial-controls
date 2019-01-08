import QtQuick 2.9

TextInput {
    id: root

    inputMethodHints: Qt.ImhDigitsOnly
    horizontalAlignment: Qt.AlignHCenter
    selectByMouse: true
    clip: true
    readOnly: !control.editable
    font: control.font
    color: control.enabled ? control.color : industrial.disabledColor
    selectionColor: industrial.selectionColor
    selectedTextColor: industrial.onSelectionColor
}
