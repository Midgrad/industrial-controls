import QtQuick 2.6

import Industrial.Controls 1.0

Led {
    id: root

    property color blinkColor: Theme.colors.highlight

    property alias interval: timer.interval

    function blink() { timer.start(); }

    color: timer.running ? blinkColor : Theme.colors.background
    glowRadius: timer.running ? root.width : Theme.shadowSize

    Timer {
        id: timer
        interval: Theme.animationTime
    }
}

