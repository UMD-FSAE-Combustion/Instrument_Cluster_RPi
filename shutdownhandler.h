#ifndef SHUTDOWNHANDLER_H
#define SHUTDOWNHANDLER_H

#include <QDebug>
#include <QProcess>

//temporary, until GPIO handler is done
#include <QtQml>

class ShutdownHandler : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    //Q_INVOKABLE IS TEMPORARY, WILL DELETE LATER
    Q_INVOKABLE static void powerOFF() {
        qDebug() << QSysInfo::productType();
        if(QSysInfo::productType() == "pop")
            qDebug() << "VM detected, skipping shutdown";
        else
        {
            QProcess proc;
            proc.startCommand("sudo shutdown -h now");
        }
    };
};

#endif // SHUTDOWNHANDLER_H
