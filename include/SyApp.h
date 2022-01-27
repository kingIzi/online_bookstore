#pragma once
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "SyRequests.h"

//Class initializer
class SyApp
{
public:
    SyApp(int argc, char *argv[]);
    ~SyApp();
    void init();
    int exec();
private:
    void setUpTranslationUnit();
    void initializeProperties();
private:
    QGuiApplication _app;
    QQmlApplicationEngine _engine;
    SyRequests _requests;
    const char* _qmlMain = "qrc:/main.qml";
    const char* _qmlConstants = "qrc:/Constants.qml";
};

