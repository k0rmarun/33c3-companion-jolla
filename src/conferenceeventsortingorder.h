#ifndef CONFERENCEEVENTSORTINGORDER_H
#define CONFERENCEEVENTSORTINGORDER_H

#include <QObject>

class ConferenceEventSortingOrder: public QObject {
    Q_OBJECT
public:
    enum SortingOrder {
        BY_TIME,
        BY_TITLE,
        BY_TRACK,
        BY_ROOM
    };

    Q_ENUM(SortingOrder)
};

#endif // CONFERENCEEVENTSORTINGORDER_H
