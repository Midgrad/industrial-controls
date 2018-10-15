import QtQuick 2.6
import QtQuick.Templates 2.2 as T

T.Switch {
    id: control

    property bool inputChecked: checked
    property alias textColor: text.color
    property alias backgroundColor: backgroundItem.color
    property string tipText

    spacing: controlSize.spacing
    font.pixelSize: controlSize.fontSize
    implicitWidth: contentItem.implicitWidth
    implicitHeight: controlSize.baseSize
    hoverEnabled: true

    onInputCheckedChanged: if (checked != inputChecked) checked = inputChecked

    indicator: Rectangle {
        id: backgroundItem
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        implicitWidth: controlSize.baseSize
        implicitHeight: controlSize.underline
        radius: height / 2
        color: control.checked ? customPalette.selectionColor : customPalette.backgroundColor

        Handle {
            x: control.checked ? parent.width - width : 0
            anchors.verticalCenter: parent.verticalCenter

            Behavior on x { PropertyAnimation { duration: controlSize.animationTime} }
        }
    }

    contentItem: Text {
        id: text
        horizontalAlignment: Qt.AlignLeft
        verticalAlignment: Text.AlignVCenter
        text: control.text
        font: control.font
        color: customPalette.textColor
        leftPadding: indicator.width + control.spacing
    }

    ToolTip {
        visible: (hovered || down) && tipText
        text: tipText
        delay: 1000
    }
}
