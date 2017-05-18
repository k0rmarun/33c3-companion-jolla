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

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    SilicaFlickable {
        id: flickable
        width: parent.width
        anchors.fill: parent


        contentHeight: content.height

        Component.onCompleted: {
            console.log(height)
            console.log(data.height)
            console.log(contentHeight)
        }

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
                title: Memory.get("subdata").title
            }

            Label {
                text:"Title:"
                color: Theme.primaryColor
            }

            Label {
                text: Memory.get("subdata").title
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width
            }

            Label {
                text:"Subtitle:"
                color: Theme.primaryColor
            }

            Label {
                text: Memory.get("subdata").subtitle
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width
            }

            Label {
                text:"Room:"
                color: Theme.primaryColor
            }

            Label {
                text: Memory.get("subdata").room
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width
            }

            Label {
                text:"Schedule:"
                color: Theme.primaryColor
            }

            Label {
                text: Memory.get("subdata").start+" - "+Memory.get("subdata").end
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width
            }

            Label {
                text:"Type:"
                color: Theme.primaryColor
            }

            Label {
                text: Memory.get("subdata").type
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width
            }

            Label {
                text:"Hints:"
                color: Theme.primaryColor
            }

            Label {
                text: (Memory.get("subdata").do_not_record) ? "Do not record" : "-"
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width
            }

            Button {
                text: "Watch live"
                onClicked: {
                }
            }

            Label {
                text:"Abstract:"
                color: Theme.primaryColor
            }

            Label {
                text: Memory.get("subdata").abstract
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width
                font.pixelSize: Theme.fontSizeTiny
            }
            Label {
                text:"Description:"
                color: Theme.primaryColor
            }

            Label {
                text: Memory.get("subdata").description
                wrapMode: Text.Wrap
                color: Theme.highlightColor
                width: parent.width
                font.pixelSize: Theme.fontSizeTiny
            }

            VerticalScrollDecorator {
            }

        }
    }

}
