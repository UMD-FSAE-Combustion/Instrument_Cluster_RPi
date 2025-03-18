#include "jsonmanager.h"


JSONmanager::JSONmanager()
{
    jsonLoadedStatus = false;
    loadProfileOnBoot();
}

JSONmanager::~JSONmanager()
{}

void JSONmanager::loadProfileOnBoot()
{
    file.setFileName(qApp->applicationDirPath() + "/data/Data.json");
    if(file.open(QIODevice::ReadOnly))
    {
        QByteArray Bytes = file.readAll();
        file.close();

        jsonDoc = QJsonDocument::fromJson(Bytes, &jsonParse);
        if(jsonParse.error != QJsonParseError::NoError)
        {
            qDebug() << "Json Error:" << jsonParse.errorString();
            return;
        }

        if(jsonDoc.isObject())
        {
            jsonObj = jsonDoc.object();

            m_driver = jsonObj.value("LastDriver").toObject().value("LastDriver").toInt() - 1;
            jsonArray = jsonObj.value("Drivers").toArray();

            m_biasVal = jsonArray[m_driver].toObject().value("Bias").toInt();
            m_tractionSwitch = jsonArray[m_driver].toObject().value("tcSwitch").toInt();
            m_antiLag = jsonArray[m_driver].toObject().value("antiLagSwitch").toInt();
            m_launchAim = jsonArray[m_driver].toObject().value("launchAim").toInt();
            m_fuelAim = jsonArray[m_driver].toObject().value("fuelAim").toBool();
            m_ignitionTiming = jsonArray[m_driver].toObject().value("ignitionTiming").toBool();
            m_throttleMap = jsonArray[m_driver].toObject().value("throttleMap").toBool();

            jsonLoadedStatus = true;
        }
    }
    else
        qDebug() << "File could not be opened";
}

void JSONmanager::loadProfile(int profile)
{
    QFile File(qApp->applicationDirPath() + "/data/Data.json");
    if(File.open(QIODevice::ReadOnly))
    {
        QByteArray Bytes = File.readAll();
        File.close();

        QJsonParseError JsonError;
        QJsonDocument Doc = QJsonDocument::fromJson(Bytes, &JsonError);

        QJsonObject RootObject = Doc.object();

        //int Driver = ui->stackedWidget->currentIndex() - 5;
        setDriver(profile);

        QJsonArray arr = RootObject.value("Drivers").toArray();
        int newBias = arr[profile].toObject().value("Bias").toInt();
        setBiasVal(newBias);

        int newTraction = arr[profile].toObject().value("tcSwitch").toInt();
        setTractionSwitch(newTraction);

        int newAntiLag = jsonArray[m_driver].toObject().value("antiLagSwitch").toInt();
        setAntiLag(newAntiLag);

        int newLaunchAim = jsonArray[m_driver].toObject().value("launchAim").toInt();
        setLaunchAim(newLaunchAim);

        bool newIgnitionTiming = jsonArray[m_driver].toObject().value("ignitionTiming").toBool();
        setIgnitionTiming(newIgnitionTiming);

        bool newFuelAim = jsonArray[m_driver].toObject().value("fuelAim").toBool();
        setFuelAim(newFuelAim);

        bool newThrottleMap = jsonArray[m_driver].toObject().value("throttleMap").toBool();
        setThrottleMap(newThrottleMap);

        QJsonValueRef updDriver = RootObject.find("LastDriver").value();
        QJsonObject newDriver = updDriver.toObject();

        newDriver["LastDriver"] = profile + 1;
        updDriver = newDriver;

        Doc.setObject(RootObject);
        File.open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::Truncate);
        File.write(Doc.toJson());
        File.close();
    }
}

bool JSONmanager::updateBrakeBias(int profile, int bias)
{
    //QFile File(qApp->applicationDirPath() + "/data/Data.json");

    if(file.open(QIODevice::ReadOnly))
    {
        //retrurn true
        QByteArray Bytes = file.readAll();
        file.close();

        QJsonParseError JsonError;
        QJsonDocument Doc = QJsonDocument::fromJson(Bytes, &JsonError);
        if(JsonError.error != QJsonParseError::NoError)
        {
            qDebug() << "Json Error: " << JsonError.errorString();
            return false;
        }

        QJsonObject RootObject = Doc.object();
        QJsonValueRef ArrayRef = RootObject.find("Drivers").value();
        QJsonArray arr = ArrayRef.toArray();

        QJsonValueRef objRef = arr[profile];
        QJsonObject info = objRef.toObject();


        if(info["Bias"] != bias)
        {
            m_biasVal = bias;
            info["Bias"] = m_biasVal;

            objRef = info;
            ArrayRef = arr;

            Doc.setObject(RootObject);
            if(file.open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::Truncate))
            {
                file.write(Doc.toJson());
                file.close();
                qDebug() << "Brake Bias updated successfully";
            }
            return true;
        }
        else
        {
            //close file without changing values and return false
            Doc.setObject(RootObject);
            //file.write(Doc.toJson());
            file.close();
            return false;
        }
    }
    else
        return false;
}

