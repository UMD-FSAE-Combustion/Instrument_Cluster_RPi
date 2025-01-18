/****************************************************************************
** Generated QML type registration code
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <QtQml/qqml.h>
#include <QtQml/qqmlmoduleregistration.h>

#include <canmanager.h>
#include <gpiohandler.h>
#include <jsonmanager.h>


#if !defined(QT_STATIC)
#define Q_QMLTYPE_EXPORT Q_DECL_EXPORT
#else
#define Q_QMLTYPE_EXPORT
#endif
Q_QMLTYPE_EXPORT void qml_register_types_Dyno_Info()
{
    qmlRegisterTypesAndRevisions<CANmanager>("Dyno_Info", 1);
    qmlRegisterTypesAndRevisions<GPIOhandler>("Dyno_Info", 1);
    qmlRegisterTypesAndRevisions<JSONmanager>("Dyno_Info", 1);
    qmlRegisterModule("Dyno_Info", 1, 0);
}

static const QQmlModuleRegistration registration("Dyno_Info", qml_register_types_Dyno_Info);
