import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Widgets 1.0
import Industrial.Controls 1.0

Pane {
    id: root

    property var groupSelected: null
    property var itemSelected: null
    property real stepSizeTree: Theme.baseSize * 0.5
    property var groupExpanded: []
    property bool dragEnabled: true

    padding: Theme.padding * 2

    function sumArray(array) {
        var sum = 0;
        array.forEach(function(value, index) {
            sum += value;
        });
        return sum;
    }

    RowLayout {
        anchors.fill: parent
        spacing: Theme.spacing

        Item { Layout.fillWidth: true }

        //Simple list
        ListWrapper {
            id: itemList

            Layout.fillWidth: true
            Layout.fillHeight: true

            model: itemModel

            delegate: Draggable {
                width: parent.width
                draggedItemParent: itemList
                onMoveItemRequested: itemModel.move(from, to, 1)
                onClicked: root.itemSelected = model

                Loader {
                    sourceComponent: itemComponent
                    property var _model: model
                    property string _text: model.text
                    property real _leftMargin: Theme.padding
                    width: parent.width
                }
            }
        }

        //Expanded list
        ListWrapper {
            id: groupList

            Layout.fillWidth: true
            Layout.fillHeight: true

            model: groupModel

            delegate: Draggable {
                width: parent.width
                draggedItemParent: groupList
                dragEnabled: root.dragEnabled
                onMoveItemRequested: groupModel.move(from, to, 1);
                onClicked: root.groupSelected = model
                onDoubleClicked: {
                    loader._expanded = !loader._expanded;
                    root.groupSelected = model;
                }

                Loader {
                    id: loader
                    sourceComponent: groupComponent
                    property var _model: model
                    property string _text: model.text
                    property bool _expanded: false
                    width: parent.width
                }
            }
        }
    }

    ListModel{
        id: groupModel
        ListElement{ text: "Alpha" }
        ListElement{ text: "Beta" }
        ListElement{ text: "Gamma" }
        ListElement{ text: "Delta" }
        ListElement{ text: "Epsilon" }
        ListElement{ text: "Zeta" }
        ListElement{ text: "Eta" }
    }

    ListModel{
        id: itemModel
        ListElement{ text: "Apple" }
        ListElement{ text: "Banana" }
        ListElement{ text: "Cherry" }
        ListElement{ text: "Grapefruit" }
        ListElement{ text: "Lemon" }
        ListElement{ text: "Mango" }
        ListElement{ text: "Raspberry" }
    }

    Component {
        id: groupComponent

        Item {
            id: control
            property var groupContent: _model
            property bool expanded: _expanded
            height: !expanded ? Theme.baseSize : Theme.baseSize + itemList.implicitHeight

            ColumnLayout {
                id: column
                anchors.fill: parent
                spacing: 0

                Rectangle {
                    id: backgraund
                    Layout.fillWidth: true
                    implicitHeight: Theme.baseSize
                    color: (groupContent === root.groupSelected  && expanded) ? Theme.colors.line :
                                 (groupContent === root.groupSelected) ?
                                     Theme.colors.selection : "transparent"
                    radius: Theme.rounding

                    RowLayout {
                        id: row
                        anchors.fill: parent
                        anchors.leftMargin: Theme.padding
                        anchors.rightMargin: Theme.padding

                        Button {
                            id: expandButton
                            type: groupContent === root.groupSelected ? Theme.LinkPrimary : Theme.LinkSecondary
                            iconSource: expanded ? "qrc:/icons/down.svg" : "qrc:/icons/right.svg"
                            round: true
                            onClicked: {
                                _expanded = !_expanded;
                                root.groupSelected = groupContent
                            }
                        }

                        Label {
                            type: Theme.Text
                            text: _text
                            Layout.fillWidth: true
                        }

                        Button {
                            id: visibilityButton
                            type: groupContent === root.groupSelected ? Theme.LinkPrimary : Theme.LinkSecondary
                            checkedTextColor: groupContent === root.groupSelected ?
                                                  Theme.colors.text : Theme.colors.highlight
                            iconSource: checked ? "qrc:/icons/password_hide.svg" : "qrc:/icons/password_show.svg"
                            round: true
                            checkable: true
                        }
                    }
                }

                //Simple list
                ListWrapper {
                    id: itemList

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    visible: expanded

                    onVisibleChanged: {
                        //Записываем все открытые группы в массив
                        root.groupExpanded[_model.index] = control.expanded;
                        //Если одна группа открытая, то dragEnabled запрещен на этом уровне
                        root.dragEnabled = !sumArray(root.groupExpanded);
                    }

                    model: itemModel

                    delegate: Draggable {
                        width: parent.width
                        draggedItemParent: itemList
                        onMoveItemRequested: itemModel.move(from, to, 1)
                        onClicked: {
                            root.itemSelected = model;
                            root.groupSelected = groupContent;
                        }

                        Loader {
                            sourceComponent: itemComponent
                            property var _model: model
                            property string _text: model.text
                            property real _leftMargin: Theme.padding + expandButton.width +
                                                       row.spacing + root.stepSizeTree
                            width: parent.width
                        }
                    }
                }
            }
        }
    }

    Component {
        id: itemComponent

        Item {
            id: control
            property var itemContent: _model
            height: Theme.baseSize

            Rectangle {
                id: backgraund
                anchors.fill: parent
                color: (itemContent === root.itemSelected) ? Theme.colors.selection : "transparent"
                radius: Theme.rounding

                RowLayout {
                    id: row
                    anchors.fill: parent
                    anchors.leftMargin: _leftMargin
                    anchors.rightMargin: Theme.padding

                    Label {
                        type: Theme.Text
                        text: _text
                        Layout.fillWidth: true
                    }

                    Button {
                        id: visibilityButton
                        type: itemContent === root.itemSelected ? Theme.LinkPrimary : Theme.LinkSecondary
                        checkedTextColor: itemContent === root.itemSelected ?
                                              Theme.colors.text : Theme.colors.highlight
                        iconSource: checked ? "qrc:/icons/password_hide.svg" : "qrc:/icons/password_show.svg"
                        round: true
                        checkable: true
                    }
                }
            }
        }
    }
}
