#ifndef UDPCLIENT_H
#define UDPCLIENT_H
#include<QObject>
#include<QUdpSocket>

class UdpClient:public QObject
{
    Q_OBJECT
public:
    explicit UdpClient(QObject *parent = nullptr);   //explicit:禁止类构造函数的隐式类型转换

    //Q_INVOKABLE：允许QML中通过对象名直接调用C++
    Q_INVOKABLE void sendMessage(const QString &message, const QString &host, quint16 port);
    Q_INVOKABLE void bindSocket(quint16 port);

private:
    QUdpSocket *udpSocket;
};

#endif // UDPCLIENT_H
