#include <QGuiApplication>
#include <QQuickView>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "jsonmanager.h"
#include "canmanager.h"
#include "gpiohandler.h"

void loadingScreen(QQuickView &splashView)
{
    splashView.setSource(QUrl("Dyno_Info/LoadingScreen.qml"));
    splashView.resize(800, 480);
    splashView.show();
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickView splashView;
    splashView.setSource(QUrl("Dyno_Info/SplashScreen.qml"));
    splashView.resize(800, 480);
    splashView.show();
    app.processEvents();

    while(!splashView.isVisible())
        app.processEvents();

    QQmlApplicationEngine engine;

    JSONmanager json;
    CANmanager canBus;
    GPIOhandler gpio;

    canBus.updatePayload(CANmanager::FRONTBIAS, json.getBiasVal());
    canBus.updatePayload(CANmanager::TCSWITCH, json.getTractionSwitch() * 3);
    canBus.updatePayload(CANmanager::ANTI_LAG, json.antiLag() * 3);
    canBus.updatePayload(CANmanager::FUEL_AIM, json.fuelAim());
    canBus.updatePayload(CANmanager::IGNITION, json.ignitionTiming());
    canBus.updatePayload(CANmanager::LAUNCH_AIM, json.launchAim() * 3);
    canBus.updatePayload(CANmanager::THROTTLE_MAP, json.throttleMap());
    canBus.sendLoop();

    engine.rootContext()->setContextProperty("splashScreen", &splashView);
    engine.rootContext()->setContextProperty("JSON", &json);
    engine.rootContext()->setContextProperty("canBus", &canBus);
    engine.rootContext()->setContextProperty("gpio", &gpio);

    qDebug() << qVersion();

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Dyno_Info", "Main");

    return app.exec();
}
