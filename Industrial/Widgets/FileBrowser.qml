import QtQuick 2.6
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtQuick.Controls.Styles 1.2
import Industrial.Controls 1.0 as Controls
import Industrial 1.0

Controls.Frame {
    id: root

    property string acceptLabel: qsTr("Open")
    property string rejectLabel: qsTr("Cancel")
    property string title: ""
    property int windowHeight
    property int windowWidth

    property url fileUrl: fileUrls.length === 1 ? fileUrls[0] : ""
    property var fileUrls: {
        var urls = [];
        fileView.selection.forEach(function (i) {
            urls.push(dirModel.get(i, FileBrowserModel.Url));
        });
        return urls;
    }
    property var shortcuts: dirModel.getShortcuts()
    property var favorites: []

    property string defaultSuffix: ""
    property var nameFilters: []
    property string selectedNameFilter: nameFilters.length === 0 ? "" : nameFilters[0]

    property bool selectExisting: true
    property bool selectFolder: false
    property bool selectMultiple: false
    property bool sidebarVisible: true

    property alias folder: dirModel.folder
    property alias showHidden: dirModel.showHidden

    property RegExpValidator filenameValidator: RegExpValidator {
        regExp: /^[A-zЁёА-я0-9 _\-\(\)!@#\.\+]*$/
    }

    property var _history: []
    property int _historyPosition: -1
    property int _sidebarWidth: Controls.Theme.baseSize * 5

    signal accepted()
    signal rejected()

    function bytesToDisplayString(bytes) {
        bytes = Number(bytes);
        var base = 1000;
        var postfixes = [qsTr("bytes"), qsTr("KB"), qsTr("MB"), qsTr("GB")];
        var index = 0;
        while (bytes > base && index + 1 < postfixes.length) {
            bytes /= base;
            ++index;
        }
        return bytes.toFixed(index ? 1 : 0).toString() + " " + postfixes[index];
    }

    function _accept() {
        if (selectFolder) {
            if (fileUrls.length === 0) {
                fileUrls = [folder];
            }
        }
        else if (!selectExisting && fileUrls.length === 1) {
            if (!dirModel.exists(dirModel.urlToName(fileUrls[0]))
                    && dirModel.urlToSuffix(fileUrls[0]) === "") {
                fileUrls[0] = fileUrls[0] + defaultSuffix;
            }
        }
        accepted();
    }

    Component.onCompleted: {
        if (folder.length === 0) {
            if (settings.lastFolder === "") {
                folder = shortcuts.home;
            }
            else {
                folder = settings.lastFolder;
            }
        }
    }

    Component.onDestruction: {
        settings.lastFolder = folder;
    }

    onVisibleChanged: {
        if (visible) {
            pathViewUpdate.restart();
            fileView.selection.clear();
            nameField.text = "";
        }
    }

    onFolderChanged: {
        if (folder !== _history[_historyPosition]) {
            ++_historyPosition;
            _history = _history.slice(0, _historyPosition);
            _history.push(folder);
        }
    }

    visible: false
    padding: 0

    width: Controls.Theme.baseSize * 25 < windowWidth ? Controls.Theme.baseSize * 25 : windowWidth
    height: Controls.Theme.baseSize * 14 < windowHeight ? Controls.Theme.baseSize * 14 : windowHeight

    Settings {
        id: settings
        category: "Industrial.FileBrowser"
        property string lastFolder: ""
        property alias showHidden: root.showHidden
        property alias sidebarVisible: root.sidebarVisible
        property alias sidebarWidth: root._sidebarWidth
        property alias favorites: root.favorites
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Controls.Label {
            visible: title.length > 0
            text: title
            font.weight: Font.Medium
            Layout.alignment: Qt.AlignCenter
        }

        Controls.Pane {
            implicitHeight: Controls.Theme.baseSize + padding * 2
            padding: Controls.Theme.padding
            Layout.fillWidth: true

            RowLayout {
                anchors.fill: parent
                spacing: Controls.Theme.padding

                Controls.ButtonBar {
                    id: arrowButtons
                    setButtonWidth: false

                    Controls.Button {
                        enabled: _historyPosition > 0
                        iconSource: "/icons/left.svg"
                        onClicked: {
                            --_historyPosition;
                            folder = _history[_historyPosition];
                        }
                    }

                    Controls.Button {
                        enabled: _historyPosition + 1 < _history.length
                        iconSource: "/icons/right.svg"
                        onClicked: {
                            ++_historyPosition;
                            folder = _history[_historyPosition];
                        }
                    }

                    Controls.Button {
                        iconSource: "/icons/up.svg"
                        onClicked: folder = dirModel.parentFolder
                    }
                }

                Controls.ButtonBar {
                    id: pathView
                    setButtonWidth: false
                    Layout.fillWidth: true

                    function update() {
                        var buttons = [];

                        for (var i = 0; i < children.length; ++i) {
                            var item = children[i];

                            if (item instanceof Controls.Button) {
                                buttons.push(item);
                            }
                        }

                        var widthLeft = width - spacing;
                        var visibleCnt = 0;

                        for (var j = buttons.length - 1; j >= 0; --j) {
                            var button = buttons[j];
                            button.visible = true;
                            button.height = Controls.Theme.baseSize;

                            if (button.implicitWidth + spacing > widthLeft) {
                                for (; j >= 0; --j) {
                                    buttons[j].visible = false;
                                }
                                break;
                            }
                            else {
                                widthLeft -= button.implicitWidth + spacing;
                                ++visibleCnt;
                            }
                        }

                        var addWidth = 0;
                        if (visibleCnt != buttons.length) {
                            addWidth = Math.floor(widthLeft / visibleCnt);
                        }

                        var sum = 0;
                        for (var k = 0; k < buttons.length; ++k) {
                            var visButton = buttons[k];

                            if (visButton.visible)
                                visButton.width = visButton.implicitWidth + addWidth;
                        }
                    }

                    onWidthChanged: pathViewUpdate.start();

                    Repeater {
                        model: dirModel.pathComponents
                        delegate: Controls.Button {
                            padding: Controls.Theme.padding
                            text: modelData.name
                            onClicked: folder = modelData.url
                        }

                        onModelChanged: parent.update()
                        Component.onCompleted: parent.update()
                    }

                    Timer {
                        id: pathViewUpdate
                        interval: 50
                        onTriggered: {
                            stop();
                            parent.update();
                        }
                    }
                }

                Controls.Button {
                    id: optionsButton
                    iconSource: "/icons/burger.svg"
                    Layout.alignment: Qt.AlignRight
                    highlighted: optionsPopup.visible
                    onClicked: {
                        if (optionsPopup.opened) {
                            optionsPopup.close();
                        }
                        else {
                            optionsPopup.open();
                        }
                    }
                }

                Controls.Menu {
                    id: optionsPopup
                    x: parent.width - width
                    y: parent.height
                    backgroundColor: Controls.Theme.colors.raised

                    Controls.MenuItem {
                        text: qsTr("New folder")
                        onClicked: {
                            createDir.open();
                            optionsPopup.close();
                        }
                    }

                    Controls.MenuItem {
                        text: qsTr("Rename")
                        enabled: fileUrls.length === 1
                        onClicked: {
                            renamePopup.open();
                            optionsPopup.close();
                        }
                    }

                    Controls.MenuItem {
                        text: qsTr("Delete files")
                        enabled: fileUrls.length !== 0
                        onClicked: {
                            deletePopup.open();
                            optionsPopup.close();
                        }
                    }

                    Controls.MenuSeparator {}

                    Controls.MenuItem {
                        id: favoriteButton

                        property int favoriteIndex: {
                            for (var i = 0; i < favorites.length; ++i) {
                                if (favorites[i].url === folder) {
                                    return i;
                                }
                            }
                            return -1;
                        }

                        enabled: {
                            for (var i = 0; i < shortcuts.displayList.length; ++i) {
                                if (shortcuts.displayList[i].url === folder) {
                                    return false;
                                }
                            }
                            return true;
                        }
                        text: favoriteIndex !== -1 ? qsTr("Remove from favorites") : qsTr("Add to favorites")
                        onClicked: {
                            var newFavs = favorites;
                            if (favoriteIndex === -1) {
                                newFavs.push( { name: dirModel.urlToName(folder), url: folder } );
                            }
                            else {
                                newFavs.splice(favoriteIndex, 1);
                            }
                            favorites = newFavs;
                        }
                    }

                    Controls.MenuSeparator {}

                    Controls.MenuItem {
                        text: qsTr("Show hidden")
                        checkable: true
                        checked: showHidden
                        onClicked: showHidden = checked
                    }

                    Controls.MenuItem {
                        text: qsTr("Show side panel")
                        checkable: true
                        checked: sidebarVisible
                        onClicked: sidebarVisible = checked
                    }
                }

                Controls.Popup {
                    id: createDir
                    x: parent.width - width
                    y: parent.height
                    width: Controls.Theme.baseSize * 10

                    function doCreate() {
                        if (dirModel.createFolder(createDirName.text)) {
                            createDir.close();
                        }
                        else {
                            createDirName.isValid = false;
                        }
                    }

                    onClosed: {
                        createDirName.text = "";
                        createDirName.isValid = true;
                    }

                    ColumnLayout {
                        anchors.fill: parent

                        Controls.Label {
                            text: qsTr("Create new folder")
                            type: Controls.Theme.Title
                        }

                        Controls.TextField {
                            id: createDirName
                            labelText: qsTr("Folder name")
                            validator: filenameValidator
                            onAccepted: createDir.doCreate()
                            Layout.fillWidth: true
                        }

                        Controls.ButtonBar {
                            Layout.fillWidth: true

                            Controls.Button {
                                text: qsTr("Create")
                                highlighted: true
                                onClicked: {
                                    if (createDirName.acceptableInput)
                                        createDir.doCreate();
                                }
                            }

                            Controls.Button {
                                text: qsTr("Cancel")
                                onClicked: createDir.close()
                            }
                        }
                    }
                }

                Controls.Popup {
                    id: renamePopup
                    x: parent.width - width
                    y: parent.height
                    width: Controls.Theme.baseSize * 10

                    function doRename() {
                        if (dirModel.renameFile(dirModel.urlToName(fileUrl), renameName.text)) {
                            renamePopup.close();
                        }
                        else {
                            renameName.isValid = false;
                        }
                    }

                    onClosed: {
                        renameName.text = "";
                        renameName.isValid = true;
                    }

                    ColumnLayout {
                        anchors.fill: parent

                        Controls.Label {
                            text: qsTr("Rename file")
                            type: Controls.Theme.Title
                        }

                        Controls.TextField {
                            id: renameName
                            labelText: qsTr("New name")
                            validator: filenameValidator
                            onAccepted: renamePopup.doRename()
                            Layout.fillWidth: true
                        }

                        Controls.ButtonBar {
                            Layout.fillWidth: true

                            Controls.Button {
                                text: qsTr("Rename")
                                highlighted: true
                                onClicked: {
                                    if (renameName.acceptableInput)
                                        renamePopup.doRename();
                                }
                            }

                            Controls.Button {
                                text: qsTr("Cancel")
                                onClicked: renamePopup.close()
                            }
                        }
                    }
                }

                Controls.Popup {
                    id: deletePopup
                    x: parent.width - width
                    y: parent.height
                    width: Controls.Theme.baseSize * 10

                    function doDelete() {
                        for (var i = 0; i < fileUrls.length; ++i) {
                            dirModel.deleteFile(dirModel.urlToName(fileUrls[i]));
                        }
                        deletePopup.close();
                    }

                    ColumnLayout {
                        anchors.fill: parent

                        Controls.Label {
                            text: qsTr("Are you sure?")
                            type: Controls.Theme.Title
                        }

                        Controls.ButtonBar {
                            Layout.fillWidth: true

                            Controls.Button {
                                text: qsTr("Yes")
                                highlighted: true
                                onClicked: deletePopup.doDelete()
                            }

                            Controls.Button {
                                text: qsTr("No")
                                onClicked: deletePopup.close()
                            }
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Item {
                id: sidebar
                visible: sidebarVisible
                anchors.left: parent.left
                anchors.right: sidebarHandle.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                clip: true

                Flickable {
                    anchors.fill: parent
                    contentHeight: sidebarList.implicitHeight
                    flickableDirection: Flickable.VerticalFlick
                    boundsBehavior: Flickable.StopAtBounds

                    ColumnLayout {
                        id: sidebarList
                        anchors.fill: parent
                        spacing: 0

                        Controls.Label {
                            text: qsTr("Locations")
                            type: Controls.Theme.Title
                            padding: Controls.Theme.padding * 0.5
                            leftPadding: Controls.Theme.padding
                            rightPadding: Controls.Theme.padding
                        }

                        ListWrapper {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: Controls.Theme.colors.background

                            model: shortcuts.displayList
                            delegate: sidebarEntry
                        }

                        Controls.Label {
                            text: qsTr("Favorites")
                            type: Controls.Theme.Title
                            padding: Controls.Theme.padding * 0.5
                            leftPadding: Controls.Theme.padding
                            rightPadding: Controls.Theme.padding
                        }

                        ListWrapper {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: Controls.Theme.colors.background

                            model: favorites
                            delegate: sidebarEntry
                        }
                    }

                    Component {
                        id: sidebarEntry

                        Item {
                            readonly property bool isHighlighted: folder === modelData.url
                            width: parent.width
                            height: Controls.Theme.baseSize * 0.75

                            Controls.ContentItem {
                                text: modelData.name
                                anchors.fill: parent
                                anchors.leftMargin: Controls.Theme.padding * 2
                                anchors.rightMargin: Controls.Theme.padding * 2
                                iconSource: "qrc:/icons/folder-2.svg"
                                textColor: isHighlighted ? Controls.Theme.colors.controlText
                                                         : Controls.Theme.colors.description
                                font.pixelSize: Controls.Theme.auxFontSize
                                horizontalAlignment: Qt.AlignLeft
                            }

                            Rectangle {
                                anchors.fill: parent
                                visible: parent.isHighlighted
                                z: -1
                                color: Controls.Theme.colors.control
                                opacity: 0.25
                            }

                            Controls.MouseArea {
                                anchors.fill: parent
                                onClicked: folder = modelData.url
                            }
                        }
                    }

                    Controls.ScrollBar.vertical: Controls.ScrollBar {
                        visible: sidebarList.implicitHeight > sidebar.height
                    }
                }
            }

            Rectangle {
                implicitHeight: 2
                width: parent.width
                anchors.top: parent.top
                color: Controls.Theme.colors.control
                opacity: 0.5
            }

            Rectangle {
                implicitHeight: 2
                width: parent.width
                anchors.bottom: parent.bottom
                color: Controls.Theme.colors.control
                opacity: 0.5
            }

            Item {
                id: sidebarHandle

                readonly property int minWidth: arrowButtons.width + Controls.Theme.padding * 2
                readonly property int maxWidth: root.width / 2

                x: sidebarVisible ? Math.max(minWidth, Math.min(_sidebarWidth, maxWidth)) : 0
                width: 0
                height: parent.height

                MouseArea {
                    x: -width / 2
                    width: Controls.Theme.sliderSize * 2
                    height: parent.height

                    cursorShape: Qt.SizeHorCursor
                    hoverEnabled: true

                    drag.threshold: 0
                    drag.target: parent
                    drag.axis: Drag.XAxis
                    drag.minimumX: parent.minWidth
                    drag.maximumX: parent.maxWidth

                    onPositionChanged: {
                        if (pressed) {
                            _sidebarWidth = parent.x;
                        }
                    }
                }
            }

            TableView {
                id: fileView

                anchors.left: sidebarHandle.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                function isDir(index) {
                    return dirModel.get(index, FileBrowserModel.IsDir);
                }

                selectionMode: selectMultiple ? extendedSelection : singleSelection

                list.color: Controls.Theme.colors.raised
                list.faderColor: Controls.Theme.colors.raised
                list.radius: 0

                list.emptyText: qsTr("No files found")
                list.spacing: 0

                onDoubleClicked: {
                    if (isDir(index)) {
                        folder = dirModel.get(index, FileBrowserModel.Url);
                    }
                }

                model: FileBrowserModel {
                    id: dirModel
                    enabled: root.visible
                    showFiles: !selectFolder
                    nameFiltersFromString: selectedNameFilter

                    sortField: fileView.currentSortRole
                    sortReversed: fileView.currentSortOrder === Qt.DescendingOrder
                }

                TableViewColumn {
                    title: qsTr("Name")
                    width: fileView.width * 0.45
                    role: FileBrowserModel.Name
                    delegate: fileNameDelegate
                }

                TableViewColumn {
                    title: qsTr("Size")
                    width: fileView.width * 0.15
                    role: FileBrowserModel.Size
                    delegate: fileSizeDelegate
                }

                TableViewColumn {
                    title: qsTr("Type")
                    width: fileView.width * 0.1
                    role: FileBrowserModel.Type
                    delegate: fileTypeDelegate
                }

                TableViewColumn {
                    title: qsTr("Modification time")
                    width: fileView.width * 0.3
                    role: FileBrowserModel.ModTime
                    delegate: fileTimeDelegate
                }

                Component {
                    id: fileNameDelegate

                    RowLayout {
                        width: styleData.width
                        height: Controls.Theme.baseSize

                        Controls.ColoredIcon {
                            source: fileView.isDir(styleData.row) ?
                                        "qrc:/icons/folder.svg" : "qrc:/icons/file.svg"
                            color: fileView.isDir(styleData.row) ?
                                       Controls.Theme.colors.link : Controls.Theme.colors.fileIcon
                            implicitHeight: Controls.Theme.baseSize
                            implicitWidth: implicitHeight
                        }

                        Controls.Label {
                            text: styleData.value
                            Layout.fillWidth: true
                        }
                    }
                }

                Component {
                    id: fileSizeDelegate

                    Controls.Label {
                        width: styleData.width
                        height: Controls.Theme.baseSize

                        text: fileView.isDir(styleData.row) ?
                                  "--" : bytesToDisplayString(styleData.value)
                    }
                }

                Component {
                    id: fileTypeDelegate

                    Controls.Label {
                        width: styleData.width
                        height: Controls.Theme.baseSize

                        text: fileView.isDir(styleData.row) ? qsTr("Folder") : styleData.value
                    }
                }

                Component {
                    id: fileTimeDelegate

                    Controls.Label {
                        width: styleData.width
                        height: Controls.Theme.baseSize

                        text: styleData.value.toLocaleString(Qt.locale(), Locale.ShortFormat)
                    }
                }
            }
        }

        Controls.Pane {
            id: bottomPane
            padding: Controls.Theme.padding
            Layout.fillWidth: true

            RowLayout {
                anchors.fill: parent
                spacing: Controls.Theme.padding

                Controls.Label {
                    id: nameLabel
                    text: qsTr("File name")
                    type: Controls.Theme.Label
                    visible: !selectExisting
                }

                Controls.TextField {
                    id: nameField
                    Layout.fillWidth: true
                    validator: filenameValidator
                    onAccepted: fileUrls = [text]
                    visible: !selectExisting
                }

                Controls.Label {
                    id: filterLabel
                    text: qsTr("File type")
                    type: Controls.Theme.Label
                    visible: filterList.visible
                }

                Controls.ComboBox {
                    id: filterList
                    visible: nameFilters.length !== 0 && !selectFolder
                    Layout.fillWidth: true
                    model: nameFilters
                    currentIndex: nameFilters.indexOf(selectedNameFilter)
                    onActivated: {
                        selectedNameFilter = nameFilters[index];
                    }
                }

                Controls.ButtonBar {
                    setButtonWidth: false
                    Layout.alignment: Qt.AlignRight

                    Controls.Button {
                        enabled: fileUrls.length !== 0
                        highlighted: true

                        text: acceptLabel
                        padding: Controls.Theme.padding * 4
                        height: Controls.Theme.baseSize

                        onClicked: {
                            root.visible = false;
                            root._accept();
                        }
                    }

                    Controls.Button {
                        text: rejectLabel
                        padding: Controls.Theme.padding * 4
                        height: Controls.Theme.baseSize

                        onClicked: {
                            root.visible = false;
                            root.rejected();
                        }
                    }
                }
            }
        }
    }

    MouseArea {
        id: resize
        anchors {
            right: parent.right
            bottom: parent.bottom
        }
        width: Controls.Theme.baseSize * 0.4
        height: Controls.Theme.baseSize * 0.4
        cursorShape: Qt.SizeFDiagCursor

        property point clickPos: "1,1"

        onPressed: {
            resize.clickPos = Qt.point(mouse.x, mouse.y)
        }

        onPositionChanged: {
            var delta = Qt.point(mouse.x - resize.clickPos.x, mouse.y - resize.clickPos.y)
            root.width = root.width + delta.x < windowWidth ? root.width + delta.x : windowWidth
            root.height = root.height + delta.y < windowHeight ? root.height + delta.y : windowHeight
            if (root.width < Controls.Theme.baseSize * 10) root.width = Controls.Theme.baseSize * 10;
            if (root.height < Controls.Theme.baseSize * 6) root.height = Controls.Theme.baseSize * 6;
        }

        Canvas {
            id: canvas
            anchors.fill: parent

            onPaint: {
                var ctx = canvas.getContext('2d');
                ctx.clearRect(0, 0, width, height);
                ctx.fillStyle = Controls.Theme.colors.control;
                ctx.globalAlpha = 0.5;
                ctx.beginPath();
                ctx.moveTo(width, 0);
                ctx.lineTo(width, height);
                ctx.lineTo(0, height);
                ctx.closePath();
                ctx.fill();
            }
        }
    }
}
