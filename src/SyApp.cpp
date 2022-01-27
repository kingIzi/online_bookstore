#include "SyApp.h"
#include <QTranslator>
#include <QLocale>
#include <QQmlContext>


SyApp::SyApp(int argc, char *argv[]) :
    _app(argc,argv)
{
    if (qEnvironmentVariableIsEmpty("QTGLESSTREAM_DISPLAY")) {
        qputenv("QT_QPA_EGLFS_PHYSICAL_WIDTH", QByteArray("213"));
        qputenv("QT_QPA_EGLFS_PHYSICAL_HEIGHT", QByteArray("120"));

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
        QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    }
    this->setUpTranslationUnit();
}

SyApp::~SyApp()
{

}

void SyApp::init()
{
    this->initializeProperties();
    const QUrl url(this->_qmlMain);
    QObject::connect(&this->_engine, &QQmlApplicationEngine::objectCreated,
                     &this->_app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    this->_engine.load(url);
}

void SyApp::setUpTranslationUnit()
{
    QTranslator translator;
    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString &locale : uiLanguages) {
        const QString baseName = "online_bookstore_" + QLocale(locale).name();
        if (translator.load(":/i18n/" + baseName)) {
            this->_app.installTranslator(&translator);
            break;
        }
    }
}

void SyApp::initializeProperties()
{
    //Registerd Types
    qmlRegisterSingletonType(QUrl(this->_qmlConstants), "Constants", 1, 0, "Constants");

    //Context Properties
    this->_engine.rootContext()->setContextProperty("_requests",&this->_requests);
}

int SyApp::exec()
{
    return this->_app.exec();
}
