#ifndef SCHEDULE_H
#define SCHEDULE_H

#include <QObject>
#include <QNetworkReply>
#include <QNetworkAccessManager>

class Schedule : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString schedule
               READ schedule
               NOTIFY scheduleChanged)
    Q_PROPERTY(bool updating READ updating NOTIFY updatingChanged)
    bool loadFromDisk();
    void write(const QString& data);

public:
    explicit Schedule(QObject *parent = 0);
    QString schedule() { return mSchedule; }
    bool updating(){return mUpdating; }

    Q_INVOKABLE void loadFromNetwork();

private slots:
    void RequestFinished(QNetworkReply* reply);

signals:
    void loadFromDiskFailed();
    void loadFromNetworkFailed();
    void scheduleChanged(const QString& source);
    void updatingChanged(bool updating);
private:
    QString mSchedule;
    QString mFilename;
    QString mDirname;
    QNetworkAccessManager* nam;
    bool mUpdating;
};

#endif // SCHEDULE_H
