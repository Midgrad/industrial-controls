import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.ToolTip {
    id: control
    property bool сloseOnClick: true
    property var wrapMode: Text.Wrap

    x: parent ? (parent.width - implicitWidth) / 2 : 0
    y: -implicitHeight - 3

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             contentItem.implicitHeight + topPadding + bottomPadding)

    font.pixelSize: Theme.tipFontSize
    margins: Theme.margins
    padding: Theme.padding
    topPadding: Theme.padding * 0.5
    bottomPadding: Theme.padding * 0.5

    closePolicy: T.Popup.CloseOnEscape | T.Popup.CloseOnPressOutsideParent | T.Popup.CloseOnReleaseOutsideParent

    contentItem: Label {
        text: control.text
        font: control.font
        color: Theme.colors.tipText
        horizontalAlignment: Qt.AlignHCenter
        wrapMode: control.wrapMode
    }

    background: Rectangle {
        color: Theme.colors.tip
        radius: Theme.rounding

        MouseArea {
            anchors.fill: parent
            onPressed: if(control.сloseOnClick) control.close()
        }
    }
}
