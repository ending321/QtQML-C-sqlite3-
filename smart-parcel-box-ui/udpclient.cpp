#include "udpclient.h"

udpClient::udpClient(QObject *parent) : QObject(parent)
{
    socket = new QUdpSocket(this);
    if (socket->bind(QHostAddress::Any, 12345)) {
        qDebug() << "UDP socket bound to port 12345";
    } else {
        qDebug() << "Failed to bind UDP socket";
    }

    connect(socket, SIGNAL(readyRead()), this, SLOT(readPendingDatagrams()));
}

void udpClient::sendMessage(const QString &msg)
{
    QByteArray datagram = msg.toUtf8();
    socket->writeDatagram(datagram, QHostAddress("127.0.0.1"), 12345);
    qDebug() << "Sent message:" << msg;
}

void udpClient::readPendingDatagrams()
{
    while (socket->hasPendingDatagrams()) {
        QByteArray datagram;
        datagram.resize(socket->pendingDatagramSize());
        QHostAddress sender;
        quint16 senderPort;

        socket->readDatagram(datagram.data(), datagram.size(), &sender, &senderPort);
        emit messageReceived(QString::fromUtf8(datagram));
    }
}
    