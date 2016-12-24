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

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        PullDownMenu {
            MenuItem {
                text: "Update schedule"
                onClicked: {
                    update.execute("Updating schedule",function(){
                        schedule.loadFromNetwork();
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
                title: qsTr("CC3C Companion")
            }

            Label {
                text: "Updating..."
                visible: schedule.updating
            }

            ColumnView{
                model:JSON.parse(schedule.schedule).schedule.conference.days
                width: parent.width
                itemHeight: Theme.itemSizeSmall
                delegate: BackgroundItem {
                    width: parent.width
                    Label {
                        text: "Day " + (model.index+1) + ": " + modelData.date
                        color: Theme.primaryColor
                    }

                    onClicked: {
                        var base = JSON.parse(schedule.schedule).schedule.conference.days[model.index];
                        var data = base.rooms;
                        var newData = []
                        var timed = {}
                        for(var keys in data){
                            for(var elem in data[keys]){
                                var tmp = data[keys][elem]
                                if(!timed[tmp.start]){
                                    timed[tmp.start] = []
                                }

                                timed[tmp.start].push(tmp);
                            }
                        }
                        for(var time in timed){
                            for(var elem1 in timed[time]){
                                var tmp1 = timed[time][elem1]
                                var start = tmp1.start

                                var hours = parseInt(start[0]+start[1])
                                var dhours = parseInt(tmp1.duration[0]+tmp1.duration[1])
                                var minute = parseInt(start[3]+start[4])
                                var dminute = parseInt(tmp1.duration[3]+tmp1.duration[4])

                                var endTime = (hours*60)+minute+(dhours*60)+dminute
                                var end = Global.padLeft(Math.floor(endTime/60),2)+":"+Global.padLeft(endTime%60,2)
                                tmp1["end"] = end;

                                newData.push(tmp1)
                            }
                        }

                        Memory.set("model", newData)
                        Memory.set("title", base.date)
                        pageStack.push(Qt.resolvedUrl("DateView.qml"));
                    }
                }
            }
        }
    }
}

