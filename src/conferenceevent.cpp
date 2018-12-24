#include "conferenceevent.h"
#include <QDateTime>
#include <QTime>
#include <extendedcalendar.h>
#include <extendedstorage.h>
#include <kdatetime.h>
#include <ksystemtimezone.h>
#include <QTextStream>
#include <QtDebug>

struct CalendarInfo
{
    QString name;
    QString notebookUID;

    CalendarInfo(const QString &name, const QString &notebookUID = QString())
        : name(name), notebookUID(notebookUID) {}
};

ConferenceEvent::ConferenceEvent(QObject *parent) : QObject(parent)
{

}

void ConferenceEvent::setStartEnd(const QString &date, const QString &start, const QString &duration)
{
    QDateTime _date = QDateTime::fromString(date, Qt::ISODate);
    QTime _deltaStart = QTime::fromString(start, "hh:mm");
    QTime _deltaDuration = QTime::fromString(duration, "hh:mm");
    QTime _deltaEnd = _deltaStart.addMSecs(_deltaDuration.msecsSinceStartOfDay());
    this->start = QDateTime(_date.date(), _deltaStart);
    this->end = QDateTime(_date.date(), _deltaEnd);
    emit startChanged(this->start);
    emit endChanged(this->end);
}

void ConferenceEvent::setRoom(const QString &room)
{
    this->room = room;
    emit roomChanged(this->room);
}

void ConferenceEvent::setTitle(const QString &title)
{
    this->title = title;
    emit titleChanged(this->title);
}

void ConferenceEvent::setSubTitle(const QString &title)
{
    this->subtitle = title;
    emit subtitleChanged(this->subtitle);
}

void ConferenceEvent::setTrack(const QString &track)
{
    this->track = track;
    emit trackChanged(this->track);
}

void ConferenceEvent::setType(const QString &type)
{
    this->type = type;
    emit typeChanged(this->type);
}

void ConferenceEvent::setLanguage(const QString &language)
{
    this->language = language;
    emit languageChanged(this->language);
}

void ConferenceEvent::setAbstract(const QString &abstract)
{
    this->abstract = abstract;
    emit abstractChanged(this->abstract);
}

void ConferenceEvent::setDescription(const QString &description)
{
    this->description = description;
    emit descriptionChanged(this->description);
}

void ConferenceEvent::setRecord(bool record)
{
    this->record = record;
    emit recordChanged(this->record);
}

void ConferenceEvent::addPerson(const QString &person)
{
    this->persons.append(person);
    emit personsChanged(this->persons);
}

void ConferenceEvent::addLink(const QString &link)
{
    this->links.append(link);
    emit linksChanged(this->links);
}

bool ConferenceEvent::operator <(const ConferenceEvent& b) const
{
    if(start == b.start){
        if(end == b.end){
            return room < b.room;
        }
        return end < b.end;
    }
    return start < b.start;
}

ConferenceEvent* ConferenceEvent::fromJson(const QJsonObject &json)
{
    ConferenceEvent* event = new ConferenceEvent;
    event->setStartEnd(
        json["date"].toString(""),
        json["start"].toString(""),
        json["duration"].toString("")
    );
    event->setRoom(json["room"].toString("Unknown"));
    event->setTitle(json["title"].toString("Unknown"));
    event->setSubTitle(json["title"].toString("Unknown"));
    event->setTrack(json["track"].toString("Unknown"));
    event->setType(json["type"].toString("Unknown"));
    event->setLanguage(json["language"].toString("Unknown"));
    event->setAbstract(json["abstract"].toString("Unknown"));
    event->setDescription(json["description"].toString("Unknown"));
    event->setRecord(!json["record"].toBool(false));
    for(const auto& person: json["persons"].toArray()){
        event->addPerson(person.toObject()["public_name"].toString("Unknown"));
    }
    for(const auto& link: json["links"].toArray()){
        event->addLink(link.toString("Unknown"));
    }
    return event;
}

void ConferenceEvent::addToCalendar() const
{
    mKCal::ExtendedCalendar::Ptr calendar = mKCal::ExtendedCalendar::Ptr ( new mKCal::ExtendedCalendar( QLatin1String( "UTC" ) ) );
    mKCal::ExtendedStorage::Ptr storage = mKCal::ExtendedCalendar::defaultStorage( calendar );
    if (storage->open()) {
        mKCal::Notebook::Ptr notebook = storage->defaultNotebook();
        if (notebook) {
            KCalCore::Event::Ptr event = KCalCore::Event::Ptr( new KCalCore::Event() );
            event->setSummary(title);

            QString descString;
            QTextStream desc(&descString);
            desc << subtitle << endl;
            desc << "Room: " << room << endl;
            desc << "Track: " << track << endl;
            desc << "Type: " << type << endl;
            desc << "Language: " << language << endl;
            desc << endl << abstract << endl;
            desc << endl << description << endl;

            event->setDescription(descString);
            event->setDtStart( KDateTime(start) );
            event->setDtEnd( KDateTime(end) );
            calendar->addEvent( event, notebook->uid() );
            storage->save();
            qDebug() << "SAVED EVENT" << descString;
        } else {
            qDebug() << "FAILED TO SAVE event" << title;
        }
    } else {
        qDebug() << "FAILED TO ACCESS CALENDER" << calendar << storage;
    }
}

bool ConferenceEventPointerCompare::operator()(const QObject *a, const QObject *b) {
    const ConferenceEvent* aa = dynamic_cast<const ConferenceEvent*>(a);
    const ConferenceEvent* bb = dynamic_cast<const ConferenceEvent*>(b);

    if(aa == nullptr || bb == nullptr)
        return false;
    return *aa < *bb;
}
