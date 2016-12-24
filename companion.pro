# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = companion

QT += qml

CONFIG += sailfishapp

SOURCES += src/companion.cpp \
    src/schedule.cpp \
    src/memory.cpp

OTHER_FILES += qml/companion.qml \
    qml/cover/CoverPage.qml \
    rpm/companion.spec \
    rpm/companion.yaml \
    translations/*.ts \
    companion.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/companion-de.ts

HEADERS += \
    src/schedule.h \
    src/memory.h

DISTFILES += \
    qml/pages/MainView.qml \
    qml/pages/DateView.qml \
    qml/js/Global.js \
    qml/pages/SubDateView.qml \
    rpm/companion.changes

desktop.files = $${TARGET}.desktop
desktop.path = /usr/share/applications

icon.files = $${TARGET}.png
icon.path = /usr/share/icons/hicolor/86x86/apps
