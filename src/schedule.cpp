#include "schedule.h"
#include <QFile>
#include <QDir>
#include <QStandardPaths>

Schedule::Schedule(QObject *parent) : QObject(parent)
{
    mDirname = QStandardPaths::writableLocation(QStandardPaths::DataLocation);
    mFilename = mDirname+"/cache.json";
    qDebug() << "filename" << mFilename;
    nam = new QNetworkAccessManager(this);
    mUpdating = false;
    emit updatingChanged(mUpdating);
    if(!loadFromDisk()){
        loadFromNetwork();
    }
}

bool Schedule::loadFromDisk(){
    QFile file(mFilename);
    if(file.open(QIODevice::ReadOnly)){
        mSchedule = QString(file.readAll());
        file.close();
        if(!mSchedule.isEmpty()){
            emit scheduleChanged(mSchedule);
            qDebug() << "LOAD FROM DISK SUCCEEDED";
            return true;
        } else {
            qDebug() << "LOAD FROM DISK FAILED";
            return false;
        }
    } else {
        emit loadFromDiskFailed();
        qDebug() << "LOAD FROM DISK FAILED";
        return false;
    }
}

void Schedule::loadFromNetwork(){
    QUrl url("https://fahrplan.events.ccc.de/congress/2016/Fahrplan/schedule.json");

    mUpdating = true;
    emit updatingChanged(mUpdating);

    connect(nam, &QNetworkAccessManager::finished,
           this, &Schedule::RequestFinished);
    nam->get(QNetworkRequest(url));
}

void Schedule::RequestFinished(QNetworkReply *reply){
    if(reply->error() == QNetworkReply::NoError){
        QString tmp = QString(reply->readAll());
        if(mSchedule != tmp && !tmp.isEmpty()){
            mSchedule = tmp;
            emit scheduleChanged(mSchedule);
            write(mSchedule);
            qDebug() << "LOAD FROM NETWORK SUCCEEDED";
        } else {
            qDebug() << "NOTHING CHANGED";
        }
    } else {
        emit loadFromNetworkFailed();
        qDebug() << "LOAD FROM NETWORK FAILED";
    }

    mUpdating = false;
    emit updatingChanged(mUpdating);
}

void Schedule::write(const QString &data){
    QFile file(mFilename);
    if(!file.exists()){
        QDir dir = QDir::home();
        dir.mkpath(mDirname);
    }
    if(file.open(QIODevice::WriteOnly|QIODevice::Truncate)){
        file.write(data.toUtf8());
        file.close();
    }
}


