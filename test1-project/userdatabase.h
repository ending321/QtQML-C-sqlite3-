#ifndef USERDATABASE_H
#define USERDATABASE_H

#include <QObject>
#include<QSqlDatabase>
#include<QSqlQuery>
#include<QSqlError>
#include<QDebug>

class UserDatabase:public QObject
{
private:
    Q_OBJECT
public:
    explicit UserDatabase(QObject *parent=nullptr);
    ~UserDatabase();

    Q_INVOKABLE bool createUser(const QString &username, const QString &password);      //创建新用户账户
    Q_INVOKABLE bool validateUser(const QString &username, const QString &password);    //验证用户登录信息
    Q_INVOKABLE bool createPackage(const QString &trackingNumber, const QString &recipient, const QString &lockerId);   //创建新包裹记录
    Q_INVOKABLE bool retrievePackage(const QString &trackingNumber, const QString &code);   //用户取件验证
    Q_INVOKABLE QString getPackageCode(const QString &trackingNumber);  //获取包裹的取件码

private:
    QSqlDatabase db;
    void initDatabase();

};

#endif // USERDATABASE_H
