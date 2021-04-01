import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.Label {
    id: control

    //type
    //type: "text" - обычный текст
    //type: "label" - лэйбл
    //type: "title" - заголовок, таб
    property string type: "text"

    font.pixelSize: type === "text" ? Theme.mainFontSize : Theme.auxFontSize
    color: control.enabled ? (type === "text" ? Theme.colors.text : Theme.colors.description) : Theme.colors.disabled
    font.weight: type === "title" ? Font.Bold : Font.Normal
    font.capitalization: type === "title" ? Font.AllUppercase : Font.MixedCase
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight
}
