TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    NonogramModel.cpp \
    RecentNonogramsModel.cpp \
    RecentNonogramData.cpp \
    NonogramEditor.cpp

RESOURCES += res.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
#include(deployment.pri)

HEADERS += NonogramModel.h \
    RecentNonogramsModel.h \
    RecentNonogramData.h \
    NonogramEditor.h

OTHER_FILES += $$files(qml/*) \
    qml/CustomMenuBar.qml \
    qml/Launcher.qml \
    qml/NonogramCreatorMaster.qml \
    qml/CustomMessageBox.qml \
    qml/CustomButton.qml \
    qml/CustomTextField.qml \
    qml/NonogramView.qml
