import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.Label {
    id: control

    property var types: {
        "text": 0,
        "label": 1,
        "title": 2
    }

    property var type: types.text

    font.pixelSize: type === types.text ? Theme.mainFontSize : Theme.auxFontSize
    color: control.enabled ? (type === types.text ? Theme.colors.text : Theme.colors.description) : Theme.colors.disabled
    font.weight: type === types.title ? Font.Bold : Font.Normal
    font.capitalization: type === types.title ? Font.AllUppercase : Font.MixedCase
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight
}

