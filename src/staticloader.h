#ifndef STATICLOADER_H
#define STATICLOADER_H

#include <QObject>
#include "loader.h"

class StaticLoader : public QObject
{
    Q_OBJECT
    static Loader* loader;
public:
    explicit StaticLoader(QObject *parent = nullptr);

    Q_INVOKABLE Loader* getLoader() const;

signals:

public slots:
};

#endif // STATICLOADER_H
