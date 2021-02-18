import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0

Rectangle {
    id: root

    property real labelWidth: root.width / 2
    width: Theme.baseSize * 10
    height: Theme.baseSize * 12
    color: Theme.colors.background
    clip: true

    Flickable {
        anchors.fill: parent
        contentWidth: table.width
        contentHeight: table.height
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds

        GridLayout {
            id: table
            width: root.width
            rowSpacing: 0
            columnSpacing: 0
            columns: 2
        }

        ScrollBar.vertical: ScrollBar {
            visible: table.height > root.height
        }
    }

    Component {
        id: label
        Text {
            text: "Label"
            font.pixelSize: Theme.auxFontSize
            color: Theme.colors.description
            elide: Text.ElideRight
            Layout.leftMargin: Theme.padding
            Layout.rightMargin: Theme.padding
            Layout.preferredWidth: labelWidth
            verticalAlignment: Text.AlignVCenter
        }
    }

    Component {
        id: tableEnd
        Item { Layout.fillHeight: true }
    }

    function createTable() {
        var new_children = Object.values(children).splice(1, children.length);
        var length = new_children.length;
        for (var i = 0; i < length * 2; i += 2) {
            new_children.splice(i, 0, label.createObject());

            if (new_children[i+1] instanceof Slider || new_children[i+1] instanceof RadioButton || new_children[i+1] instanceof CheckBox || new_children[i+1] instanceof Switch ) {
                new_children[i].text = new_children[i+1].text;
                new_children[i+1].text = "";
                new_children[i+1].leftPadding = 0;
            }
            else {
                new_children[i].text = new_children[i+1].labelText;
                new_children[i+1].labelText = "";
                new_children[i+1].table = true;
            }

            new_children[i+1].Layout.fillWidth = true;
            new_children[i].Layout.minimumHeight = Theme.baseSize;
            new_children[i+1].Layout.minimumHeight = Theme.baseSize;
        }
        new_children.push(tableEnd.createObject());
        table.children = new_children;
    }

    Component.onCompleted: {
        createTable();
    }
}
