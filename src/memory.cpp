#include "memory.h"

Memory::Memory(QObject *parent) : QObject(parent)
{

}

void Memory::set(QString key, QVariant value){
    data[key] = value;
}

QVariant Memory::get(QString key){
    return data[key];
}
