#ifndef LOADER_H
#define LOADER_H

#include <QObject>
#include <QNetworkReply>
#include <QNetworkAccessManager>

#include "conference.h"

class Loader: public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool loading READ loading NOTIFY loadingChanged)
    Q_PROPERTY(Conference* conference READ conference NOTIFY conferenceChanged)

    bool loadFromDisk();
    bool loadURLFromDisk();
    void write(const QString& filename, const QByteArray &data);
    QByteArray read(const QString& filename);
    void loadJSON(const QByteArray &data);

    QString mBaseDir;
    QString mCacheFilename;
    QString mURLFilename;
    QString mURL;

    QNetworkAccessManager* nam;
    bool mLoading;

    Conference* mConference;

public:
    explicit Loader(QObject *parent = 0);
    Conference* conference() { return mConference; }
    bool loading(){return mLoading; }

    Q_INVOKABLE void loadFromNetwork();
    Q_INVOKABLE void setCurrent(const QString& cacheTitle, const QString &url, int iteration);
    Q_INVOKABLE void setCurrent(const QString& cacheTitle, const QString &url);

private slots:
    void RequestFinished(QNetworkReply* reply);

signals:
    void loadFromDiskFailed();
    void loadFromNetworkFailed();
    void conferenceChanged(Conference* conference);
    void loadingChanged(bool updating);
};

#endif // LOADER_H
