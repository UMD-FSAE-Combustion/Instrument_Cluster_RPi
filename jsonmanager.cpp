#include "jsonmanager.h"


JSONmanager::JSONmanager()
{
}

void JSONmanager::loadProfileOnBoot(int& profile, int& bias, int& traction)
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

            profile = jsonObj.value("LastDriver").toObject().value("LastDriver").toInt() - 1;
            jsonArray = jsonObj.value("Drivers").toArray();
            //bias = jsonArray[profile].toObject().value("Bias").toInt();
            json_BiasVal = jsonArray[profile].toObject().value("Bias").toInt();

            //add can here for setting servo position (or maybe in startup?)

            //traction = jsonArray[profile].toObject().value("tcSwitch").toInt();
            json_tractionSwitch = jsonArray[profile].toObject().value("tcSwitch").toInt();
        }
    }
    else
        qDebug() << "File could not be opened";
}

void JSONmanager::loadProfile(int profile, int& bias, int& traction)
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


        QJsonArray arr = RootObject.value("Drivers").toArray();
        //bias = arr[profile].toObject().value("Bias").toInt();
        json_BiasVal = arr[profile].toObject().value("Bias").toInt();


        //traction = arr[profile].toObject().value("tcSwitch").toInt();
        json_tractionSwitch = arr[profile].toObject().value("tcSwitch").toInt();

        //
        //ADD CAN SIGNALING TO ACTUALLY UPDATE BRAKES!!!
        //



        //
        //ADD CAN SIGNALIN TO ATUALLY UPDATE!!!!

        QJsonValueRef Driver = RootObject.find("LastDriver").value();
        QJsonObject newDriver = Driver.toObject();

        newDriver["LastDriver"] = profile + 1;
        Driver = newDriver;

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
