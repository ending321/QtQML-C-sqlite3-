#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<QQmlContext>   //用于注册C++对象到QML
#include"udpclient.h"   //UDP客户端的头文件
#include"userdatabase.h"    //数据库的头文件
#include <QQmlEngine>  // 新增头文件

int main(int argc, char *argv[])
{
    //设置虚拟键盘
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);

    //创建UDP客户端实例
    udpClient *udpclient = new udpClient();
    UserDatabase *userDb = new UserDatabase();
    //初始化 QML 引擎
    QQmlApplicationEngine engine;
    // 将 udpClient 实例注册到 QML 上下文，使其在 QML 中可用
    engine.rootContext()->setContextProperty("udpclient", udpclient);
    engine.rootContext()->setContextProperty("userDb", userDb);
    // 新增：注册 UserDatabase 为 QML 类型（第一个参数为导入模块名，第二个为版本号，第三个为QML类型名）
    qmlRegisterType<UserDatabase>("com.example.UserDatabase", 1, 0, "UserDatabase");

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
