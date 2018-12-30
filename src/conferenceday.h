#ifndef CONFERENCEDAY_H
#define CONFERENCEDAY_H

#include <QObject>
#include <QDate>
#include "conferenceevent.h"
#include "conferenceeventsortingorder.h"

class ConferenceDay : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QDate date MEMBER date NOTIFY dateChanged)
    Q_PROPERTY(QList<QObject*> events MEMBER events NOTIFY eventsChanged)
    Q_PROPERTY(QStringList rooms MEMBER rooms NOTIFY roomsChanged)
    Q_PROPERTY(ConferenceEventSortingOrder::SortingOrder sortingOrder READ getSortingOrder WRITE setSortingOrder NOTIFY sortingOrderChanged)
public:
    ConferenceEventSortingOrder::SortingOrder sortingOrder;
    QDate date;
    QList<QObject*> events;
    QStringList rooms;

    explicit ConferenceDay(QObject *parent = nullptr);
    void setDate(const QDate& date);
    void addEvent(ConferenceEvent* event);
    void addRoom(const QString& room);
    ConferenceEventSortingOrder::SortingOrder getSortingOrder() const;
    void setSortingOrder(const ConferenceEventSortingOrder::SortingOrder &sortingOrder);

    static ConferenceDay* fromJson(const QJsonObject& json);

    Q_INVOKABLE void sort();

signals:
    void dateChanged(const QDate& date);
    void eventsChanged(const QList<QObject*>& events);
    void roomsChanged(const QStringList& rooms);
    void sortingOrderChanged(const ConferenceEventSortingOrder::SortingOrder& sortingOrder);
};

#endif // CONFERENCEDAY_H
