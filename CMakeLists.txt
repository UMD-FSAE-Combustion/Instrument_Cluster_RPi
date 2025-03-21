cmake_minimum_required(VERSION 3.16)

project(Dyno_Info VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick SerialBus)

include_directories(/lib/x86_64-linux-gnu/)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appDyno_Info
    main.cpp
)

qt_add_qml_module(appDyno_Info
    URI Dyno_Info
    VERSION 1.0
    QML_FILES
        Main.qml

        SOURCES
        gpiohandler.h gpiohandler.cpp
        jsonmanager.h jsonmanager.cpp
        canmanager.h canmanager.cpp
        shutdownhandler.h

        RESOURCES
        assets/images/blockM.png
        assets/images/teamlogo.png
        assets/images/icon.ico
        assets/images/teamlogo2.png
        assets/images/raceCar.png
        assets/images/INFO.png
        assets/images/WARN.png
        assets/images/LC.png
        assets/images/lock_icon.png
        assets/images/kachow.png
        assets/images/pacMan.png
        assets/images/pacManClosed.png
        assets/images/pacManMenuScreen.png
        assets/images/ghost.png
        assets/images/ghostScared.png
        assets/images/endScreen.png
        QML_FILES TractionControl.qml
        QML_FILES BrakeBias.qml
        QML_FILES VehicleInfoDisplay.qml
        QML_FILES VehicleInfoDisplayExtraWidgets.qml
        QML_FILES OptionsMenu.qml
        QML_FILES GameMenu.qml
        QML_FILES AnimationManager.qml
        QML_FILES InputManager.qml
        QML_FILES Pong.qml
        QML_FILES AntilagControl.qml
        QML_FILES LaunchAimControl.qml
        QML_FILES PacMan.qml
)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appDyno_Info PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appDyno_Info
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appDyno_Info
    PRIVATE Qt6::Quick
    Qt6::SerialBus
    /usr/local/lib/libwiringPi.so
)

include(GNUInstallDirs)
install(TARGETS appDyno_Info
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
