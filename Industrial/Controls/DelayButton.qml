import QtQuick 2.6
import QtQuick.Templates 2.2 as T

import Industrial.Controls 1.0

T.DelayButton {
    id: control

    property string tipText
    property bool flat: false
    property bool round: false
    property bool topCropped: false
    property bool bottomCropped: false
    property bool leftCropped: false
    property bool rightCropped: false
    property alias iconSource: content.iconSource
    property alias textColor: content.textColor
    property alias iconColor: content.iconColor
    property alias backgroundColor: backgroundItem.color
    property alias borderColor: backgroundItem.borderColor
    property alias borderWidth: backgroundItem.borderWidth
    property alias fillColor: fill.color

    implicitWidth: Math.max(implicitHeight, content.implicitWidth + control.padding * 2)
    implicitHeight: Theme.baseSize
    baselineOffset: contentItem.y + contentItem.baselineOffset

    onActivated: progress = 0

    font.pixelSize: Theme.mainFontSize
    focusPolicy: Qt.NoFocus
    hoverEnabled: true
    padding: text.length > 0 ? Theme.padding : 0
    delay: 1000

    transition: Transition {
            NumberAnimation {
                duration: control.delay * (control.pressed ? 1.0 - control.progress : 0.3 * control.progress)
            }
        }

    background: BackgroundItem {
        id: backgroundItem
        anchors.fill: parent
        borderColor: control.activeFocus ? Theme.colors.highlight : "transparent"
        hovered: control.hovered
        radius: round ? Math.min(width, height) / 2 : Theme.rounding
        topCropping: topCropped ? radius : 0
        bottomCropping: bottomCropped ? radius : 0
        leftCropping: leftCropped ? radius : 0
        rightCropping: rightCropped ? radius : 0
        color: {
            if (!control.enabled) return control.flat ? "transparent" : Theme.colors.disabled;
            return control.flat ? "transparent" : Theme.colors.control;
        }
    }

    contentItem: Item {
        anchors.fill: parent

        ContentItem {
            id: content
            anchors.fill: parent
            anchors.margins: control.padding
            text: control.text
            font: control.font
            textColor: {
                if (!enabled) return control.flat ? Theme.colors.disabled : Theme.colors.background;
                Theme.colors.controlText
            }
        }

        Item {
            width: parent.width * control.progress
            height: parent.height
            clip: true

            Rectangle {
                id: fill
                radius: backgroundItem.radius
                anchors.fill: parent
                anchors.rightMargin: -backgroundItem.radius
                color: Theme.colors.selection
                clip: true
            }

            Item {
                x: (backgroundItem.width - width) / 2
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height
                width: content.width + control.padding * 2

                ContentItem {
                    id: invertedContent
                    anchors.fill: parent
                    anchors.margins: control.padding
                    text: control.text
                    font: control.font
                    iconSource: control.iconSource
                    textColor: Theme.colors.selectedText
                }
            }
        }
    }

    ToolTip {
        visible: control.hovered && tipText
        text: tipText
        delay: 1000
    }
}
