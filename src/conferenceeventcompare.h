#ifndef CONFERENCEEVENTCOMPARE_H
#define CONFERENCEEVENTCOMPARE_H

#include "conferenceeventsortingorder.h"

struct ConferenceEventPointerCompare {
    ConferenceEventSortingOrder::SortingOrder sortingOrder;
    bool operator()(const QObject* a, const QObject* b);
};

#endif // CONFERENCEEVENTCOMPARE_H
