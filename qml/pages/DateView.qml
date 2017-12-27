/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.companion 1.0
import "../js/Global.js" as Global

Page {
    id: page
    property var model
    property string title
    property bool order: false

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    SilicaListView {

        PullDownMenu {

            MenuItem {
                text: page.order ? qsTr("Sort by time") : qsTr("Sort by place")
                onClicked: {
                    page.order = !page.order
                    page.model = Global.orderBy(page.model, page.order);
                }
            }
        }

        id: listView

        x: Theme.paddingMedium
        width: parent.width - 2*Theme.paddingMedium

        model: page.model
        anchors.fill: parent
        header: PageHeader {
            title: page.title
        }
        delegate: ListItem {
            id: delegate
            height: title.contentHeight + times.contentHeight
            contentHeight: title.contentHeight + times.contentHeight

            Label {
                id: title

                x: Theme.paddingMedium
                text: modelData.title
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width-2*Theme.paddingMedium
            }
            Label {
                id: times
                x: Theme.paddingMedium
                text: modelData.start + " - " + modelData.end
                anchors.top: title.bottom
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
            }

            Label {
                id: rooms

                text: modelData.room
                anchors.top: title.bottom
                anchors.right: title.right
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
            }

            onClicked: {
                pageStack.push(Qt.resolvedUrl("EventView.qml"), {event:modelData});
            }

        }

        VerticalScrollDecorator {}

        Component.onCompleted: {
            page.model = Global.orderBy(Global.groupByTime(page.model), page.order);
        }
    }
}
