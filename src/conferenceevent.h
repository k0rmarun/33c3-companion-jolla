#ifndef CONFERENCEEVENT_H
#define CONFERENCEEVENT_H

#include <QObject>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonValue>
#include <QDateTime>

class ConferenceEvent : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QDateTime start MEMBER start NOTIFY startChanged)
    Q_PROPERTY(QDateTime end MEMBER end NOTIFY endChanged)
    Q_PROPERTY(QString room MEMBER room NOTIFY roomChanged)
    Q_PROPERTY(QString title MEMBER title NOTIFY titleChanged)
    Q_PROPERTY(QString subtitle MEMBER subtitle NOTIFY subtitleChanged)
    Q_PROPERTY(QString track MEMBER track NOTIFY trackChanged)
    Q_PROPERTY(QString type MEMBER type NOTIFY typeChanged)
    Q_PROPERTY(QString language MEMBER language NOTIFY languageChanged)
    Q_PROPERTY(QString abstract MEMBER abstract NOTIFY abstractChanged)
    Q_PROPERTY(QString description MEMBER description NOTIFY descriptionChanged)
    Q_PROPERTY(bool record MEMBER record NOTIFY recordChanged)
    Q_PROPERTY(QStringList persons MEMBER persons NOTIFY personsChanged)
    Q_PROPERTY(QStringList links MEMBER links NOTIFY linksChanged)

    QDateTime start, end;
    QString room, title, subtitle, track, type, language, abstract, description;
    bool record;
    QStringList persons, links;
    bool _compareByTime(const ConferenceEvent& b) const;
    bool _compareByTitle(const ConferenceEvent& b) const;
    bool _compareByTrack(const ConferenceEvent& b) const;
    bool _compareByRoom(const ConferenceEvent& b) const;

public:
    explicit ConferenceEvent(QObject *parent = nullptr);
    void setStartEnd(const QString& date, const QString& start, const QString& duration);
    void setRoom(const QString& room);
    void setTitle(const QString& title);
    void setSubTitle(const QString& title);
    void setTrack(const QString& track);
    void setType(const QString& type);
    void setLanguage(const QString& language);
    void setAbstract(const QString& abstract);
    void setDescription(const QString& description);
    void setRecord(bool record);
    void addPerson(const QString& person);
    void addLink(const QString& link);
    bool compareByTime(const ConferenceEvent& b) const;
    bool compareByTitle(const ConferenceEvent& b) const;
    bool compareByTrack(const ConferenceEvent& b) const;
    bool compareByRoom(const ConferenceEvent& b) const;

    static ConferenceEvent* fromJson(const QJsonObject& json);

    Q_INVOKABLE void addToCalendar() const;
signals:
    void startChanged(const QDateTime& start);
    void endChanged(const QDateTime& end);
    void roomChanged(const QString& room);
    void titleChanged(const QString& title);
    void subtitleChanged(const QString& title);
    void trackChanged(const QString& track);
    void typeChanged(const QString& type);
    void languageChanged(const QString& language);
    void abstractChanged(const QString& abstract);
    void descriptionChanged(const QString& description);
    void recordChanged(bool record);
    void personsChanged(const QStringList& persons);
    void linksChanged(const QStringList& links);
};



#endif // CONFERENCEEVENT_H
