#ifndef CANMANAGER_H
#define CANMANAGER_H

#include <QObject>
#include <QVariant>
#include <QDebug>
#include <QTimer>

#include <QCanBus>
#include <QCanBusDevice>
#include <QCanBusFrame>

#include <QtQml>

//#include "delay.h"

class CANmanager : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    CANmanager();
    CANmanager(uint);
    void processFrames();
    int* getFrame();
    int getByte(int);
    void updatePayload(int, int);
    void sendMessage();
    bool sendOnce();
    void sendLoop();

    QCanBusDevice::CanBusStatus getDeviceStatus();

    enum arrObjects
    {
        FRONTBIAS = 0,
        TCSWITCH = 1,
        LAUNCH = 2
    };

signals:
    void signalUI();
    void signalLoop();

private:
    QTimer timer;
    QCanBusDevice *can_device;
    QCanBusFrame frame;
    int frameBuffer[8];
    int sendBuffer[3];
};

#endif // CANMANAGER_H
