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

    Q_PROPERTY(int rearBrakePres READ rearBrakePres WRITE setRearBrakePres NOTIFY rearBrakePresChanged FINAL)
    Q_PROPERTY(int frontBrakePres READ frontBrakePres WRITE setFrontBrakePres NOTIFY frontBrakePresChanged FINAL)
    Q_PROPERTY(int coolantTemp READ coolantTemp WRITE setCoolantTemp NOTIFY coolantTempChanged FINAL)
    Q_PROPERTY(int oilTemp READ oilTemp WRITE setOilTemp NOTIFY oilTempChanged FINAL)
    Q_PROPERTY(int fuelTemp READ fuelTemp WRITE setFuelTemp NOTIFY fuelTempChanged FINAL)

public:
    CANmanager();
    CANmanager(uint);
    void processFrames();
    int* getFrame();
    int getByte(int);

    Q_INVOKABLE void updatePayload(int, int);

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

    int rearBrakePres() const;
    void setRearBrakePres(int newRearBrakePres);

    int frontBrakePres() const;
    void setFrontBrakePres(int newFrontBrakePres);

    int coolantTemp() const;
    void setCoolantTemp(int newCoolantTemp);

    int oilTemp() const;
    void setOilTemp(int newOilTemp);

    int fuelTemp() const;
    void setFuelTemp(int newFuelTemp);

signals:
    void signalUI();
    void signalLoop();

    void rearBrakePresChanged();

    void frontBrakePresChanged();

    void coolantTempChanged();

    void oilTempChanged();

    void fuelTempChanged();

private:
    QTimer timer;
    QCanBusDevice *can_device;
    QCanBusFrame frame;

    bool initialTransmission;
    int frameBuffer[8];
    int sendBuffer[3];

    int m_rearBrakePres;
    int m_frontBrakePres;
    int m_coolantTemp;
    int m_oilTemp;
    int m_fuelTemp;
};

#endif // CANMANAGER_H
