import QtQuick 2.6
import QtQuick.Templates 2.4 as T
import QtGraphicalEffects 1.0

import Industrial.Controls 1.0

T.ProgressBar {
    id: control

    property bool flat: false
    property real radius: height / 2

    implicitWidth: Theme.baseSize * 4
    implicitHeight: Theme.baseSize

    background: Rectangle {

        radius: control.radius
        color: {
            if (!control.enabled) return "transparent";
            if (flat) return "transparent";
            return Theme.colors.sunken;
        }
        border.width: Theme.border
        border.color: {
            if (!control.enabled) return Theme.colors.disabled;
            if (flat) return Theme.colors.controlBorder;
            return "transparent";
        }

        Rectangle {
            id: mask
            visible: false
            anchors.fill: parent
            color: Theme.colors.negative
            radius: control.radius
        }
    }

    contentItem: Item {
        id: indicator
        visible: false
        Rectangle {
            width: control.visualPosition * (background.width - parent.anchors.margins * 2)
            height: parent.height
            color: {
                if (!control.enabled) return Theme.colors.disabled;
                return Theme.colors.selection;
            }
        }
    }

    OpacityMask {
        anchors.fill: indicator
        source: indicator
        maskSource: mask
    }
}
