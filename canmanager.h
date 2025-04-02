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
#include <QVector>

#include <cmath>

class CANmanager : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(int vehicleSpeed READ vehicleSpeed WRITE setVehicleSpeed NOTIFY vehicleSpeedChanged FINAL)
    Q_PROPERTY(int rearBrakePres READ rearBrakePres WRITE setRearBrakePres NOTIFY rearBrakePresChanged FINAL)
    Q_PROPERTY(int frontBrakePres READ frontBrakePres WRITE setFrontBrakePres NOTIFY frontBrakePresChanged FINAL)
    Q_PROPERTY(QString coolantTemp READ coolantTemp WRITE setCoolantTemp NOTIFY coolantTempChanged FINAL)
    Q_PROPERTY(QString oilTemp READ oilTemp WRITE setOilTemp NOTIFY oilTempChanged FINAL)
    Q_PROPERTY(QString fuelTemp READ fuelTemp WRITE setFuelTemp NOTIFY fuelTempChanged FINAL)
    Q_PROPERTY(bool ecuFault READ ecuFault WRITE setEcuFault NOTIFY ecuFaultChanged FINAL)
    Q_PROPERTY(QString faultMessage READ faultMessage WRITE setFaultMessage NOTIFY faultMessageChanged FINAL)
    Q_PROPERTY(QString exhaustTemp READ exhaustTemp WRITE setExhaustTemp NOTIFY exhaustTempChanged FINAL)
    Q_PROPERTY(QString inletAirTemp READ inletAirTemp WRITE setInletAirTemp NOTIFY inletAirTempChanged FINAL)
    Q_PROPERTY(int inletManifoldPres READ inletManifoldPres WRITE setInletManifoldPres NOTIFY inletManifoldPresChanged FINAL)
    Q_PROPERTY(int fuelPres READ fuelPres WRITE setFuelPres NOTIFY fuelPresChanged FINAL)
    Q_PROPERTY(int fuelMixAim READ fuelMixAim WRITE setFuelMixAim NOTIFY fuelMixAimChanged FINAL)
    Q_PROPERTY(double exhaustLambda READ exhaustLambda WRITE setExhaustLambda NOTIFY exhaustLambdaChanged FINAL)

public:
    static QVector<int> sendBuffer;

    CANmanager();
    CANmanager(uint);
    ~CANmanager();
    void processFrames();
    int* getFrame();
    int getByte(int);

    Q_INVOKABLE void updatePayload(int, int);

    void sendLoop();

    QCanBusDevice::CanBusStatus getDeviceStatus();

    enum arrObjects
    {
        FRONTBIAS = 0,
        TCSWITCH = 1,
        LAUNCH_AIM = 2,
        ANTI_LAG = 3,
        LAUNCH_CTL = 4,
        IGNITION = 5,
        FUEL_AIM = 6,
        THROTTLE_MAP = 7
    };

    int rearBrakePres() const;
    void setRearBrakePres(int newRearBrakePres);

    int frontBrakePres() const;
    void setFrontBrakePres(int newFrontBrakePres);

    QString coolantTemp() const;
    void setCoolantTemp(QString newCoolantTemp);

    QString oilTemp() const;
    void setOilTemp(QString newOilTemp);

    QString fuelTemp() const;
    void setFuelTemp(QString newFuelTemp);

    int vehicleSpeed() const;
    void setVehicleSpeed(int newVehicleSpeed);

    bool ecuFault() const;
    void setEcuFault(bool newEcuFault);

    QString exhaustTemp() const;
    void setExhaustTemp(const QString &newExhaustTemp);

    QString inletAirTemp() const;
    void setInletAirTemp(const QString &newInletAirTemp);

    int inletManifoldPres() const;
    void setInletManifoldPres(int newInletManifoldPres);

    int fuelPres() const;
    void setFuelPres(int newFuelPres);

    int fuelMixAim() const;
    void setFuelMixAim(int newFuelMixAim);

    double exhaustLambda() const;
    void setExhaustLambda(double newExhaustLambda);

    QString faultMessage() const;
    void setFaultMessage(const QString &newFaultMessage);

signals:
    void vehicleSpeedChanged();
    void ecuFaultChanged();

    void rearBrakePresChanged();
    void frontBrakePresChanged();
    void coolantTempChanged();
    void oilTempChanged();
    void fuelTempChanged();

    void exhaustTempChanged();
    void inletAirTempChanged();
    void inletManifoldPresChanged();
    void fuelPresChanged();
    void fuelMixAimChanged();
    void exhaustLambdaChanged();

    void faultMessageChanged();

private slots:
    void CAN_Loop();

private:
    void faultFlagCheck(uint8_t);

    QTimer *timer;
    QCanBusDevice *can_device;
    QCanBusFrame frame;

    bool initialTransmission;
    int frameBuffer[8];

    int m_vehicleSpeed;
    bool m_ecuFault;
    QString m_faultMessage;

    int m_rearBrakePres;
    int m_frontBrakePres;
    QString m_coolantTemp;
    QString m_oilTemp;
    QString m_fuelTemp;

    QString m_exhaustTemp;
    QString m_inletAirTemp;
    int m_inletManifoldPres;
    int m_fuelPres;
    int m_fuelMixAim;
    double m_exhaustLambda;
};

#endif // CANMANAGER_H
