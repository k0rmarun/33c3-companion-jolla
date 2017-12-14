#ifndef LOADER_H
#define LOADER_H

#include <QObject>
#include <QNetworkReply>
#include <QNetworkAccessManager>

class Loader: public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool loading READ loading NOTIFY loadingChanged)
    Q_PROPERTY(QString schedule READ schedule NOTIFY scheduleChanged)

    bool loadFromDisk();
    bool loadURLFromDisk();
    void write(const QString& filename, const QString& data);
    QString read(const QString& filename);

    QString mBaseDir;
    QString mFilename;
    QString mCacheFilename;
    QString mURLFilename;
    QString mURL;
    QNetworkAccessManager* nam;
    bool mLoading;

    QString mSchedule;

public:
    explicit Loader(QObject *parent = 0);
    QString schedule() { return mSchedule; }
    bool loading(){return mLoading; }

    Q_INVOKABLE void loadFromNetwork();
    Q_INVOKABLE void setCurrent(const QString& cacheTitle, const QString &url, int iteration);

private slots:
    void RequestFinished(QNetworkReply* reply);

signals:
    void loadFromDiskFailed();
    void loadFromNetworkFailed();
    void scheduleChanged(const QString& source);
    void loadingChanged(bool updating);
};

#endif // LOADER_H
