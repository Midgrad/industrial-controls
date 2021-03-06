import QtQuick 2.6
import QtQuick.Templates 2.1 as T
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import Industrial.Controls 1.0

T.ComboBox {
    id: control

    property int stepSize: stepSizeDefault
    property int stepSizeDefault: 1
    property int stepSizeTwo: 10
    property int stepSizeThree: 20
    property int flickVelocity: 2500

    property var currentItem: model && model[currentIndex] ? model[currentIndex] : undefined
    property string iconRole: "icon"
    property string displayIcon: currentItem && currentItem[control.iconRole] !== undefined ?
                                     iconFunction(currentItem[control.iconRole]) : ""
    property string valueRole: "value"
    property var currentValue: currentItem && currentItem[control.valueRole] !== undefined ?
                                   currentItem[control.valueRole] : null

    property alias table: background.table
    property alias isValid: background.isValid
    property alias labelText: background.text
    property alias labelColor: background.textColor
    property alias labelWidth: background.textWidth //FIXME
    property alias backgroundColor: background.color
    property alias backgroundUnderline: background.underline
    property alias contentColor: content.textColor
    property alias displayIconColor: content.iconColor
    property alias horizontalAlignment: content.horizontalAlignment
    property alias bottomCropping: background.bottomCropping
    property alias topCropping: background.topCropping
    property alias leftCropping: background.leftCropping
    property alias rightCropping: background.rightCropping
    property alias selectionColor: background.highlighterColor
    property Component delegateContent

    function findIndex(item) {
        for (var i = 0 ;i < count; ++i) {
            if (item === model[i]) return i;
        }
        return -1;
    }

    property var iconFunction: (icon) => { return icon;}

    implicitWidth: background.implicitWidth
    implicitHeight: labelText.length > 0 ? Theme.baseSize * 1.25 : Theme.baseSize
    font.pixelSize: Theme.mainFontSize
    clip: true
    textRole: "text"
    displayText: currentItem && currentItem[control.textRole] !== undefined ?
                                currentItem[control.textRole] : currentItem

    leftPadding: Theme.padding
    rightPadding: Theme.padding + Theme.baseSize

    indicator: ColoredIcon {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: Theme.padding
        height: Theme.iconSize
        width: height
        source: control.popup.visible ? "qrc:/icons/up.svg" : "qrc:/icons/down.svg"
        color: {
            if (!control.enabled) return Theme.colors.disabled;
            if (!control.isValid || !control.isValid && highlighted) return Theme.colors.negative;
            if (control.caution || control.caution && highlighted) return Theme.colors.neutral;
            if (control.activeFocus) return Theme.colors.selection;
            //if (table) return Theme.colors.control;
            return Theme.colors.description;
        }
    }

    background: BackgroundInput {
        id: background
        hovered: control.hovered
        anchors.fill: parent
        flat: control.flat
        textPadding: Theme.padding
        inputed: displayText.length > 0
        highlighted: control.activeFocus
    }

    delegate: ItemDelegate {
        id: delegate
        width: control.width
        horizontalAlignment: control.horizontalAlignment

        readonly property var delegateModel: {
            if (typeof (modelData) !== "undefined")
                return modelData;
            return model;
        }

        text: {
            if (typeof (delegateModel) !== "undefined") {
                return delegateModel[control.textRole] ? delegateModel[control.textRole] : delegateModel;
            }
            return ""
        }

        iconSource: {
            if (typeof (delegateModel) !== "undefined") {
                return delegateModel[control.iconRole] ? iconFunction(delegateModel[control.iconRole])
                                                       : "";
            }
            return ""
        }

        font: control.font
        highlighted: control.currentIndex === index
        isValid: control.isValid

        Loader {
            readonly property alias delegateModel: delegate.delegateModel
            anchors.right: parent.right
            anchors.rightMargin: Theme.margins
            anchors.verticalCenter: parent.verticalCenter
            sourceComponent: delegateContent
        }
    }

    contentItem: ContentItem {
        id: content
        anchors.fill: control
        anchors.topMargin: background.textHeight - background.underline
        anchors.leftMargin: Theme.padding
        anchors.rightMargin: Theme.padding + Theme.baseSize
        font: control.font
        text: displayText
        iconSource: displayIcon
        textColor: control.enabled ? Theme.colors.text : Theme.colors.disabled
        horizontalAlignment: Text.AlignLeft
    }

    popup: Popup {
        id: popup
        y: control.height
        backgroundColor: Theme.colors.raised
        width: control.width
        implicitHeight: contentItem.implicitHeight + Theme.padding * 2
        leftPadding: 0
        rightPadding: 0
        topPadding: Theme.padding
        bottomPadding: Theme.padding

        contentItem: ListView {
            id: listView
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            cacheBuffer: Theme.baseSize * 20
            currentIndex: control.highlightedIndex
            boundsBehavior: Flickable.StopAtBounds
            maximumFlickVelocity: flickVelocity * stepSize
            ScrollBar.vertical: ScrollBar {
                visible: listView.implicitHeight > listView.height
            }
        }
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Z) stepSize = stepSizeTwo;
        else if (event.key === Qt.Key_X) stepSize = stepSizeThree;
        else return;
        event.accepted = true;
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Z) stepSize = stepSizeDefault;
        else if (event.key === Qt.Key_X) stepSize = stepSizeDefault;
        else return;
        event.accepted = true;
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onClicked: {
            control.forceActiveFocus();
            popup.visible = control.model.length > 0 ? !popup.visible : false;
        }
    }
}
