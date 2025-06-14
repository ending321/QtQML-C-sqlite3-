#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "udpclient.h"
#include "userdatabase.h"

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);

    udpClient *udpclient = new udpClient();
    UserDatabase *userDb = new UserDatabase();
    
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("udpclient", udpclient);
    engine.rootContext()->setContextProperty("userDb", userDb);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
    