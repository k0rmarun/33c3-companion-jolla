#include "conferenceday.h"
#include "conferenceeventcompare.h"

ConferenceDay::ConferenceDay(QObject *parent) : QObject(parent)
{

}

void ConferenceDay::setDate(const QDate &date)
{
    this->date = date;
    emit dateChanged(this->date);
}

void ConferenceDay::addEvent(ConferenceEvent *event)
{
    this->events.append(event);
    emit eventsChanged(this->events);
}

void ConferenceDay::addRoom(const QString &room)
{
    this->rooms.append(room);
    emit roomsChanged(this->rooms);
}

ConferenceEventSortingOrder::SortingOrder ConferenceDay::getSortingOrder() const
{
    return sortingOrder;
}

void ConferenceDay::setSortingOrder(const ConferenceEventSortingOrder::SortingOrder &sortingOrder)
{
    this->sortingOrder = sortingOrder;
    sort();
}

ConferenceDay *ConferenceDay::fromJson(const QJsonObject &json)
{
    ConferenceDay* day = new ConferenceDay;
    day->setDate(QDate::fromString(json["date"].toString(""), Qt::ISODate));
    QJsonObject rooms = json["rooms"].toObject();
    for(QJsonObject::const_iterator it = rooms.begin();  it != rooms.end(); it++) {
        day->addRoom(it.key());
        const QJsonArray ar = it.value().toArray();
        for(const QJsonValue& event: ar){
            day->addEvent(ConferenceEvent::fromJson(event.toObject()));
        }
    }
    day->setSortingOrder(ConferenceEventSortingOrder::BY_TIME);
    day->sort();
    return day;
}

void ConferenceDay::sort()
{
    ConferenceEventPointerCompare comparator;
    comparator.sortingOrder = sortingOrder;
    std::sort(events.begin(), events.end(), comparator);
    emit eventsChanged(events);
}
