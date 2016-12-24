#ifndef MEMORY_H
#define MEMORY_H

#include <QObject>
#include <QVariantMap>
#include <QString>
#include <QVariant>

class Memory : public QObject
{
    Q_OBJECT
    QVariantMap data;
public:
    explicit Memory(QObject *parent = 0);

    Q_INVOKABLE void set(QString key, QVariant value);
    Q_INVOKABLE QVariant get(QString key);

signals:

public slots:
};

#endif // MEMORY_H
