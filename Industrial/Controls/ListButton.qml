import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0

Rectangle {
    id: control

    property bool expanded: false
    property bool selected: false
    property bool hovered: false
    property int amount: 0
    property int leftPadding: Theme.padding
    property int rightPadding: Theme.padding * 2

    /////////////////////////////
    //property alias expandEnabled ///////////////: button.enabled //TODO: удалить параметр //////////////////////////////////////////
    //property alias buttonText ////////////////: button.text /////////////////////////////////////////////////////////////////////
    property bool expandEnabled
    property string buttonText
    /////////////////////////////////

    property alias labelText: label.text
    property alias horizontalAlignment: label.horizontalAlignment ////////////////////////////////
    property alias amountVisible: amountLabel.visible

    signal clicked()
    //signal pressed()
    //signal doubleClicked()

    implicitHeight: Theme.baseSize
    radius: Theme.rounding
    color: selected ? Theme.colors.selection : hovered ? Theme.colors.hover : expanded ?
       Theme.colors.line : "transparent"
    //color: selected ? Theme.colors.selection : hovered ? "Red" : expanded ?
       //Theme.colors.line : "Grey"



    MouseArea {
        id: mouseArea
        anchors.fill: parent
        propagateComposedEvents: true

//        hoverEnabled: true
//        onEntered: hovered = true;
//        onExited: hovered = false;//////////////////////////////

//        onDoubleClicked: {////////////////////////////////
//            control.doubleClicked();
//            mouse.accepted = false;

//            console.log("2222222222222");/////////////////////////
//        }

        //onClicked: {
        onPressed: {
            control.clicked();
            mouse.accepted = false;
        }

//        onPressed: {
//            control.pressed();
//            mouse.accepted = false;
//        }
    }

    RowLayout {
        id: layout
        spacing: 0
        anchors.fill: parent
        anchors.leftMargin: 0
        anchors.rightMargin: rightPadding

        ContentItem {
            id: icon
            implicitHeight: Theme.baseSize
            implicitWidth: Theme.baseSize
            iconSource: control.expanded ? "/icons/down.svg" : "/icons/right.svg"
            iconColor: control.selected ? Theme.colors.controlText : Theme.colors.description
        }

        Label {
            id: label
            type: Theme.Text
            wrapMode: Text.Wrap
            visible: text.length
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Label {
            id: amountLabel
            type: Theme.Label
            color: control.selected ? Theme.colors.text :Theme.colors.description
            text: "(" + amount + ")"
            visible: false
        }
    }
}
