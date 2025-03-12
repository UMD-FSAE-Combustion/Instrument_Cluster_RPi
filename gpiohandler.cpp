#include "gpiohandler.h"

#define BUTTON_TOP 23
#define BUTTON_BOTTOM 24
#define BUTTON_LEFT 27
#define BUTTON_RIGHT 22

GPIOhandler* GPIOhandler::InterruptPtr;

GPIOhandler::GPIOhandler(QObject *parent)
    : QObject{parent}
{

    if(QSysInfo::productType() != "pop")
    {
        if(wiringPiSetupGpio() == -1)
            qDebug() << "GPIO init failed...";
        else
        {
            pinMode(BUTTON_RIGHT, INPUT);
            pinMode(BUTTON_LEFT, INPUT);
            pinMode(BUTTON_TOP, INPUT);
            pinMode(BUTTON_BOTTOM, INPUT);
            pullUpDnControl(BUTTON_RIGHT, PUD_UP);
            pullUpDnControl(BUTTON_LEFT, PUD_UP);
            pullUpDnControl(BUTTON_TOP, PUD_UP);
            pullUpDnControl(BUTTON_BOTTOM, PUD_UP);

            wiringPiISR(BUTTON_RIGHT, INT_EDGE_FALLING, &pushButtonRight);
            wiringPiISR(BUTTON_LEFT, INT_EDGE_FALLING, &pushButtonLeft);
            wiringPiISR(BUTTON_TOP, INT_EDGE_FALLING, &pushButtonTop);
            wiringPiISR(BUTTON_BOTTOM, INT_EDGE_FALLING, &pushButtonBottom);
        }
    }
}


void GPIOhandler::pushButtonRight()
{
    delay(100);  //Debounce
    if(digitalRead(BUTTON_RIGHT) == LOW)
    {
        //qDebug() << "right button pressed";
        emit InterruptPtr->ButtonRight();
    }
}

void GPIOhandler::pushButtonLeft()
{
    delay(100);  //Debounce
    if(digitalRead(BUTTON_LEFT) == LOW)
    {
        //qDebug() << "left button pressed";
        emit InterruptPtr->ButtonLeft();
    }
}

void GPIOhandler::pushButtonTop()
{
    delay(120);  //Debounce
    if(digitalRead(BUTTON_TOP) == LOW)
    {
        //qDebug() << "top button pressed";
        emit InterruptPtr->ButtonTop();
    }
}

void GPIOhandler::pushButtonBottom()
{
    delay(100);  //Debounce
    if(digitalRead(BUTTON_BOTTOM) == LOW)
    {
        //qDebug() << "bottom button pressed";
        emit InterruptPtr->ButtonBottom();
    }
}
