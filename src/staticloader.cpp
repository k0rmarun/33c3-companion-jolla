#include "staticloader.h"

Loader* StaticLoader::loader = nullptr;

StaticLoader::StaticLoader(QObject *parent) : QObject(parent)
{

}

Loader *StaticLoader::getLoader() const
{
    if(loader == nullptr){
        loader = new Loader();
    }
    return loader;
}
