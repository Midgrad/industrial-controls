import QtQuick 2.6
import Industrial.Controls 1.0

Item {
    id: content

    property int spacing: Theme.spacing
    property color textColor: Theme.colors.text
    property color iconColor: textColor

    property alias iconSize: icon.width
    property alias iconSource: icon.source
    property alias font: label.font
    property alias text: label.text
    property alias elide: label.elide
    property alias textSize: label.font.pixelSize
    property alias horizontalAlignment: label.horizontalAlignment
    property alias verticalAlignment: label.verticalAlignment

    implicitWidth: {
        if (icon.visible) {
            if (label.visible)
                return icon.width + label.implicitWidth + spacing;
            return icon.width;
        }
        else if (label.visible) {
            return label.implicitWidth;
        }
        return 0;
    }
    implicitHeight: Math.max(icon.implicitHeight, label.implicitHeight)

    FontMetrics {
        id: metrics
        font: label.font
    }

    ColoredIcon {
        id: icon
        anchors.left: parent.left
        anchors.leftMargin: text.length > 0 ? (Math.min(content.height, content.width) - width)
                                              / 2 : (content.width - width) / 2
        anchors.verticalCenter: parent.verticalCenter
        height: Theme.iconSize
        width: height
        visible: iconSource !== ""
        color: iconColor
    }

    Text {
        id: label
        anchors.right: parent.right
        width: {
            var sum = parent.width
            if (icon.visible)
                sum -= icon.width + spacing;
            return sum;
        }
        height: parent.height
        elide: Text.ElideRight
        font.pixelSize: Theme.mainFontSize
        color: textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        visible: text.length > 0
    }
}
