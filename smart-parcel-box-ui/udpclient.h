#ifndef UDPCLIENT_H
#define UDPCLIENT_H

#include <QObject>
#include <QUdpSocket>
#include <QDebug>

class udpClient : public QObject
{
    Q_OBJECT
public:
    explicit udpClient(QObject *parent = nullptr);
    Q_INVOKABLE void sendMessage(const QString &msg);

signals:
    void messageReceived(const QString &msg);

private slots:
    void readPendingDatagrams();

private:
    QUdpSocket *socket;
};

#endif // UDPCLIENT_H
    