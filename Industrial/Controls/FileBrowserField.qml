import QtQuick 2.6
import Industrial.Widgets 1.0
import Industrial.Controls 1.0

TextField {
    id: control

    property bool selectFolder: false
    property bool selectExisting: true
    property bool selectMultiple: false
    property string defaultSuffix: ".suffix"
    property string folder: ".."
    property var nameFilters: ["Filter 1 (*.txt)", "Filter 2 (*.cpp *.json)", "Any (*)"]
    property string separator: ", "
    property int popupVerticalPosition: Popup.Bottom
    property int popupHorizontalAlignment: Popup.Left

    rightPadding: button.visible ? button.width + Theme.padding : Theme.padding

    signal finished()

    validator: RegExpValidator {
        regExp: /^[A-zЁёА-я0-9 _\-\(\)!@#,\.\+\/:]*$/
    }

    function validate() {
        caution = (!acceptableInput && text.length) ? true : false;
        control.deselect();
    }

    onActiveFocusChanged: {
        validate();
    }

    onFinished: {
        validate();
    }

    onEditingFinished: {
        validate();
    }

    Popup {
        id: popup
        closePolicy: Popup.NoAutoClose
        width: fileBrowser.width
        height: fileBrowser.height

        y: popupVerticalPosition === Popup.Bottom ? parent.height : -(height)
        x: popupHorizontalAlignment === Popup.Left ? 0 : -(width - parent.width)

        padding: 0        

        FileBrowser {
            id: fileBrowser
            visible: popup.visible

            selectFolder: control.selectFolder
            selectExisting: control.selectExisting
            selectMultiple: control.selectMultiple
            defaultSuffix: control.defaultSuffix
            folder: control.folder
            nameFilters: control.nameFilters

            onAccepted: {
                control.text = fileBrowser.fileUrls.join(separator);
                fileBrowser.visible = true;
                popup.visible = false;

            }
            onRejected: {
                fileBrowser.visible = true;
                popup.visible = false;
            }
        }
    }

    Button {
        id: button
        iconSource: "qrc:/icons/folder-2.svg"
        flat: true
        enabled: control.enabled
        type: {
            if (!control.isValid) return Theme.Negative;
            if (control.caution) return Theme.Neutral;
            return Theme.Secondary;
        }

        width: Theme.baseSize
        height: parent.height - Theme.border
        anchors.right: parent.right

        leftCropped: control.table ? 0 : radius
        bottomCropped: control.table ? 0 : radius
        radius: control.table ? 0 : Theme.rounding

        checkable: true
        checked: popup.visible
        onClicked: {
            control.forceActiveFocus();
            popup.visible = !popup.visible
        }
    }

}
