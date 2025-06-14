#ifndef UDPCLIENT_H
#define UDPCLIENT_H

#include<QObject>
#include<QDebug>

class udpClient:public QObject
{
    Q_OBJECT
public:
    explicit udpClient(QObject *parent = nullptr);
    Q_INVOKABLE void sendMessage(const QString &msg);
};

#endif // UDPCLIENT_H
