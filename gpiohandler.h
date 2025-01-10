#ifndef GPIOHANDLER_H
#define GPIOHANDLER_H

#include <QObject>
#include <QQmlEngine>

class GPIOhandler : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit GPIOhandler(QObject *parent = nullptr);

signals:
};

#endif // GPIOHANDLER_H
