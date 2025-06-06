cmake_minimum_required(VERSION 3.16)

project(Touch VERSION 0.1 LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)

set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(Touch
    WIN32
    src/main.cpp
    res.qrc
    src/TcpClient.h
    src/TcpClient.cpp
    src/TcpServer.h
    src/TcpServer.cpp
    src/icon.rc
    android/AndroidManifest.xml android/build.gradle android/res/values/libs.xml android/res/xml/qtprovider_paths.xml

)
qt_policy(SET QTP0004 NEW)

qt_add_resources(Touch "Global.configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

target_link_libraries(Touch PRIVATE #-Wl,-subsystem,windows
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
install(TARGETS Touch
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

set_property(TARGET Touch
    APPEND PROPERTY  QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android
)

