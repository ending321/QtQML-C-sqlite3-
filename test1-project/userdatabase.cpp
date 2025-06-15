#include "userdatabase.h"

UserDatabase::UserDatabase(QObject *parent):QObject(parent) {
    initDatabase();
}

UserDatabase::~UserDatabase()
{

}
void UserDatabase::initDatabase()
{

}

bool UserDatabase::createUser(const QString &username, const QString &password)
{
    return true;
}

bool UserDatabase::validateUser(const QString &username, const QString &password)
{
    return true;
}

bool UserDatabase::createPackage(const QString &trackingNumber, const QString &recipient, const QString &lockerId)
{
    return true;
}

bool UserDatabase::retrievePackage(const QString &trackingNumber, const QString &code)
{
    return true;
}

QString UserDatabase::getPackageCode(const QString &trackingNumber)
{
    return "";
}

