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

    property var event

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    SilicaFlickable {

        PullDownMenu {
            MenuItem {
                text: qsTr("Save to calendar")
                onClicked: {
                    page.event.addToCalendar()
                }
            }
        }

        id: flickable
        width: parent.width
        anchors.fill: parent
        contentHeight: content.height

        Column {
            id: content
            //width: parent.width
            spacing: 2

            x: Theme.paddingMedium
            width: parent.width - 2*Theme.paddingMedium

            anchors.leftMargin: Theme.paddingMedium
            anchors.rightMargin: Theme.paddingMedium

            PageHeader {
                id: header
                title: page.event.title
            }

            Label {
                text:"Title:"
                color: Theme.primaryColor
            }

            Label {
                text: page.event.title
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width
            }

            Label {
                text:"Subtitle:"
                color: Theme.primaryColor
                visible: page.event.subtitle ? true : false
            }

            Label {
                text: page.event.subtitle
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width
                visible: page.event.subtitle ? true : false
                //height: page.event.subtitle ? Theme.fontSizeLarge : 0
            }

            Label {
                text:"Room:"
                color: Theme.primaryColor
            }

            Label {
                text: page.event.room
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width
            }

            Label {
                text:"Schedule:"
                color: Theme.primaryColor
            }

//            Item {
//                width: parent.width
//                anchors.left: parent.width
//                Label {
//                    id: fromLabel
//                    width: 50
//                    height: Theme.itemSizeSmall
//                    text: "From:"
//                }
//                Label {
//                    id: fromValue
//                    width: 50
//                    text: Global.formatDateTime(page.event.start)
//                    height: Theme.itemSizeSmall
//                    anchors.left: fromLabel.right
//                }
//                Label {
//                    id: toLabel
//                    width: 50
//                    height: Theme.itemSizeSmall
//                    anchors.left: fromLabel.left
//                    anchors.top: fromLabel.bottom
//                    text: "From:"
//                }
//                Label {
//                    id: toValue
//                    width: 50
//                    text: Global.formatDateTime(page.event.end)
//                    height: Theme.itemSizeSmall
//                    anchors.left: fromLabel.right
//                    anchors.top: fromLabel.bottom
//                }
//            }

            SilicaListView {
                width: parent.width
                height: Theme.itemSizeExtraSmall
                model: ListModel {
                    ListElement { key: "From:"; value: "start"}
                    ListElement { key: "To:"; value: "end"}
                }
                delegate: ListItem {
                    width: parent.width
                    contentHeight: Theme.itemSizeExtraSmall/2
                    Label {
                        id: gridFrom
                        text: model.key
                        width: Theme.itemSizeMedium
                        color: Theme.primaryColor
                        height: Theme.itemSizeExtraSmall
                    }
                    Label {
                        text: Global.formatDateTime(page.event[model.value])
                        anchors.left: gridFrom.right
                        width: parent.width - gridFrom.width
                        color: Theme.highlightColor
                        height: Theme.itemSizeExtraSmall
                    }
                }

            }

//            Label {
//                text: "From: " + Global.formatDateTime(page.event.start) + "\nTo:       " + Global.formatDateTime(page.event.end)
//                wrapMode: Text.Wrap
//                color: Theme.highlightColor
//                width: parent.width
//            }

            Label {
                text:"Type:"
                color: Theme.primaryColor
            }

            Label {
                text: page.event.type
                font.capitalization: Font.Capitalize
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width
            }

            Label {
                text:"Presenters:"
                color: Theme.primaryColor
            }

            Label {
                text: page.event.persons.join(", ")
                font.capitalization: Font.Capitalize
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width
            }

            Label {
                text:"Hints:"
                color: Theme.primaryColor
            }

            Label {
                text: (page.event.do_not_record) ? "Do NOT record!" : "You may record "+( page.event.recording_licence ? "("+ page.event.recording_licence+")":"")
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width
            }

            Label {
                text:"Language:"
                color: Theme.primaryColor
                visible: page.event.language ? true : false
            }

            Label {
                text: page.event.language
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width
                visible: page.event.language ? true : false
            }


            Button {
                text: "Save to calendar"
                onClicked: {
                    page.event.addToCalendar()
                }
            }

            Label {
                text:"Abstract:"
                color: Theme.primaryColor
                visible: page.event.abstract ? true: false
            }

            Label {
                text: page.event.abstract
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                text:"Description:"
                color: Theme.primaryColor
                visible: page.event.description ? true: false

            }

            Label {
                text: page.event.description
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width
                font.pixelSize: Theme.fontSizeSmall
            }

            VerticalScrollDecorator {
            }

        }
    }

}
