#include "loader.h"
#include <QFile>
#include <QDir>
#include <QStandardPaths>

Loader::Loader(QObject *parent) : QObject(parent)
{
    mBaseDir = QStandardPaths::writableLocation(QStandardPaths::DataLocation);
    mFilename = mBaseDir+"/cache.json";
    mURLFilename = mBaseDir+"/url";
    mCacheFilename = mFilename;
    qDebug() << "filename" << mFilename;

    nam = new QNetworkAccessManager(this);
    mLoading = false;
    emit loadingChanged(mLoading);
    setCurrent("cache.json", "", 0);
}

bool Loader::loadFromDisk(){
    mSchedule = read(mFilename);
    if(!mSchedule.isEmpty()){
        emit scheduleChanged(mSchedule);
        qDebug() << "LOAD FROM DISK SUCCEEDED";
        return true;
    } else {
        qDebug() << "LOAD FROM DISK FAILED";
        return false;
    }
}

void Loader::loadFromNetwork(){
    mLoading = true;
    emit loadingChanged(mLoading);

    connect(nam, &QNetworkAccessManager::finished,
           this, &Loader::RequestFinished);
    nam->get(QNetworkRequest(mURL));
}

void Loader::setCurrent(const QString& cacheTitle, const QString &url, int iteration) {
    mFilename = mBaseDir + "/" + cacheTitle.arg(iteration);
    if(url.isEmpty()){
        mURL = read(mURLFilename);
    }else {
        mURL = url.arg(iteration);
    }
    if(!loadFromDisk()){
        loadFromNetwork();
        return;
    }
}

void Loader::RequestFinished(QNetworkReply *reply){
    if(reply->error() == QNetworkReply::NoError){
        QString tmp = QString(reply->readAll());
        if(mSchedule != tmp && !tmp.isEmpty()){
            mSchedule = tmp;
            emit scheduleChanged(mSchedule);
            write(mFilename, mSchedule);
            write(mCacheFilename, mSchedule);
            write(mURLFilename, mURL);
            qDebug() << "LOAD FROM NETWORK SUCCEEDED";
        } else {
            qDebug() << "NOTHING CHANGED";
        }
    } else {
        emit loadFromNetworkFailed();
        qDebug() << "LOAD FROM NETWORK FAILED";
    }

    mLoading = false;
    emit loadingChanged(mLoading);
}

void Loader::write(const QString& filename, const QString &data){
    QFile file(filename);
    if(!file.exists()){
        QDir dir = QDir::home();
        dir.mkpath(mBaseDir);
    }
    if(file.open(QIODevice::WriteOnly|QIODevice::Truncate)){
        file.write(data.toUtf8());
        file.close();
    }
}

QString Loader::read(const QString& filename){
    QString ret;
    QFile file(filename);
    if(file.exists()){
        file.open(QIODevice::ReadOnly);
        ret = QString(file.readAll());
        file.close();
    }
    return ret;
}

