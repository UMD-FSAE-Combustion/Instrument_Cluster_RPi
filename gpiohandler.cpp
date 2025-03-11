#include "gpiohandler.h"
#include <wiringPi.h>
#include <iostream>

#define BUTTTON_TOP 23
#define BUTTTON_BOTTOM 24
#define BUTTTON_LEFT 27
#define BUTTTON_RIGHT 22



GPIOhandler::GPIOhandler(QObject *parent)
    : QObject{parent}
{}
