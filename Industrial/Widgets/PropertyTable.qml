import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0

Rectangle {
    id: root

    property bool flat: false
    property real padding: Theme.padding
    property real topPadding
    property real bottomPadding
    property real leftPadding
    property real rightPadding
    property real labelWidth: root.width / 2
    property real rowSpacing: 0
    property real columnSpacing: Theme.padding

    property alias backgroundColor: root.color

    width: Theme.baseSize * 10
    color: flat ? "transparent" : Theme.colors.background
    clip: true

    Flickable {
        anchors.fill: parent
        contentHeight: table.implicitHeight + table.anchors.topMargin + table.anchors.bottomMargin
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds

        GridLayout {
            id: table
            anchors.fill: parent
            rowSpacing: root.rowSpacing
            columnSpacing: root.columnSpacing
            columns: 2
            anchors.topMargin: topPadding ? topPadding : padding
            anchors.bottomMargin: bottomPadding ? bottomPadding : padding
            anchors.leftMargin: leftPadding ? leftPadding : padding
            anchors.rightMargin: rightPadding ? rightPadding : padding
        }

        ScrollBar.vertical: ScrollBar {
            visible: table.height + table.anchors.topMargin + table.anchors.bottomMargin > root.height
        }
    }

    Component {
        id: label
        Text {
            text: "Label"
            font.pixelSize: Theme.auxFontSize
            color: Theme.colors.description
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
    }

    function createTable() {
        var newChildren = Object.values(children).splice(1, children.length);
        var length = newChildren.length;
        for (var i = 0; i < length * 2; i += 2) {
            newChildren.splice(i, 0, label.createObject());
            var current = newChildren[i];
            var next = newChildren[i + 1];

            if (next instanceof Slider ||
                    next instanceof RadioButton ||
                    next instanceof CheckBox ||
                    next instanceof Switch ) {
                current.text = next.text;
                next.text = "";
            }
            else {
                current.text = next.labelText;
                next.labelText = "";
                next.table = !root.flat;
            }
            next.flat = root.flat;

            current.Layout.minimumHeight = Theme.baseSize;
            current.Layout.wrapMode = Text.Wrap;
            current.Layout.minimumWidth = labelWidth;
            next.Layout.minimumHeight = current.Layout.minimumHeight;
            next.Layout.fillWidth = true;
            root.implicitHeight += current.Layout.minimumHeight;
        }
        root.implicitHeight += table.anchors.topMargin + table.anchors.bottomMargin
        table.children = newChildren;
    }

    Component.onCompleted: createTable()
}
