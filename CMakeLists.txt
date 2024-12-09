cmake_minimum_required(VERSION 3.21.1)

#option(LINK_INSIGHT "Link Qt Insight Tracker library" ON)
#option(BUILD_QDS_COMPONENTS "Build design studio components" ON)

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
)

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

#set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml)
# set(QML_IMPORT_PATH ${QT_QML_OUTPUT_DIRECTORY}
#     CACHE STRING "Import paths for Qt Creator's code model"
#     FORCE
# )


# if (BUILD_QDS_COMPONENTS)
#     include(${CMAKE_CURRENT_SOURCE_DIR}/qmlcomponents)
# endif()

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
# make IDEs aware of the QML import path
# set(QML_IMPORT_PATH ${PROJECT_BINARY_DIR}/qml CACHE PATH
#     "Path to the custom QML components defined by the project")

# if(${CMAKE_CXX_COMPILER} MATCHES ".*/(g\\+\\+)(\\..*)")
#     set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS_RELEASE "-mwindows")
# elseif(${CMAKE_CXX_COMPILER} MATCHES ".*/(cl)(\\..*)")
#     set_target_properties(${PROJECT_NAME} PROPERTIES LINK_FLAGS_RELEASE "/SUBSYSTEM:WINDOWS /ENTRY:mainCRTStartup")
# endif()
# if (ANDROID)
#     include(C:/Users/ld_zh/AppData/Local/Android/Sdk/android_openssl/CMakeLists.txt)
# endif()
