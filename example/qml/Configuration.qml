import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0
import Industrial.Widgets 1.0

Popup {
    id: root
    width: Theme.baseSize * 8
    closePolicy: Popup.CloseOnPressOutsideParent

    ThemeLoader
    {
        id: themeLoader
        filename: "../demo.json"
        Component.onCompleted: {
            setTheme(Theme);
            save();
        }
    }

    ColumnLayout{
        width: parent.width
        spacing: Theme.spacing

        Slider {
            from: 16
            to: 60
            stepSize: 4
            text: qsTr("Base size")
            value: Theme.baseSize
            onPressedChanged: { if (!pressed) { Theme.baseSize = value } }
            Layout.fillWidth: true
        }

        ButtonBar {
            Layout.fillWidth: true

             Button {
                 text: qsTr("Day")
                 highlighted: !Theme.night
                 onClicked: Theme.night = false
             }

             Button {
                 text: qsTr("Night")
                 highlighted: Theme.night
                 onClicked: Theme.night = true
             }
        }
    }
}
