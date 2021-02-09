import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0

Rectangle {
    id: root

    //default property alias children: table.children
    property real labelWidth: root.width / 2
    width: Theme.baseSize * 10
    height: Theme.baseSize * 12
    color: Theme.colors.background

    GridLayout {
        id: table
        anchors.fill: parent
        rowSpacing: 0
        columnSpacing: 0
        columns: 2
        clip: true
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
        }
    }

    Component {
        id: tableEnd
        Item { Layout.fillHeight: true }
    }

    function blabla() {
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
            new_children[i+1].Layout.minimumHeight = Theme.baseSize;
        }
        new_children.push(tableEnd.createObject());
        table.children = new_children;
    }

    Component.onCompleted: {
        blabla();
    }
}
