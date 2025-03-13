#ifndef GPIOHANDLER_H
#define GPIOHANDLER_H

#include <QObject>
#include <QQmlEngine>
#include <wiringPi.h>

class GPIOhandler : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit GPIOhandler(QObject *parent = nullptr);
    ~GPIOhandler();

signals:
    void buttonTop();
    void buttonBottom();
    void buttonLeft();
    void buttonRight();

private:
    static GPIOhandler* InterruptPtr;
    static void pushButtonRight();
    static void pushButtonLeft();
    static void pushButtonTop();
    static void pushButtonBottom();
};

#endif // GPIOHANDLER_H
