/****************************************************************************
** Meta object code from reading C++ file 'jsonmanager.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.5.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../jsonmanager.h"
#include <QtNetwork/QSslPreSharedKeyAuthenticator>
#include <QtNetwork/QSslError>
#include <QtCore/qmetatype.h>

#if __has_include(<QtCore/qtmochelpers.h>)
#include <QtCore/qtmochelpers.h>
#else
QT_BEGIN_MOC_NAMESPACE
#endif


#include <memory>

#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'jsonmanager.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.5.3. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {

#ifdef QT_MOC_HAS_STRINGDATA
struct qt_meta_stringdata_CLASSJSONmanagerENDCLASS_t {};
static constexpr auto qt_meta_stringdata_CLASSJSONmanagerENDCLASS = QtMocHelpers::stringData(
    "JSONmanager",
    "QML.Element",
    "auto",
    "BiasValChanged",
    "",
    "DriverChanged",
    "tractionSwitchChanged",
    "loadProfile",
    "updateBrakeBias",
    "updateTractionCtl",
    "driver",
    "biasVal",
    "tractionSwitch"
);
#else  // !QT_MOC_HAS_STRING_DATA
struct qt_meta_stringdata_CLASSJSONmanagerENDCLASS_t {
    uint offsetsAndSizes[26];
    char stringdata0[12];
    char stringdata1[12];
    char stringdata2[5];
    char stringdata3[15];
    char stringdata4[1];
    char stringdata5[14];
    char stringdata6[22];
    char stringdata7[12];
    char stringdata8[16];
    char stringdata9[18];
    char stringdata10[7];
    char stringdata11[8];
    char stringdata12[15];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_CLASSJSONmanagerENDCLASS_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_CLASSJSONmanagerENDCLASS_t qt_meta_stringdata_CLASSJSONmanagerENDCLASS = {
    {
        QT_MOC_LITERAL(0, 11),  // "JSONmanager"
        QT_MOC_LITERAL(12, 11),  // "QML.Element"
        QT_MOC_LITERAL(24, 4),  // "auto"
        QT_MOC_LITERAL(29, 14),  // "BiasValChanged"
        QT_MOC_LITERAL(44, 0),  // ""
        QT_MOC_LITERAL(45, 13),  // "DriverChanged"
        QT_MOC_LITERAL(59, 21),  // "tractionSwitchChanged"
        QT_MOC_LITERAL(81, 11),  // "loadProfile"
        QT_MOC_LITERAL(93, 15),  // "updateBrakeBias"
        QT_MOC_LITERAL(109, 17),  // "updateTractionCtl"
        QT_MOC_LITERAL(127, 6),  // "driver"
        QT_MOC_LITERAL(134, 7),  // "biasVal"
        QT_MOC_LITERAL(142, 14)   // "tractionSwitch"
    },
    "JSONmanager",
    "QML.Element",
    "auto",
    "BiasValChanged",
    "",
    "DriverChanged",
    "tractionSwitchChanged",
    "loadProfile",
    "updateBrakeBias",
    "updateTractionCtl",
    "driver",
    "biasVal",
    "tractionSwitch"
};
#undef QT_MOC_LITERAL
#endif // !QT_MOC_HAS_STRING_DATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSJSONmanagerENDCLASS[] = {

 // content:
      11,       // revision
       0,       // classname
       1,   14, // classinfo
       6,   16, // methods
       3,   68, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // classinfo: key, value
       1,    2,

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       3,    0,   52,    4, 0x06,    4 /* Public */,
       5,    0,   53,    4, 0x06,    5 /* Public */,
       6,    0,   54,    4, 0x06,    6 /* Public */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
       7,    1,   55,    4, 0x02,    7 /* Public */,
       8,    2,   58,    4, 0x02,    9 /* Public */,
       9,    2,   63,    4, 0x02,   12 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void, QMetaType::Int,    4,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int,    4,    4,
    QMetaType::Bool, QMetaType::Int, QMetaType::Int,    4,    4,

 // properties: name, type, flags
      10, QMetaType::Int, 0x00015903, uint(1), 0,
      11, QMetaType::Int, 0x00015903, uint(0), 0,
      12, QMetaType::Int, 0x00015903, uint(2), 0,

       0        // eod
};

Q_CONSTINIT const QMetaObject JSONmanager::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSJSONmanagerENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSJSONmanagerENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_metaTypeArray<
        // property 'driver'
        int,
        // property 'biasVal'
        int,
        // property 'tractionSwitch'
        int,
        // Q_OBJECT / Q_GADGET
        JSONmanager,
        // method 'BiasValChanged'
        void,
        // method 'DriverChanged'
        void,
        // method 'tractionSwitchChanged'
        void,
        // method 'loadProfile'
        void,
        int,
        // method 'updateBrakeBias'
        bool,
        int,
        int,
        // method 'updateTractionCtl'
        bool,
        int,
        int
    >,
    nullptr
} };

void JSONmanager::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<JSONmanager *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->BiasValChanged(); break;
        case 1: _t->DriverChanged(); break;
        case 2: _t->tractionSwitchChanged(); break;
        case 3: _t->loadProfile((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 4: { bool _r = _t->updateBrakeBias((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 5: { bool _r = _t->updateTractionCtl((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (JSONmanager::*)();
            if (_t _q_method = &JSONmanager::BiasValChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (JSONmanager::*)();
            if (_t _q_method = &JSONmanager::DriverChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (JSONmanager::*)();
            if (_t _q_method = &JSONmanager::tractionSwitchChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
    }else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<JSONmanager *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = _t->getDriver(); break;
        case 1: *reinterpret_cast< int*>(_v) = _t->getBiasVal(); break;
        case 2: *reinterpret_cast< int*>(_v) = _t->getTractionSwitch(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<JSONmanager *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setDriver(*reinterpret_cast< int*>(_v)); break;
        case 1: _t->setBiasVal(*reinterpret_cast< int*>(_v)); break;
        case 2: _t->setTractionSwitch(*reinterpret_cast< int*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    } else if (_c == QMetaObject::BindableProperty) {
    }
}

const QMetaObject *JSONmanager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *JSONmanager::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSJSONmanagerENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int JSONmanager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 6)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 6;
    }else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    }
    return _id;
}

// SIGNAL 0
void JSONmanager::BiasValChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void JSONmanager::DriverChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void JSONmanager::tractionSwitchChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}
QT_WARNING_POP
