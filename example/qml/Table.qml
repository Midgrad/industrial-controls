import QtQuick 2.0
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0
import Industrial.Widgets 1.0

Pane {
    id: root



        PropertyTable {
            ///*
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
                labelText: qsTr("Combobox")
                model: [  qsTr("Combobox"), qsTr("TextField"), qsTr("FilterField"), qsTr("PasswordField"), qsTr("CoordField") ]
                Layout.fillWidth: true
            }

            ColorField {
                labelText: "ColorField"
                text: "#ffaa00"
            }
            //не работают спины
            /*
            DateTimeField {
                labelText: "DateTimeField"
                mode:"dateTime"
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
            */

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
