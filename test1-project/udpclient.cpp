#include "udpclient.h"

udpClient::udpClient(QObject *parent):QObject(parent){}

void udpClient::sendMessage(const QString &msg){
    qDebug()<<"send message to UDP"<<msg;
}
