import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.companion 1.0

Page {
    id: page

    property var loader

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    ListModel {
        id: eventModel
        ListElement {
            name: qsTr("34. Chaos Communication Congress")
            cachename: "%0c3"
            iteration: 2017
            url: "https://fahrplan.events.ccc.de/congress/%0/Fahrplan/schedule.json"
        }
        ListElement {
            name: qsTr("17. Gulasch Programmier Nacht")
            cachename: "gpn%0"
            iteration:17
            url: "https://entropia.de/GPN%0:Fahrplan:JSON?action=raw"
        }
        ListElement {
            name: qsTr("MRMCD 17")
            cachename: "mrmcd%0"
            iteration: 2017
            url: "https://%0.mrmcd.net/fahrplan/schedule.json"
        }
    }

    SilicaListView {
        id: listView

        x: Theme.paddingMedium
        width: parent.width - 2*Theme.paddingMedium

        model: eventModel
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
                page.loader.setCurrent(model.cachename, model.url, model.iteration);
                pageStack.pop();
            }

        }

        VerticalScrollDecorator {}
    }
}
