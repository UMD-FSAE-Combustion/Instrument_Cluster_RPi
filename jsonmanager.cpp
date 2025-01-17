#include "jsonmanager.h"


JSONmanager::JSONmanager()
{
    loadProfileOnBoot();
}

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
            //bias = jsonArray[profile].toObject().value("Bias").toInt();
            m_biasVal = jsonArray[m_driver].toObject().value("Bias").toInt();

            //add can here for setting servo position (or maybe in startup?)

            //traction = jsonArray[profile].toObject().value("tcSwitch").toInt();
            m_tractionSwitch = jsonArray[m_driver].toObject().value("tcSwitch").toInt();
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
        setDriver(profile); //not working

        QJsonArray arr = RootObject.value("Drivers").toArray();
        //bias = arr[profile].toObject().value("Bias").toInt();
        int newBias = arr[profile].toObject().value("Bias").toInt();
        setBiasVal(newBias);

        //traction = arr[profile].toObject().value("tcSwitch").toInt();
        int newTraction = arr[profile].toObject().value("tcSwitch").toInt();
        setTractionSwitch(newTraction);

        //
        //ADD CAN SIGNALING TO ACTUALLY UPDATE BRAKES!!!
        //



        //
        //ADD CAN SIGNALIN TO ATUALLY UPDATE!!!!

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
            info["Bias"] = bias;

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
            info["tcSwitch"] = traction;
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

bool JSONmanager::loadChannelList(std::vector<mapVals>& channelInfo)
{
    mapVals channel;

    file.setFileName(qApp->applicationDirPath() + "/data/channelList.json");
    if(file.open(QIODevice::ReadOnly))
    {
        QByteArray Bytes = file.readAll();
        file.close();

        jsonDoc = QJsonDocument::fromJson(Bytes, &jsonParse);
        if(jsonParse.error != QJsonParseError::NoError)
        {
            qDebug() << "Json Error:" << jsonParse.errorString();
            return false;
        }

        if(jsonDoc.isObject())
        {
            jsonObj = jsonDoc.object();
            QJsonArray channelArray = jsonObj.value("channels").toArray();

            for(int i = 0; i < channelArray.size(); i++)
            {
                QJsonObject newObj = channelArray.at(i).toObject();

                channel.name = newObj["name"].toString();
                channel.units = newObj["unit"].toString();
                channel.minUnits = QString::number(newObj["min"].toInt());
                channel.maxUnits = QString::number(newObj["max"].toInt());

                channelInfo.push_back(channel);
            }
            return true;
        }
        else
        {
            qDebug() << "Error on jsonDoc.isObject()";
            return false;
        }
    }
    else
    {
        qDebug() << "File could not be opened";
        return false;
    }
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
