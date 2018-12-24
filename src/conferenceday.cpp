#include "conferenceday.h"

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
    std::sort(day->events.begin(), day->events.end(), ConferenceEventPointerCompare());
    return day;
}
