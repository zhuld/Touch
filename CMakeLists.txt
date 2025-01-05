cmake_minimum_required(VERSION 3.21.1)

project(TouchApp VERSION 0.2 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)

set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(TouchApp
    src/main.cpp
    res.qrc
    src/TcpClient.h
    src/TcpClient.cpp
    src/TcpServer.h
    src/TcpServer.cpp
    src/icon.rc
)
qt_policy(SET QTP0004 NEW)

qt_add_resources(TouchApp "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

target_link_libraries(TouchApp PRIVATE #-Wl,-subsystem,windows
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)

include(${CMAKE_CURRENT_SOURCE_DIR}/qmlmodules)

# if (LINK_INSIGHT)
#     include(${CMAKE_CURRENT_SOURCE_DIR}/insight)
# endif ()

include(GNUInstallDirs)
install(TARGETS TouchApp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

set_property(TARGET TouchApp
    APPEND PROPERTY  QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android
)

