import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.Label {
    id: control

    property int type: Theme.Text

    font.pixelSize: type === Theme.Text ? Theme.mainFontSize : Theme.auxFontSize
    color: control.enabled ? (type === Theme.Text ? Theme.colors.text : Theme.colors.description) :
                             Theme.colors.disabled
    font.weight: type === Theme.Title ? Font.Bold : Font.Normal
    font.capitalization: type === Theme.Title ? Font.AllUppercase : Font.MixedCase
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight
}

