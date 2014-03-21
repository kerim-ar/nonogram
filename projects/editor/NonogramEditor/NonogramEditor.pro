TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    NonogramModel.cpp

RESOURCES += res.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
#include(deployment.pri)

HEADERS += NonogramModel.h

OTHER_FILES += $$files(qml/*)
