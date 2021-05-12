import QtQuick 2.6

Row {
    id: row
    
    property bool setButtonWidth: true
    property bool flat: false
    property bool checkable: false
    
    spacing: 1

    onFlatChanged: {
        for (var i = 0; i < visibleChildren.length; ++i) {
            visibleChildren[i].flat = row.flat;
        }
    }

    onCheckableChanged: {
        for (var i = 0; i < visibleChildren.length; ++i) {
            visibleChildren[i].checkable = row.checkable;
            if (!row.checkable) visibleChildren[i].checked = false;
        }
    }

    onVisibleChildrenChanged: {
        var buttons = [];
        var buttonsCnt = 0;

        for (var i = 0; i < visibleChildren.length; ++i) {
            var item = visibleChildren[i];

            if (item instanceof Button) {
                buttons.push(item);
                buttonsCnt++;
            }
        }

        for (var j = 0; j < buttonsCnt; ++j) {
            var button = buttons[j];

            if (row.setButtonWidth) {
                button.width = Qt.binding(function () { return row.width / buttonsCnt - 1; });
            }
            button.leftCropped = j > 0;
            button.rightCropped = j < buttonsCnt - 1;
        }
    }
}
