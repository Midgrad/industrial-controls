import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0

Pane {
    id: root

    padding: Theme.padding

    GridLayout {
        anchors.fill: parent
        anchors.margins: Theme.padding
        rowSpacing: Theme.spacing
        columnSpacing: Theme.spacing
        columns: 4

        Label {}

        Label {
            text: qsTr("Basic")
            font.pixelSize: Theme.auxFontSize
            Layout.alignment: Qt.AlignHCenter
        }

        Label {
            text: qsTr("Flat")
            font.pixelSize: Theme.auxFontSize
            Layout.alignment: Qt.AlignHCenter
        }

        Label {
            text: qsTr("Disabled")
            font.pixelSize: Theme.auxFontSize
            Layout.alignment: Qt.AlignHCenter
        }

        Label { text: qsTr("Spinboxes"); font.pixelSize: Theme.auxFontSize }

        RealSpinBox {
            id: spin
            precision: 0
            from: 0
            to: 10
            Layout.fillWidth: true
        }

        RealSpinBox {
            flat: true
            precision: 1
            from: -100
            to: 100
            Layout.fillWidth: true
        }

        RealSpinBox {
            value: spin.value
            precision: 0
            enabled: false
            Layout.fillWidth: true
        }

        Label { text: qsTr("Real spinboxes"); font.pixelSize: Theme.auxFontSize }

        RealSpinBox {
            id: realSpin
            precision: 5
            labelText: qsTr("Real spinbox")
            Layout.fillWidth: true
        }

        RealSpinBox {
            labelText: qsTr("Flat real spinbox")
            flat: true
            Layout.fillWidth: true
        }

        RealSpinBox {
            value: realSpin.value
            labelText: qsTr("Disabled real spinbox")
            enabled: false
            Layout.fillWidth: true
        }

        Label { text: qsTr("Coord spinboxes"); font.pixelSize: Theme.auxFontSize }

        CoordSpinBox {
            id: coordSpin
            labelText: qsTr("Coordinates")
            Layout.fillWidth: true
        }

        CoordSpinBox {
            labelText: qsTr("Flat coordinates")
            isLongitude: true
            flat: true
            Layout.fillWidth: true
        }

        CoordSpinBox {
            value: coordSpin.value
            labelText: qsTr("Disabled coordinates")
            enabled: false
            Layout.fillWidth: true
        }

        Label { text: qsTr("Coord field"); font.pixelSize: Theme.auxFontSize }

        CoordField {
            id: coordField
            labelText: qsTr("Coordinates")
            latitude: 55.737347
            longitude: 37.482394
            Layout.fillWidth: true
        }

        CoordField {
            labelText: qsTr("Flat coordinates")
            flat: true
            Layout.fillWidth: true
        }

        CoordField {
            labelText: qsTr("Disabled coordinates")
            enabled: false
            Layout.fillWidth: true
        }

        Label { text: qsTr("Date input"); font.pixelSize: Theme.auxFontSize }

        DateTimeField {
            id: dateTimeField
            mode: "date"
            Layout.fillWidth: true
        }

        DateTimeField {
            mode: "date"
            flat: true
            Layout.fillWidth: true
        }

        DateTimeField {
            mode: "date"
            text: dateTimeField.text
            enabled: false
            Layout.fillWidth: true
        }

        Label { text: qsTr("Time input"); font.pixelSize: Theme.auxFontSize }

        DateTimeField {
            id: dateTimeField2
            mode: "time"
            Layout.fillWidth: true
        }

        DateTimeField {
            mode: "time"
            flat: true
            isValid: false
            Layout.fillWidth: true
        }

        DateTimeField {
            mode: "time"
            text: dateTimeField2.text
            enabled: false
            Layout.fillWidth: true
        }

        Label { text: qsTr("Date and time input"); font.pixelSize: Theme.auxFontSize }

        DateTimeField {
            id: dateTimeField3
            mode: "dateTime"
            Layout.fillWidth: true
        }

        DateTimeField {
            mode: "dateTime"
            flat: true
            Layout.fillWidth: true
        }

        DateTimeField {
            mode: "dateTime"
            text: dateTimeField3.text
            enabled: false
            Layout.fillWidth: true
        }

        Label { text: qsTr("Color input"); font.pixelSize: Theme.auxFontSize }

        ColorField {
            id: colorField
            Layout.fillWidth: true
        }

        ColorField {
            flat: true
            text: "#ff00ff"
            Layout.fillWidth: true
        }

        ColorField {
            text: colorField.text
            enabled: false
            Layout.fillWidth: true
        }

        // TODO: altitude & distance pickers

        Item { Layout.fillHeight: true }
    }
}