bool JSONmanager::updateTractionCtl(int profile, int traction)
{
    if(file.open(QIODevice::ReadOnly))
    {
        QByteArray Bytes = file.readAll();
        file.close();

        QJsonParseError JsonError;
        QJsonDocument Doc = QJsonDocument::fromJson(Bytes, &JsonError);
        if(JsonError.error != QJsonParseError::NoError)
        {
            qDebug() << "Json Error: " << JsonError.errorString();
        }

        QJsonObject RootObject = Doc.object();
        QJsonArray arr = RootObject.value("Drivers").toArray();
        QJsonObject info = arr[profile].toObject();

        if(info["tcSwitch"] != traction)
        {
            m_tractionSwitch = traction;
            info["tcSwitch"] = m_tractionSwitch;
            arr[profile] = info;

            RootObject["Drivers"] = arr;
            Doc.setObject(RootObject);

            if(file.open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::Truncate))
            {
                file.write(Doc.toJson());
                file.close();
                qDebug() << "Traction Settings updated successfully";
            }
            return true;
        }
        else
        {
            //close file without changing values and return false
            file.close();
            return false;
        }
    }
    else
        return false;
}

bool JSONmanager::updateAntiLag(int profile, int antiLag)
{
    if(file.open(QIODevice::ReadOnly))
    {
        QByteArray Bytes = file.readAll();
        file.close();

        QJsonParseError JsonError;
        QJsonDocument Doc = QJsonDocument::fromJson(Bytes, &JsonError);
        if(JsonError.error != QJsonParseError::NoError)
        {
            qDebug() << "Json Error: " << JsonError.errorString();
        }

        QJsonObject RootObject = Doc.object();
        QJsonArray arr = RootObject.value("Drivers").toArray();
        QJsonObject info = arr[profile].toObject();

        if(info["antiLagSwitch"] != antiLag)
        {
            m_antiLag = antiLag;
            info["antiLagSwitch"] = m_antiLag;
            arr[profile] = info;

            RootObject["Drivers"] = arr;
            Doc.setObject(RootObject);

            if(file.open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::Truncate))
            {
                file.write(Doc.toJson());
                file.close();
                qDebug() << "Anti-Lag Settings updated successfully";
            }
            return true;
        }
        else
        {
            //close file without changing values and return false
            file.close();
            return false;
        }
    }
    else
        return false;
}

bool JSONmanager::updateFuelAim(int profile, int fuelAim)
{
    if(file.open(QIODevice::ReadOnly))
    {
        QByteArray Bytes = file.readAll();
        file.close();

        QJsonParseError JsonError;
        QJsonDocument Doc = QJsonDocument::fromJson(Bytes, &JsonError);
        if(JsonError.error != QJsonParseError::NoError)
        {
            qDebug() << "Json Error: " << JsonError.errorString();
        }

        QJsonObject RootObject = Doc.object();
        QJsonArray arr = RootObject.value("Drivers").toArray();
        QJsonObject info = arr[profile].toObject();

        if(info["fuelAim"] != fuelAim)
        {
            m_fuelAim = fuelAim;
            info["fuelAim"] = m_fuelAim;
            arr[profile] = info;

            RootObject["Drivers"] = arr;
            Doc.setObject(RootObject);

            if(file.open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::Truncate))
            {
                file.write(Doc.toJson());
                file.close();
                qDebug() << "Fuel Aim Settings updated successfully";
            }
            return true;
        }
        else
        {
            //close file without changing values and return false
            file.close();
            return false;
        }
    }
    else
        return false;
}

bool JSONmanager::updateLaunchAim(int profile, int launchAim)
{
    if(file.open(QIODevice::ReadOnly))
    {
        QByteArray Bytes = file.readAll();
        file.close();

        QJsonParseError JsonError;
        QJsonDocument Doc = QJsonDocument::fromJson(Bytes, &JsonError);
        if(JsonError.error != QJsonParseError::NoError)
        {
            qDebug() << "Json Error: " << JsonError.errorString();
        }

        QJsonObject RootObject = Doc.object();
        QJsonArray arr = RootObject.value("Drivers").toArray();
        QJsonObject info = arr[profile].toObject();

        if(info["launchAim"] != launchAim)
        {
            m_launchAim = launchAim;
            info["launchAim"] = m_launchAim;
            arr[profile] = info;

            RootObject["Drivers"] = arr;
            Doc.setObject(RootObject);

            if(file.open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::Truncate))
            {
                file.write(Doc.toJson());
                file.close();
                qDebug() << "Launc Aim Settings updated successfully";
            }
            return true;
        }
        else
        {
            //close file without changing values and return false
            file.close();
            return false;
        }
    }
    else
        return false;
}

