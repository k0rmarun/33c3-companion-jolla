#include "conferenceeventcompare.h"
#include "conferenceevent.h"

bool ConferenceEventPointerCompare::operator()(const QObject *a, const QObject *b) {
    const ConferenceEvent* aa = dynamic_cast<const ConferenceEvent*>(a);
    const ConferenceEvent* bb = dynamic_cast<const ConferenceEvent*>(b);

    if(aa == nullptr || bb == nullptr)
        return false;

    switch (sortingOrder) {
    case ConferenceEventSortingOrder::SortingOrder::BY_TIME:
        return aa->compareByTime(*bb);
    case ConferenceEventSortingOrder::SortingOrder::BY_TITLE:
        return aa->compareByTitle(*bb);
    case ConferenceEventSortingOrder::SortingOrder::BY_TRACK:
        return aa->compareByTrack(*bb);
    case ConferenceEventSortingOrder::SortingOrder::BY_ROOM:
        return aa->compareByRoom(*bb);
    default:
        return false;
    }
}
