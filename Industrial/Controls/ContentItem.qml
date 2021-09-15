import QtQuick 2.6
import QtQuick.Layouts 1.3

import Industrial.Controls 1.0

Item {
    id: content

    property color textColor: Theme.colors.text
    property color iconColor: textColor

    property alias spacing: row.spacing
    property alias iconSize: icon.width
    property alias iconSource: icon.source
    property alias font: label.font
    property alias text: label.text
    property alias textSize: label.font.pixelSize
    property alias horizontalAlignment: label.horizontalAlignment
    property alias verticalAlignment: label.verticalAlignment

    implicitWidth: {
        if (icon.visible) {
            if (label.visible)
                return icon.implicitWidth + label.implicitWidth + row.spacing;
            return icon.implicitWidth;
        }
        else if (label.visible) {
            return label.implicitWidth + 1;
        }
        return 0;
    }
    implicitHeight: Math.max(icon.implicitHeight, label.implicitHeight)

    FontMetrics {
        id: metrics
        font: label.font
    }

    RowLayout {
        id: row
        anchors.centerIn: parent
        width: parent.width
        spacing: Theme.padding

        ColoredIcon {
            id: icon
            implicitHeight: Math.max(width, Theme.iconSize)
            implicitWidth: implicitHeight
            color: iconColor
            visible: iconSource !== ""
            Layout.leftMargin: text.length > 0 ? (Math.min(content.height, content.width) - width)
                                                 / 2 : (content.width - width) / 2
        }

        Text {
            id: label
            elide: Text.ElideRight
            font.pixelSize: Theme.mainFontSize
            color: textColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            visible: text.length > 0
            Layout.minimumWidth: metrics.advanceWidth(text)
            Layout.fillWidth: true
        }
    }
}
