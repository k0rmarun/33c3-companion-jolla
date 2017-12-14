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

    Loader{
        id: loader
    }

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        leftMargin: Theme.paddingMedium
        rightMargin: Theme.paddingMedium
        anchors.fill: parent

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        PullDownMenu {

            MenuItem {
                text: qsTr("Select conference")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("SelectConferenceView.qml"), {loader:loader});
                }

            }

            MenuItem {
                text: "Update schedule"
                onClicked: {
                    update.execute("Updating schedule",function(){
                        loader.loadFromNetwork();
                    })
                }             
            }
        }

        RemorsePopup {
            id: update
        }

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingSmall
            PageHeader {
                title: qsTr("Chaos Companion")
            }

            Label {
                text: "Updating..."
                visible: loader.loading
            }

            ColumnView{
                model:JSON.parse(loader.schedule).schedule.conference.days
                width: parent.width
                itemHeight: Theme.itemSizeSmall
                delegate: BackgroundItem {
                    width: parent.width
                    Label {
                        text: "Day " + (model.index+1) + ": " + modelData.date
                        color: Theme.primaryColor
                    }

                    onClicked: {
                        var base = JSON.parse(loader.schedule).schedule.conference.days[model.index];
                        var data = base.rooms;
                        pageStack.push(Qt.resolvedUrl("DateView.qml"), {model:base.rooms, title:base.date});
                    }
                }
            }
        }
    }
}

