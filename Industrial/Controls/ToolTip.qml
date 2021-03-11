import QtQuick 2.6
import QtQuick.Templates 2.2 as T

T.ToolTip {
    id: control
    property bool сloseOnClick: true

    x: parent ? (parent.width - implicitWidth) / 2 : 0
    y: -implicitHeight - 3

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             contentItem.implicitHeight + topPadding + bottomPadding)

    margins: Theme.margins
    padding: Theme.padding

    closePolicy: T.Popup.CloseOnEscape | T.Popup.CloseOnPressOutsideParent | T.Popup.CloseOnReleaseOutsideParent

    contentItem: Label {
        text: control.text
        font: control.font
        color: Theme.colors.tipText
        horizontalAlignment: Qt.AlignHCenter
    }

    background: Rectangle {
        color: Theme.colors.tip
        radius: 3

        MouseArea {
            anchors.fill: parent
            onPressed: if(control.сloseOnClick) control.close()
        }
    }
}
