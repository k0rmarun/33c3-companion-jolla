#include "conference.h"

Conference::Conference(QObject *parent) : QObject(parent)
{

}

void Conference::setTitle(const QString &title)
{
    this->title = title;
}

void Conference::setRange(const QDate &start, const QDate &end)
{
    this->start = start;
    this->end = end;
}

void Conference::addDay(ConferenceDay *day)
{
    this->days.append(day);
}

Conference* Conference::fromJson(const QJsonObject &json)
{
    Conference* conference = new Conference();
    QJsonObject _schedule = json["schedule"].toObject();
    QJsonObject _conference = _schedule["conference"].toObject();

    conference->setTitle(_conference["title"].toString("Unknown"));
    conference->setRange(
        QDate::fromString(_conference["start"].toString(), Qt::ISODate),
        QDate::fromString(_conference["end"].toString(), Qt::ISODate)
    );
    for(const QJsonValue& day: _conference["days"].toArray()){
        conference->addDay(ConferenceDay::fromJson(day.toObject()));
    }
    return conference;
}
