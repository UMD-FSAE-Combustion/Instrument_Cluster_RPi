#include "canmanager.h"

/*
 * WHEN SETTING UP ON NEW DEVICE:
 *
 * apt-get install libqt6serialbus
 * apt-get install libqt6serialbus-dev
 *
 * apt-get install libqt6serialport
 * apt-get install libqt6serialport-dev
 *
 * apt-get install libsocketcan-dev
 *
 */

CANmanager::CANmanager()
{
    QString errorString;
    can_device = QCanBus::instance()->createDevice(QStringLiteral("socketcan"), QStringLiteral("can0"), &errorString);
    if (!can_device)
    {
        // Error handling goes here
        qDebug() << errorString;
    }
    else
    {
        can_device->connectDevice();
        qDebug() << "CAN Device connected!";
    }

    QCanBusDevice::Filter filter;
    QList<QCanBusDevice::Filter> filterList;


    filter.frameIdMask = 0xFFFu;
    filter.format = QCanBusDevice::Filter::MatchBaseFormat;
    filter.frameId = 0x64A;
    filterList.append(filter);

    filter.frameId = 0x649;
    filterList.append(filter);

    filter.frameId = 0x640;
    filterList.append(filter);

    filter.frameId = 0x641;
    filterList.append(filter);

    filter.frameId = 0x651;
    filterList.append(filter);

    can_device->setConfigurationParameter(QCanBusDevice::RawFilterKey, QVariant::fromValue(filterList));
    connect(can_device, &QCanBusDevice::framesReceived, this, &CANmanager::processFrames);
    connect(this, &CANmanager::signalLoop, this, &CANmanager::sendLoop);

    frame.setFrameId(0x704);
}

CANmanager::CANmanager(uint filterID)
{
    QString errorString;
    can_device = QCanBus::instance()->createDevice(QStringLiteral("socketcan"), QStringLiteral("can0"), &errorString);
    if (!can_device)
    {
        // Error handling goes here
        qDebug() << errorString;
    }
    else
    {
        can_device->connectDevice();
        qDebug() << "CAN Device connected!";
    }

    QCanBusDevice::Filter filter;
    QList<QCanBusDevice::Filter> filterList;
    filter.frameId = filterID;
    filter.frameIdMask = 0xFFFu;
    filter.format = QCanBusDevice::Filter::MatchBaseFormat;
    filterList.append(filter);

    can_device->setConfigurationParameter(QCanBusDevice::RawFilterKey, QVariant::fromValue(filterList));
    connect(can_device, &QCanBusDevice::framesReceived, this, &CANmanager::processFrames);
    connect(this, &CANmanager::signalLoop, this, &CANmanager::sendLoop);


    frame.setFrameId(0x704);
}

void CANmanager::processFrames()
{
    QCanBusFrame frame = can_device->readFrame();
    QByteArray bytes = frame.payload();
    //qDebug() << bytes;

    for(int i = 0; i < 8; i++)
        frameBuffer[i] = bytes.at(i);

    emit(signalUI());
}

int* CANmanager::getFrame()
{
    return frameBuffer;
}

int CANmanager::getByte(int byte)
{
    return frameBuffer[byte];
}


void CANmanager::updatePayload(int id, int data)
{
    /*
    * ARRAY ID | VALUE
    * ---------|-------
    *   0      | BiasValue
    *   1      | TractionValue
    *   2      | Launch Flag (on/off)
    */
    sendBuffer[id] = data;
}

void CANmanager::sendMessage()
{
    if(can_device->busStatus() != QCanBusDevice::CanBusStatus::BusOff && can_device->busStatus() != QCanBusDevice::CanBusStatus::Error)
    {
        QByteArray sendBytes;
        for(int i = 0; i < 3; i++)
        {
            sendBytes.append(char(sendBuffer[i]));
        }

        //qDebug() << sendBytes;
        frame.setPayload(sendBytes);
        if(can_device->writeFrame(frame))
            emit(signalLoop());
    }
}

bool CANmanager::sendOnce()
{
    if(can_device->busStatus() != QCanBusDevice::CanBusStatus::BusOff && can_device->busStatus() != QCanBusDevice::CanBusStatus::Error)
    {
        QByteArray sendBytes;
        for(int i = 0; i < 3; i++)
        {
            sendBytes.append(char(sendBuffer[i]));
        }

        //qDebug() << sendBytes;
        frame.setPayload(sendBytes);

        if(can_device->writeFrame(frame))
            return true;
        else
            return false;
    }
    else
        return false;
}

void CANmanager::sendLoop()
{
    //Delay::delayMillis(1000);
    //sendMessage();

    connect(&timer, &QTimer::timeout, this, &CANmanager::sendMessage);
    timer.start(1000);
}

QCanBusDevice::CanBusStatus CANmanager::getDeviceStatus()
{
    return can_device->busStatus();
}
