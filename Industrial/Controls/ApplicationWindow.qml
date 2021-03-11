import QtQuick 2.6
import QtQuick.Templates 2.2 as T

T.ApplicationWindow {
    id: window

    color: Theme.colors.sunken

    overlay.modal: Rectangle {
            color: Color.transparent(Theme.colors.shadow, 0.5)
        }

        overlay.modeless: Rectangle {
            color: Color.transparent(Theme.colors.shadow, 0.12)
        }
}
