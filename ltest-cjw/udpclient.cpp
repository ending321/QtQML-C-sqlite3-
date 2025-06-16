#include "udpclient.h"

UdpClient::UdpClient(QObject *parent)
    :QObject{parent}
{
    udpSocket = new QUdpSocket(this);

}

void UdpClient::sendMessage(const QString &message, const QString &host, quint16 port)
{

}

void UdpClient::bindSocket(quint16 port)
{

}
