import QtQuick 2.6
import Industrial.Controls 1.0
import QtQml.Models 2.1

Rectangle {
    id: root

    property int labelWidth: listView.width / 2

    width: Theme.baseSize * 8
    height: Theme.baseSize * 16

    ListView {
        id: listView
        anchors.fill: parent
        spacing: 0
        model: ObjectModel {id: listModel}
        clip: true
        boundsBehavior: Flickable.StopAtBounds
    }

    Component {
        id: listDelegate
        Row {
            Text {
                text: "Label"
                font.pixelSize: Theme.auxFontSize
                color: Theme.colors.description
                width: labelWidth
                leftPadding: Theme.padding
                rightPadding: Theme.padding
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    function blabla() {
        var length = children.length;
        for (var i = 0; i <  length - 1; ++i) {
            listModel.append(listDelegate.createObject());

            //listModel.get(i).children[0].text = children[1].labelText;

            listModel.get(i).children.push(children[1]);
            listModel.get(i).children[1].width = listView.width - labelWidth;

            if (listModel.get(i).children[1] instanceof Slider || listModel.get(i).children[1] instanceof RadioButton || listModel.get(i).children[1] instanceof CheckBox || listModel.get(i).children[1] instanceof Switch ) {
                listModel.get(i).children[0].text = listModel.get(i).children[1].text;
                listModel.get(i).children[1].text = "";
                listModel.get(i).children[1].leftPadding = 0;
            }
            else {
                listModel.get(i).children[0].text = listModel.get(i).children[1].labelText;
                listModel.get(i).children[1].labelText = "";
                listModel.get(i).children[1].table = true;
            }
            //*/
        }
    }

    function listProperty(item) {
        for (var p in item) {
            if( typeof item[p] != "function" )
                if(p !== "objectName")
                    console.log(p + ":" + item[p]);
        }
    }

    Component.onCompleted: {
        blabla();
        //console.log(children.length)
        //console.log(listModel.get(1).children[0])
        //console.log(listProperty(listModel.get(1).children[0]))
        //console.log(listProperty(listModel.get(1).children[0].id))
    }
}
