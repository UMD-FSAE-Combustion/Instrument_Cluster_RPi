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
#include <mapVals.h>


class JSONmanager : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    JSONmanager();

    void loadProfileOnBoot(int&, int&, int&);
    void loadProfile(int, int&, int&);
    bool updateBrakeBias(int, int);
    bool updateTractionCtl(int, int);

    bool loadChannelList(std::vector<mapVals>&);
    //bool setWidgetChannel(int, QString);
private:

    QFile file;

    QJsonDocument jsonDoc;
    QJsonObject jsonObj;
    QJsonArray jsonArray;
    QJsonParseError jsonParse;

    int json_Driver;
    int json_BiasVal;
    int json_tractionSwitch;
};

#endif // JSONMANAGER_H
