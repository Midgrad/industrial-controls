import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0

Rectangle {
    id: root

    property alias backgroundColor: root.color
    property real padding: Theme.padding
    property real topPadding
    property real bottomPadding
    property real leftPadding
    property real rightPadding
    property real labelWidth: root.width / 2
    property real rowSpacing: 0
    property real columnSpacing: Theme.padding

    width: Theme.baseSize * 10
    color: Theme.colors.background
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
        var new_children = Object.values(children).splice(1, children.length);
        var length = new_children.length;
        for (var i = 0; i < length * 2; i += 2) {
            new_children.splice(i, 0, label.createObject());

            if (new_children[i+1] instanceof Slider || new_children[i+1] instanceof RadioButton || new_children[i+1] instanceof CheckBox || new_children[i+1] instanceof Switch ) {
                new_children[i].text = new_children[i+1].text;
                new_children[i+1].text = "";
            }
            else {
                new_children[i].text = new_children[i+1].labelText;
                new_children[i+1].labelText = "";
                new_children[i+1].table = true;
            }

            new_children[i].Layout.minimumHeight = Theme.baseSize;
            new_children[i].Layout.wrapMode = Text.Wrap;
            new_children[i].Layout.minimumWidth = labelWidth;
            new_children[i+1].Layout.minimumHeight = new_children[i].Layout.minimumHeight;
            new_children[i+1].Layout.fillWidth = true;
            root.implicitHeight += new_children[i].Layout.minimumHeight;
        }
        root.implicitHeight += table.anchors.topMargin + table.anchors.bottomMargin
        table.children = new_children;
    }

    Component.onCompleted: {
        createTable();
    }
}
