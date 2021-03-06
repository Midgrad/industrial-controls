import QtQuick 2.6
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.Slider {
    id: control

    property bool flat: false
    property bool toolTipVisible: true
    property int digits: 0
    property real visualValue: from + position * (to - from)

    property alias text: textItem.text

    implicitWidth: Theme.baseSize * 6
    implicitHeight: text.length ? 1.5 * Theme.baseSize : Theme.baseSize
    topPadding: textItem.visible ? textItem.contentHeight : 0
    focusPolicy: Qt.NoFocus
    hoverEnabled: true

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: Theme.baseSize * 6
        width: control.availableWidth
        height: Theme.sliderSize
        radius: height / 2
        color: {
            if (!control.enabled) return Theme.colors.disabled;
            if (flat) return Theme.colors.controlBorder;
            return Theme.colors.sunken;
        }

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            color: {
                if (!control.enabled) return Theme.colors.disabled;
                return Theme.colors.selection;
            }
            radius: height / 2
        }
    }

    handle: Handle {
        id: handle
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        shadowEnabled: Theme.night
        Rectangle {
            anchors.centerIn: parent
            width: parent.width * 2
            height: width
            radius: width / 2
            color: Theme.colors.highlight
            opacity: 0.2
            visible: control.pressed
        }
    }

    Text {
        id: textItem
        anchors.left: parent.left
        anchors.top: parent.top
        visible: text.length
        font.pixelSize: Theme.auxFontSize
        color: {
            if (!control.enabled) return Theme.colors.disabled;
            if (control.activeFocus) return Theme.colors.selection;

            return Theme.colors.text;
        }
        Behavior on font.pixelSize { PropertyAnimation { duration: Theme.animationTime } }
    }

    ToolTip {
        parent: handle
        visible: toolTipVisible && (hovered || pressed)
        text: visualValue.toFixed(digits)
    }
}
