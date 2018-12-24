#ifndef CONFERENCE_H
#define CONFERENCE_H

#include <QObject>
#include "conferenceday.h"

class Conference : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString title MEMBER title NOTIFY titleChanged)
    Q_PROPERTY(QDate start MEMBER start NOTIFY startChanged)
    Q_PROPERTY(QDate end MEMBER end NOTIFY endChanged)
    Q_PROPERTY(QList<QObject*> days MEMBER days NOTIFY daysChanged)

    QString title;
    QDate start;
    QDate end;
    QList<QObject*> days;
public:
    explicit Conference(QObject *parent = nullptr);
    void setTitle(const QString& title);
    void setRange(const QDate& start, const QDate& end);
    void addDay(ConferenceDay *day);

    static Conference* fromJson(const QJsonObject& json);

signals:
    void titleChanged(const QString& title);
    void startChanged(const QDate& date);
    void endChanged(const QDate& date);
    void daysChanged(const QList<QObject*>& days);

};

#endif // CONFERENCE_H
