#ifndef USERDATABASE_H
#define USERDATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

class UserDatabase : public QObject
{
    Q_OBJECT
public:
    explicit UserDatabase(QObject *parent = nullptr);
    ~UserDatabase();

    Q_INVOKABLE bool createUser(const QString &username, const QString &password);
    Q_INVOKABLE bool validateUser(const QString &username, const QString &password);
    Q_INVOKABLE bool createPackage(const QString &trackingNumber, const QString &recipient, const QString &lockerId);
    Q_INVOKABLE bool retrievePackage(const QString &trackingNumber, const QString &code);
    Q_INVOKABLE QString getPackageCode(const QString &trackingNumber);

private:
    QSqlDatabase db;
    void initDatabase();
};

#endif // USERDATABASE_H
    