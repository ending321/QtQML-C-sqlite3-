QT += quick virtualkeyboard core sql network

SOURCES += \
        main.cpp \
        udpclient.cpp \
        userdatabase.cpp

resources.files = main.qml 
resources.prefix = /$${TARGET}
RESOURCES += resources \
    file1.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    udpclient.h \
    userdatabase.h

DISTFILES += \
    LoginPage.qml \
    RegisterPage.qml
