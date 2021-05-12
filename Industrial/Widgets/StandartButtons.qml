import QtQuick 2.0
import Industrial.Controls 1.0

ButtonBar {
    id: control

    property var buttons: [Theme.Ok, Theme.Cancel]

    // TODO: disable, onCliked

    Component {
        id: button
        Button {
            property string role
        }
    }

    function createButtonBar() {
        var arr = [];
        for (var i = 0; i < buttons.length; ++i) {
            arr[i] = button.createObject();

            switch (control.buttons[i]) {
            case Theme.Yes:
                arr[i].type = Theme.Positive;
                arr[i].role = "Yes";
                arr[i].text = qsTr("Yes");
                arr[i].tipText = qsTr("Yes");
                break;
            case Theme.Ok:
                arr[i].type = Theme.Positive;
                arr[i].role = "Ok";
                arr[i].text = qsTr("Ok");
                arr[i].tipText = qsTr("Ok");
                break;
            case Theme.Apply:
                arr[i].type = Theme.Positive;
                arr[i].role = "Apply";
                arr[i].text = qsTr("Apply");
                arr[i].tipText = qsTr("Apply");
                break;
            case Theme.Open:
                arr[i].type = Theme.Primary;
                arr[i].role = "Open";
                arr[i].text = qsTr("Open");
                arr[i].tipText = qsTr("Open");
                break;
            case Theme.Save:
                arr[i].type = Theme.Positive;
                arr[i].role = "Save";
                arr[i].text = qsTr("Save");
                arr[i].tipText = qsTr("Save");
                break;
            case Theme.Restore:
                arr[i].type = Theme.Primary;
                arr[i].role = "Restore";
                arr[i].text = qsTr("Restore");
                arr[i].tipText = qsTr("Restore");
                break;
            case Theme.Reset:
                arr[i].type = Theme.Primary;
                arr[i].role = "Reset";
                arr[i].text = qsTr("Reset");
                arr[i].tipText = qsTr("Reset");
                break;
            case Theme.Cancel:
                arr[i].type = Theme.Primary;
                arr[i].role = "Cancel";
                arr[i].text = qsTr("Cancel");
                arr[i].tipText = qsTr("Cancel");
                break;
            case Theme.No:
                arr[i].type = Theme.Negative;
                arr[i].role = "No";
                arr[i].text = qsTr("No");
                arr[i].tipText = qsTr("No");
                break;
            case Theme.Close:
                arr[i].type = Theme.Negative;
                arr[i].role = "Close";
                arr[i].text = qsTr("Close");
                arr[i].tipText = qsTr("Close");
                break;
            }
        }
        control.children = arr;
    }

    Component.onCompleted: {
        createButtonBar();
    }
}
