#ifndef JSONMANAGER_H
#define JSONMANAGER_H

#include <QObject>
#include <QCoreApplication>
#include <QtQml>

#include <QFile>
#include <QByteArray>

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonParseError>

#include <vector>

class JSONmanager : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(int driver READ getDriver WRITE setDriver NOTIFY DriverChanged FINAL)
    Q_PROPERTY(int biasVal READ getBiasVal WRITE setBiasVal NOTIFY BiasValChanged FINAL)
    Q_PROPERTY(int tractionSwitch READ getTractionSwitch WRITE setTractionSwitch NOTIFY tractionSwitchChanged FINAL)
    Q_PROPERTY(int launchAim READ launchAim WRITE setLaunchAim NOTIFY launchAimChanged FINAL)
    Q_PROPERTY(int antiLag READ antiLag WRITE setAntiLag NOTIFY antiLagChanged FINAL)
    Q_PROPERTY(bool ignitionTiming READ ignitionTiming WRITE setIgnitionTiming NOTIFY ignitionTimingChanged FINAL)
    Q_PROPERTY(bool throttleMap READ throttleMap WRITE setThrottleMap NOTIFY throttleMapChanged FINAL)
    Q_PROPERTY(bool fuelAim READ fuelAim WRITE setFuelAim NOTIFY fuelAimChanged FINAL)

public:
    JSONmanager();
    ~JSONmanager();

    void loadProfileOnBoot();
    Q_INVOKABLE void loadProfile(int);

    Q_INVOKABLE bool updateBrakeBias(int, int);
    Q_INVOKABLE bool updateTractionCtl(int, int);
    Q_INVOKABLE bool updateAntiLag(int, int);
    Q_INVOKABLE bool updateLaunchAim(int, int);
    Q_INVOKABLE bool updateIgnition(int, int);
    Q_INVOKABLE bool updateFuelAim(int, int);
    Q_INVOKABLE bool updateThrottleMap(int, int);

    bool jsonLoaded() const;

    int getBiasVal() const;
    void setBiasVal(int newBiasVal);

    int getDriver() const;
    void setDriver(int newDriver);

    int getTractionSwitch() const;
    void setTractionSwitch(int newTractionSwitch);

    int antiLag() const;
    void setAntiLag(int newAntiLag);

    int launchAim() const;
    void setLaunchAim(int newLaunchAim);

    bool fuelAim() const;
    void setFuelAim(bool newFuelAim);

    bool ignitionTiming() const;
    void setIgnitionTiming(bool newIgnitionTiming);

    bool throttleMap() const;
    void setThrottleMap(bool newThrottleMap);

signals:
    void BiasValChanged();

    void DriverChanged();

    void tractionSwitchChanged();

    void antiLagChanged();

    void fuelAimChanged();

    void launchAimChanged();

    void ignitionTimingChanged();

    void throttleMapChanged();

private:

    QFile file;

    QJsonDocument jsonDoc;
    QJsonObject jsonObj;
    QJsonArray jsonArray;
    QJsonParseError jsonParse;

    bool jsonLoadedStatus;
    int m_driver;
    int m_biasVal;
    int m_tractionSwitch;
    int m_launchAim;
    int m_antiLag;
    bool m_fuelAim;
    bool m_ignitionTiming;
    bool m_throttleMap;
};

#endif // JSONMANAGER_H
