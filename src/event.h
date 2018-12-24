#ifndef EVENT_H
#define EVENT_H

#include <QObject>

class Event : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString name MEMBER mName CONSTANT)
    Q_PROPERTY(QString url READ currentURL CONSTANT)

    QString mName;
    int mBaseNumber;
    QString mBaseURL;

  public:
    Event(const QString& name, int baseNumber, const QString& baseURL);

    Q_INVOKABLE QString currentURL() const;
    Q_INVOKABLE QString name() const;
};

QList<QObject*> generateEventList();

#endif // EVENT_H
