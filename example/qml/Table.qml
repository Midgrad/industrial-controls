import QtQuick 2.0
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0
import Industrial.Widgets 1.0

Pane {
    id: root

    PropertyTable {
        width: parent.width / 3
        height: parent.height
        labelWidth: width / 3

        TextField {
            labelText: "TextField"
            placeholderText: "This works too"
        }

        FilterField {
            labelText: "FilterField"
        }

        PasswordField {
            labelText: "PasswordField"
            text: "password"
        }

        CoordField {
            labelText: "CoordField"
            latitude: 55.737347
            longitude: 37.482394
        }

        ComboBox {
            labelText: "Combobox"
            model: [ "Combobox", "TextField", "FilterField", "PasswordField", "CoordField" ]
        }

        ColorField {
            labelText: "ColorField"
            text: "#ffaa00"
        }

        DateTimeField {
            labelText: "DateTimeField"
        }

        SpinBox {
            labelText: "SpinBox"
        }

        RealSpinBox {
            labelText: "RealSpinBox"
        }

        CoordSpinBox {
            labelText: "CoordSpinBox"
        }

        Switch {
            text: "Switch"
        }

        CheckBox {
            text: "CheckBox"
        }

        RadioButton {
            text: "RadioButton"
        }

        Slider {
            text: "Slider"
            to: 100
            value: 50
        }
    }
}
