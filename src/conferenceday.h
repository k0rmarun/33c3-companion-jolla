#ifndef CONFERENCEDAY_H
#define CONFERENCEDAY_H

#include <QObject>
#include <QDate>
#include "conferenceevent.h"

class ConferenceDay : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QDate date MEMBER date NOTIFY dateChanged)
    Q_PROPERTY(QList<QObject*> events MEMBER events NOTIFY eventsChanged)
    Q_PROPERTY(QStringList rooms MEMBER rooms NOTIFY roomsChanged)

    QDate date;
    QList<QObject*> events;
    QStringList rooms;
public:
    explicit ConferenceDay(QObject *parent = nullptr);
    void setDate(const QDate& date);
    void addEvent(ConferenceEvent* event);
    void addRoom(const QString& room);

    static ConferenceDay* fromJson(const QJsonObject& json);

signals:
    void dateChanged(const QDate& date);
    void eventsChanged(const QList<QObject*>& events);
    void roomsChanged(const QStringList& rooms);
};

#endif // CONFERENCEDAY_H
