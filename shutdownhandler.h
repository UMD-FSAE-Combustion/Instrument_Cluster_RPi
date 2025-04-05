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
        if(QSysInfo::prettyProductName() != "Debian GNU/Linux 12 (Bookworm)")
            qDebug() << "VM detected, skipping shutdown";
        else if (QSysInfo::prettyProductName() == "Debian GNU/Linux 12 (Bookworm)")
        {
            QProcess proc;
            proc.startDetached("/usr/bin/sudo", QStringList() << "shutdown" << "-h" << "now");
        }
    }
};

#endif // SHUTDOWNHANDLER_H
