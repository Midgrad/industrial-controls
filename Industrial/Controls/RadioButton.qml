import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.RadioButton {
    id: control

    property alias flat: base.flat
    property alias horizontalAlignment: label.horizontalAlignment

    font.pixelSize: Theme.mainFontSize
    focusPolicy: Qt.NoFocus
    leftPadding: 0
    spacing: Theme.spacing
    implicitHeight: Theme.baseSize
    implicitWidth: text.length > 0 ? contentItem.implicitWidth + spacing : indicator.implicitWidth
    hoverEnabled: true

    indicator: CheckMarkBase {
        id: base
        x: control.leftPadding
        y: parent.height * 0.5 - height * 0.5
        radius: width * 0.5
        down: control.down
        hovered: control.hovered
        checked: control.checked

        Rectangle {
            anchors.fill: parent
            anchors.margins: parent.width * 0.25
            radius: width * 0.5
            visible: control.checked || control.down
            color: base.indicatorColor
        }
    }

    contentItem: Label {
        id: label
        text: control.text
        font: control.font
        leftPadding: indicator.width + spacing
        verticalAlignment: Text.AlignVCenter
    }
}
