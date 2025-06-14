#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<QQmlContext>   //用于注册C++对象到QML
#include"udpclient.h"   //UDP客户端的头文件

int main(int argc, char *argv[])
{
    //设置虚拟键盘
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);

    //创建UDP客户端实例
    udpClient *udpclient = new udpClient();
    //初始化 QML 引擎
    QQmlApplicationEngine engine;
    // 将 udpClient 实例注册到 QML 上下文，使其在 QML 中可用
    engine.rootContext()->setContextProperty("udpclient", udpclient);
    const QUrl url(QStringLiteral("qrc:/test1-project/main.qml"));
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
