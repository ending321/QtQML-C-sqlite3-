#include "userdatabase.h"

UserDatabase::UserDatabase(QObject *parent) : QObject(parent)
{
    initDatabase();
}

UserDatabase::~UserDatabase()
{
    if (db.isOpen())
        db.close();
}

void UserDatabase::initDatabase()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("parcel_management.db");

    if (!db.open()) {
        qDebug() << "Error opening database:" << db.lastError().text();
        return;
    }

    // 创建用户表
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS users ("
               "id INTEGER PRIMARY KEY AUTOINCREMENT,"
               "username TEXT UNIQUE,"
               "password TEXT"
               ")");

    // 创建包裹表
    query.exec("CREATE TABLE IF NOT EXISTS packages ("
               "id INTEGER PRIMARY KEY AUTOINCREMENT,"
               "tracking_number TEXT UNIQUE,"
               "recipient TEXT,"
               "locker_id TEXT,"
               "code TEXT,"
               "status TEXT,"
               "created_at DATETIME DEFAULT CURRENT_TIMESTAMP"
               ")");
}

bool UserDatabase::createUser(const QString &username, const QString &password)
{
    QSqlQuery query;
    query.prepare("INSERT INTO users (username, password) VALUES (:username, :password)");
    query.bindValue(":username", username);
    query.bindValue(":password", password);

    return query.exec();
}

bool UserDatabase::validateUser(const QString &username, const QString &password)
{
    QSqlQuery query;
    query.prepare("SELECT * FROM users WHERE username = :username AND password = :password");
    query.bindValue(":username", username);
    query.bindValue(":password", password);

    if (query.exec() && query.next())
        return true;

    return false;
}

bool UserDatabase::createPackage(const QString &trackingNumber, const QString &recipient, const QString &lockerId)
{
    // 生成随机取件码
    QString code = QString::number(qrand() % 9000 + 1000);
    
    QSqlQuery query;
    query.prepare("INSERT INTO packages (tracking_number, recipient, locker_id, code, status) "
                  "VALUES (:tracking_number, :recipient, :locker_id, :code, 'pending')");
    query.bindValue(":tracking_number", trackingNumber);
    query.bindValue(":recipient", recipient);
    query.bindValue(":locker_id", lockerId);
    query.bindValue(":code", code);

    return query.exec();
}

bool UserDatabase::retrievePackage(const QString &trackingNumber, const QString &code)
{
    QSqlQuery query;
    query.prepare("SELECT * FROM packages WHERE tracking_number = :tracking_number AND code = :code AND status = 'pending'");
    query.bindValue(":tracking_number", trackingNumber);
    query.bindValue(":code", code);

    if (query.exec() && query.next()) {
        // 更新包裹状态为已取件
        QSqlQuery updateQuery;
        updateQuery.prepare("UPDATE packages SET status = 'collected' WHERE tracking_number = :tracking_number");
        updateQuery.bindValue(":tracking_number", trackingNumber);
        return updateQuery.exec();
    }

    return false;
}

QString UserDatabase::getPackageCode(const QString &trackingNumber)
{
    QSqlQuery query;
    query.prepare("SELECT code FROM packages WHERE tracking_number = :tracking_number AND status = 'pending'");
    query.bindValue(":tracking_number", trackingNumber);

    if (query.exec() && query.next())
        return query.value(0).toString();

    return "";
}
    