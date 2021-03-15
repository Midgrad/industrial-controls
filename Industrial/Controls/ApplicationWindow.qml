import QtQuick 2.6
import QtQuick.Window 2.3
import QtQuick.Templates 2.4 as T

import Industrial.Controls 1.0

T.ApplicationWindow {
    id: window

    color: Theme.colors.sunken

    overlay.modal: Rectangle {
            color: Qt.rgba(Theme.colors.shadow.r, Theme.colors.shadow.g, Theme.colors.shadow.b, Theme.colors.shadow.a * 0.5)
        }

        overlay.modeless: Rectangle {
            color: Qt.rgba(Theme.colors.shadow.r, Theme.colors.shadow.g, Theme.colors.shadow.b, Theme.colors.shadow.a * 0.12)
        }
}
