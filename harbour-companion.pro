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
TARGET = harbour-companion

QT += qml

CONFIG += sailfishapp
CONFIG += link_pkgconfig

PKGCONFIG += libmkcal-qt5 libkcalcoren-qt5 sailfishapp
INCLUDEPATH += /usr/include/sailfishapp /usr/include/mkcal-qt5 /usr/include/kcalcoren-qt5

SOURCES += src/companion.cpp \
    src/loader.cpp \
    src/event.cpp \
    src/conference.cpp \
    src/conferenceday.cpp \
    src/conferenceevent.cpp \
    src/conferenceeventcompare.cpp

OTHER_FILES += qml/companion.qml \
    qml/cover/CoverPage.qml \
    translations/*.ts

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-companion-de.ts

HEADERS += \
    src/loader.h \
    src/event.h \
    src/conference.h \
    src/conferenceday.h \
    src/conferenceevent.h \
    src/conferenceeventsortingorder.h \
    src/conferenceeventcompare.h

DISTFILES += \
    rpm/harbour-companion.changes \
    rpm/harbour-companion.spec \
    rpm/harbour-companion.yaml \
    harbour-companion.desktop \
    qml/js/Global.js \
    qml/pages/SelectConferenceView.qml \
    qml/pages/ConferenceView.qml \
    qml/pages/ConferenceDayView.qml \
    qml/pages/ConferenceEventView.qml

desktop.files = $${TARGET}.desktop
desktop.path = /usr/share/applications

icon.files = $${TARGET}.png
icon.path = /usr/share/icons/hicolor/86x86/apps
