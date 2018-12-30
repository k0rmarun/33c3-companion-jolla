import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.companion 1.0

Page {
    id: page

    property var loader

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    SilicaListView {
        id: listView

        x: Theme.paddingMedium
        width: parent.width - 2*Theme.paddingMedium

        model: eventList
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Choose event")
        }
        delegate: ListItem {
            id: delegate

            Label {
                id: title

                x: Theme.paddingMedium
                text: model.name
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width-2*Theme.paddingMedium
            }

            onClicked: {
                page.loader.setCurrent(model.name, model.url);
                pageStack.pop();
            }

        }

        VerticalScrollDecorator {}
    }
}