bool JSONmanager::updateIgnition(int profile, int ignitionStatus)
{
    if(file.open(QIODevice::ReadOnly))
    {
        QByteArray Bytes = file.readAll();
        file.close();

        QJsonParseError JsonError;
        QJsonDocument Doc = QJsonDocument::fromJson(Bytes, &JsonError);
        if(JsonError.error != QJsonParseError::NoError)
        {
            qDebug() << "Json Error: " << JsonError.errorString();
        }

        QJsonObject RootObject = Doc.object();
        QJsonArray arr = RootObject.value("Drivers").toArray();
        QJsonObject info = arr[profile].toObject();

        if(info["ignitionTiming"] != ignitionStatus)
        {
            m_ignitionTiming = ignitionStatus;
            info["ignitionTiming"] = m_ignitionTiming;
            arr[profile] = info;

            RootObject["Drivers"] = arr;
            Doc.setObject(RootObject);

            if(file.open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::Truncate))
            {
                file.write(Doc.toJson());
                file.close();
                qDebug() << "Ignition Timing Settings updated successfully";
            }
            return true;
        }
        else
        {
            //close file without changing values and return false
            file.close();
            return false;
        }
    }
    else
        return false;
}

bool JSONmanager::updateThrottleMap(int profile, int throttleMap)
{
    if(file.open(QIODevice::ReadOnly))
    {
        QByteArray Bytes = file.readAll();
        file.close();

        QJsonParseError JsonError;
        QJsonDocument Doc = QJsonDocument::fromJson(Bytes, &JsonError);
        if(JsonError.error != QJsonParseError::NoError)
        {
            qDebug() << "Json Error: " << JsonError.errorString();
        }

        QJsonObject RootObject = Doc.object();
        QJsonArray arr = RootObject.value("Drivers").toArray();
        QJsonObject info = arr[profile].toObject();

        if(info["throttleMap"] != throttleMap)
        {
            m_throttleMap = throttleMap;
            info["throttleMap"] = m_throttleMap;
            arr[profile] = info;

            RootObject["Drivers"] = arr;
            Doc.setObject(RootObject);

            if(file.open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::Truncate))
            {
                file.write(Doc.toJson());
                file.close();
                qDebug() << "Throttle Map Settings updated successfully";
            }
            return true;
        }
        else
        {
            //close file without changing values and return false
            file.close();
            return false;
        }
    }
    else
        return false;
}

bool JSONmanager::jsonLoaded() const
{
    return jsonLoadedStatus;
}

int JSONmanager::getBiasVal() const
{
    return m_biasVal;
}

void JSONmanager::setBiasVal(int newBiasVal)
{
    if (m_biasVal == newBiasVal)
        return;
    m_biasVal = newBiasVal;
    emit BiasValChanged();
}

int JSONmanager::getDriver() const
{
    return m_driver;
}

void JSONmanager::setDriver(int newDriver)
{
    if (m_driver == newDriver)
        return;
    m_driver = newDriver;
    emit DriverChanged();
}

int JSONmanager::getTractionSwitch() const
{
    return m_tractionSwitch;
}

void JSONmanager::setTractionSwitch(int newTractionSwitch)
{
    if (m_tractionSwitch == newTractionSwitch)
        return;
    m_tractionSwitch = newTractionSwitch;
    emit tractionSwitchChanged();
}

int JSONmanager::antiLag() const
{
    return m_antiLag;
}

void JSONmanager::setAntiLag(int newAntiLag)
{
    if (m_antiLag == newAntiLag)
        return;
    m_antiLag = newAntiLag;
    emit antiLagChanged();
}

bool JSONmanager::fuelAim() const
{
    return m_fuelAim;
}

void JSONmanager::setFuelAim(bool newFuelAim)
{
    if (m_fuelAim == newFuelAim)
        return;
    m_fuelAim = newFuelAim;
    emit fuelAimChanged();
}

int JSONmanager::launchAim() const
{
    return m_launchAim;
}

void JSONmanager::setLaunchAim(int newLaunchAim)
{
    if (m_launchAim == newLaunchAim)
        return;
    m_launchAim = newLaunchAim;
    emit launchAimChanged();
}

bool JSONmanager::ignitionTiming() const
{
    return m_ignitionTiming;
}

void JSONmanager::setIgnitionTiming(bool newIgnitionTiming)
{
    if (m_ignitionTiming == newIgnitionTiming)
        return;
    m_ignitionTiming = newIgnitionTiming;
    emit ignitionTimingChanged();
}

bool JSONmanager::throttleMap() const
{
    return m_throttleMap;
}

void JSONmanager::setThrottleMap(bool newThrottleMap)
{
    if (m_throttleMap == newThrottleMap)
        return;
    m_throttleMap = newThrottleMap;
    emit throttleMapChanged();
}
