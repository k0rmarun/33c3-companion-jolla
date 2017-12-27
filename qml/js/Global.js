.pragma library

function padLeft(nr, n, str){
    return Array(n-String(nr).length+1).join(str||'0')+nr;
}

// Objects are grouped by place => regroup by time
function groupByTime(objects){
    var newData = []
    var groupedByTime = {}
    for(var room in objects){
        for(var elem in objects[room]){
            var tmp = objects[room][elem]
            if(!groupedByTime[tmp.start]){
                groupedByTime[tmp.start] = []
            }

            groupedByTime[tmp.start].push(tmp);
        }
    }
    for(var time in groupedByTime){
        for(var elem1 in groupedByTime[time]){
            var tmp1 = groupedByTime[time][elem1]
            var start = tmp1.start

            var startHours = parseInt(start[0]+start[1])
            var durationHours = parseInt(tmp1.duration[0]+tmp1.duration[1])
            var startMinute = parseInt(start[3]+start[4])
            var durationMinute = parseInt(tmp1.duration[3]+tmp1.duration[4])

            var endTime = (startHours*60)+startMinute+(durationHours*60)+durationMinute
            var end = padLeft(Math.floor(endTime/60),2)+":"+padLeft(endTime%60,2)
            tmp1["end"] = end;

            newData.push(tmp1);
        }
    }
    return newData
}

function compareTime(aTime, aPlace, bTime, bPlace){
    //Sort by time
    if(aTime > bTime)
        return 1;
    if(aTime < bTime)
        return -1;

    //Same time => Sort by room name
    if(aPlace > bPlace)
        return 1;
    if(aPlace < bPlace)
        return -1;

    //Whatever
    return 0;
}

function comparePlace(aTime, aPlace, bTime, bPlace){
    //Sort by room name
    if(aPlace > bPlace)
        return 1;
    if(aPlace < bPlace)
        return -1;

    //Sort by time
    if(aTime > bTime)
        return 1;
    if(aTime < bTime)
        return -1;

    //Whatever
    return 0;
}

function orderBy(objects, byPlace){
    objects = objects.sort(function(a,b){
        //Late night events are on the wrong date in the fahrplan sheet
        var aStart = parseInt(a.start[0]+a.start[1]);
        var bStart = parseInt(b.start[0]+b.start[1]);
        if(aStart < 7){
            aStart += 30;
        }
        if(bStart < 7){
            bStart += 30;
        }

        aStart = aStart*60 + parseInt(a.start[3]+a.start[4]);
        bStart = bStart*60 + parseInt(b.start[3]+b.start[4]);

        if(byPlace)
            return comparePlace(aStart, a.room, bStart, b.room);
        return compareTime(aStart, a.room, bStart, b.room);
    });
    return objects;
}


function presenters2string(persons){
    var ret = "";
    if(persons.length > 0){
        for(var p = 0; p < persons.length; p++){
            ret += persons[p].public_name;
            if (p != persons.length-1){
                ret += ", ";
            }
        }
    }
    else {
        ret += "Unknown";
    }

    return ret;
}
