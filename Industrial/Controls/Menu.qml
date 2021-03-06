import QtQuick 2.6
import QtQuick.Templates 2.4 as T
import QtQuick.Controls 2.4
import QtQuick.Window 2.11

import Industrial.Controls 1.0

T.Menu {
    id: control

    property bool flat: false

    property alias menuSize: backgroundRect.implicitWidth
    property alias backgroundColor: backgroundRect.color
    property alias border: backgroundRect.border

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem ? contentItem.implicitWidth + leftPadding + rightPadding : 0)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             contentItem ? contentItem.implicitHeight : 0) + topPadding + bottomPadding

    margins: 0
    overlap: 1
    padding: 0
    topPadding: Theme.padding
    bottomPadding: Theme.padding

    contentItem: ListView {
        implicitHeight: contentHeight
        model: control.contentModel
        interactive: Window.window ? contentHeight > Window.window.height : false
        clip: true
        currentIndex: control.currentIndex

        ScrollIndicator.vertical: ScrollIndicator {}
    }

    T.Overlay.modal: Rectangle {
        color: Qt.rgba(Theme.colors.shadow.r, Theme.colors.shadow.g, Theme.colors.shadow.b, Theme.colors.shadow.a * 0.5)
    }

    T.Overlay.modeless: Rectangle {
        color: Qt.rgba(Theme.colors.shadow.r, Theme.colors.shadow.g, Theme.colors.shadow.b, Theme.colors.shadow.a * 0.12)
    }

    background: Rectangle {
        id: backgroundRect

        implicitWidth: Theme.baseSize //calculated in onOpened
        implicitHeight: Theme.baseSize

        color: Theme.colors.raised
        radius: Theme.rounding

        Shadow {
            visible: !control.flat
            source: parent
        }
    }

    delegate: MenuItem {
        id: menuItem

        property string iconSource: ""

        implicitWidth: label.implicitWidth + leftPadding + rightPadding
        implicitHeight: enabled ? Theme.baseSize : 0
        clip: true

        padding: 0
        leftPadding: icon.source === "" ? Theme.padding * 2 : icon.x + icon.width + Theme.padding
        rightPadding: arrow.visible ? arrow.width + Theme.padding * 2 : Theme.padding * 2

        indicator: ColoredIcon {
            id: icon
            x: Theme.padding
            anchors.verticalCenter: parent.verticalCenter
            source: {
                if (!checkable) return menuItem.iconSource ? menuItem.iconSource : menuItem.icon.source;
                if (menuItem.checked) return menuItem.iconSource.length > 0 ? menuItem.iconSource : "qrc:/icons/ok.svg";
                return "";
            }
            height: Theme.iconSize
            width: height
            color: {
                if (!enabled) return Theme.colors.disabled;
                if (menuItem.pressed) return Theme.colors.highlightedText;
                if (menuItem.selected || (checked && menuItem.selected)) return Theme.colors.text;
                if (checked) return Theme.colors.highlight;
                return Theme.colors.description;
            }
        }

        arrow: ColoredIcon {
            id: arrow
            x: control.width - width - Theme.padding
            anchors.verticalCenter: parent.verticalCenter
            visible: menuItem.subMenu
            source: "qrc:/icons/right.svg"
            height: Theme.iconSize
            width: height
            color: {
                if (!menuItem.enabled) return Theme.colors.disabled;
                if (menuItem.pressed) return Theme.colors.highlightedText;
                if (menuItem.selected) return Theme.colors.selectedText;
                return Theme.colors.description;
            }
        }

        contentItem: Text {
            id: label
            text: menuItem.text
            font.pixelSize: Theme.mainFontSize
            verticalAlignment: Text.AlignVCenter
            color: {
                if (!menuItem.enabled) return Theme.colors.disabled;
                if (menuItem.pressed) return Theme.colors.highlightedText;
                if (menuItem.selected) return Theme.colors.selectedText;
                return Theme.colors.text;
            }
        }

        background: Rectangle {
            anchors.fill: parent
            color: {
                if (menuItem.pressed) return Theme.colors.highlight;
                if (menuItem.hovered || menuItem.focus) return Theme.colors.hover;
                return "transparent";
            }
        }
    }

    onOpened: {
        var iconView = false
        for (var i = 0; i < control.count; ++i) {
            if (control.contentData[i].text === undefined) continue; //skip menuSeparator
            if (control.contentData[i].iconSource !== "" || String(control.contentData[i].icon.source) !== "" || control.contentData[i].checked === true) {
                iconView = true;
                break;
            }
        }

        var maxWidth = [];
        for (var j = 0; j < control.count; ++j) {
            if (control.contentData[j].text === undefined) continue; //skip menuSeparator
            control.contentData[j].leftPadding = iconView ? Theme.iconSize + Theme.padding * 2 : Theme.padding * 2;
            maxWidth.push(control.contentData[j].implicitWidth);
        }
        backgroundRect.implicitWidth = Math.max.apply(null, maxWidth);

        //width items
        for (var k = 0; k < control.count; ++k) {
            control.contentData[k].width = backgroundRect.implicitWidth;
        }
    }
}
