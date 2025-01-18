cmake_minimum_required(VERSION 3.16)

project(Dyno_Info VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

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
        mapVals.h

        RESOURCES
        assets/images/blockM.png
        assets/images/teamlogo.png
        assets/images/icon.ico
        assets/images/teamlogo2.png
        assets/images/raceCar.png
        assets/images/INFO.png
        assets/images/WARN.png
        QML_FILES TractionControl.qml
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
)

include(GNUInstallDirs)
install(TARGETS appDyno_Info
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
