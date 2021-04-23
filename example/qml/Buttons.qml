import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0

Pane {
    id: root

    padding: Theme.padding * 2

    function buttonStateChange() {
        for (var i = 0; i < buttonGrid.visibleChildren.length; ++i) {
            if ( buttonGrid.visibleChildren[i].Layout.fillHeight === true) continue;
            buttonGrid.visibleChildren[i].flat = checkFlat.checked;
            buttonGrid.visibleChildren[i].checkable = checkCheckable.checked;
            buttonGrid.visibleChildren[i].enabled = !checkDisable.checked;
            if (checkCheckable.checked === false) buttonGrid.visibleChildren[i].checked = false;
        }
        for (var i = 0; i < buttonOtherGrid.visibleChildren.length; ++i) {
            if ( buttonOtherGrid.visibleChildren[i].Layout.fillHeight === true) continue;
            buttonOtherGrid.visibleChildren[i].flat = checkFlat.checked;
            buttonOtherGrid.visibleChildren[i].enabled = !checkDisable.checked;
        }
    }

    Component.onCompleted: {
        buttonStateChange();
    }

    RowLayout {
        anchors.fill: parent
        spacing: Theme.spacing * 2

        Pane {
            backgroundColor: Theme.colors.sunken
            clip: true
            Layout.fillWidth: true
            Layout.fillHeight: true

            ColumnLayout {
                spacing: Theme.spacing

                CheckBox {
                    id: checkFlat
                    text: qsTr("Flat")
                    Layout.fillWidth: true
                    onClicked: buttonStateChange();
                }

                CheckBox {
                    id: checkCheckable
                    text: qsTr("Checkable")
                    Layout.fillWidth: true
                    onClicked: buttonStateChange();
                }

                CheckBox {
                    id: checkDisable
                    text: qsTr("Disable")
                    Layout.fillWidth: true
                    onClicked: buttonStateChange();
                }

                Item { Layout.fillHeight: true }
            }
        }

        GridLayout {
            id: buttonGrid
            Layout.fillWidth: true
            Layout.fillHeight: true
            rowSpacing: Theme.spacing
            columnSpacing: Theme.spacing
            columns: 3

            Button {
                type: Button.Type.Primary
                text: checked ? qsTr("Close") : qsTr("Button")
                iconSource: checked ? "qrc:/icons/close.svg" : "qrc:/icons/plus.svg"
                tipText: qsTr("Button")
                Layout.fillWidth: true
            }
            Button {
                type: Button.Type.Primary
                text: checked ? qsTr("Close") : qsTr("Button")
                tipText: qsTr("Button")
                Layout.fillWidth: true
            }
            Button {
                type: Button.Type.Primary
                iconSource: checked ? "qrc:/icons/close.svg" : "qrc:/icons/plus.svg"
                tipText: qsTr("Button")
            }

            Button {
                type: Button.Type.Secondary
                text: checked ? qsTr("Close") : qsTr("Button")
                iconSource: checked ? "qrc:/icons/close.svg" : "qrc:/icons/plus.svg"
                tipText: qsTr("Button")
                Layout.fillWidth: true
            }
            Button {
                type: Button.Type.Secondary
                text: checked ? qsTr("Close") : qsTr("Button")
                tipText: qsTr("Button")
                Layout.fillWidth: true
            }
            Button {
                type: Button.Type.Secondary
                iconSource: checked ? "qrc:/icons/close.svg" : "qrc:/icons/plus.svg"
                tipText: qsTr("Button")
            }

            Button {
                type: Button.Type.Negative
                text: checked ? qsTr("Close") : qsTr("Button")
                iconSource: checked ? "qrc:/icons/close.svg" : "qrc:/icons/plus.svg"
                tipText: qsTr("Button")
                Layout.fillWidth: true
            }
            Button {
                type: Button.Type.Negative
                text: checked ? qsTr("Close") : qsTr("Button")
                tipText: qsTr("Button")
                Layout.fillWidth: true
            }
            Button {
                type: Button.Type.Negative
                iconSource: checked ? "qrc:/icons/close.svg" : "qrc:/icons/plus.svg"
                tipText: qsTr("Button")
            }

            Button {
                type: Button.Type.Neutral
                text: checked ? qsTr("Close") : qsTr("Button")
                iconSource: checked ? "qrc:/icons/close.svg" : "qrc:/icons/plus.svg"
                tipText: qsTr("Button")
                Layout.fillWidth: true
            }
            Button {
                type: Button.Type.Neutral
                text: checked ? qsTr("Close") : qsTr("Button")
                tipText: qsTr("Button")
                Layout.fillWidth: true
            }
            Button {
                type: Button.Type.Neutral
                iconSource: checked ? "qrc:/icons/close.svg" : "qrc:/icons/plus.svg"
                tipText: qsTr("Button")
            }

            Button {
                type: Button.Type.Positive
                text: checked ? qsTr("Close") : qsTr("Button")
                iconSource: checked ? "qrc:/icons/close.svg" : "qrc:/icons/plus.svg"
                tipText: qsTr("Button")
                Layout.fillWidth: true
            }
            Button {
                type: Button.Type.Positive
                text: checked ? qsTr("Close") : qsTr("Button")
                tipText: qsTr("Button")
                Layout.fillWidth: true
            }
            Button {
                type: Button.Type.Positive
                iconSource: checked ? "qrc:/icons/close.svg" : "qrc:/icons/plus.svg"
                tipText: qsTr("Button")
            }

            Button {
                type: Button.Type.LinkPrimary
                text: checked ? qsTr("Close") : qsTr("Button")
                iconSource: checked ? "qrc:/icons/close.svg" : "qrc:/icons/plus.svg"
                tipText: qsTr("Button")
                checkedTextColor: Theme.colors.highlight
                Layout.fillWidth: true
            }
            Button {
                type: Button.Type.LinkPrimary
                text: checked ? qsTr("Close") : qsTr("Button")
                tipText: qsTr("Button")
                checkedTextColor: Theme.colors.highlight
                Layout.fillWidth: true
            }
            Button {
                type: Button.Type.LinkPrimary
                iconSource: checked ? "qrc:/icons/close.svg" : "qrc:/icons/plus.svg"
                tipText: qsTr("Button")
                checkedTextColor: Theme.colors.highlight
            }

            Button {
                type: Button.Type.LinkSecondary
                text: checked ? qsTr("Close") : qsTr("Button")
                iconSource: checked ? "qrc:/icons/close.svg" : "qrc:/icons/plus.svg"
                tipText: qsTr("Button")
                Layout.fillWidth: true
            }
            Button {
                type: Button.Type.LinkSecondary
                text: checked ? qsTr("Close") : qsTr("Button")
                tipText: qsTr("Button")
                Layout.fillWidth: true
            }
            Button {
                type: Button.Type.LinkSecondary
                iconSource: checked ? "qrc:/icons/close.svg" : "qrc:/icons/plus.svg"
                tipText: qsTr("Button")
            }

            Item { Layout.fillHeight: true }
        }

        GridLayout {
            id: buttonOtherGrid
            Layout.fillWidth: true
            Layout.fillHeight: true
            rowSpacing: Theme.spacing
            columnSpacing: Theme.spacing
            columns: 3

            DelayButton {
                text: qsTr("Delay")
                iconSource: "qrc:/icons/plus.svg"
                tipText: qsTr("Delay")
                Layout.fillWidth: true
            }
            DelayButton {
                text: qsTr("Delay")
                tipText: qsTr("Delay")
                Layout.fillWidth: true
            }
            DelayButton {
                iconSource: "qrc:/icons/plus.svg"
                tipText: qsTr("Delay")
            }

            ListModel{
                id: listModel
                ListElement { text: qsTr("Menu item") }
                ListElement { text: qsTr("Menu item") }
                ListElement { text: qsTr("Menu item") }
                ListElement { text: qsTr("Menu item") }
                ListElement { text: qsTr("Menu item") }
            }
            MenuButton {
                text: qsTr("Menu")
                iconSource: "qrc:/icons/plus.svg"
                tipText: qsTr("Menu")
                model: listModel
                Layout.fillWidth: true
            }
            MenuButton {
                text: qsTr("Menu")
                tipText: qsTr("Menu")
                model: listModel
                Layout.fillWidth: true
            }
            MenuButton {
                iconSource: "qrc:/icons/plus.svg"
                tipText: qsTr("Menu")
                model: listModel
            }

            Item { Layout.fillHeight: true }
        }
    }
}
