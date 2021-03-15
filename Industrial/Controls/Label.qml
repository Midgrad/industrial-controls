import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.Label {
    id: control

    font.pixelSize: Theme.mainFontSize
    color: control.enabled ? Theme.colors.text : Theme.colors.disabled
    verticalAlignment: Text.AlignVCenter
    elide: Text.ElideRight
}
