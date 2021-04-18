import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.Label {
    id: control

    enum Type {
        Text,
        Label,
        Title
    }

    property int type: Label.Type.Text

    font.pixelSize: type === Label.Type.Text ? Theme.mainFontSize : Theme.auxFontSize
    color: control.enabled ? (type === Label.Type.Text ? Theme.colors.text : Theme.colors.description) :
                             Theme.colors.disabled
    font.weight: type === Label.Type.Title ? Font.Bold : Font.Normal
    font.capitalization: type === Label.Type.Title ? Font.AllUppercase : Font.MixedCase
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight
}

