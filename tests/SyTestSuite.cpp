#include "SyTestSuite.h"
#include <QFuture>

SyTestSuite::SyTestSuite(QObject * parent) :
    QObject(parent)
{
    this->_manager = new QNetworkAccessManager(this);
}

SyTestSuite::~SyTestSuite()
{
    this->_manager->deleteLater();
    this->_reply->deleteLater();
}

void SyTestSuite::foo()
{
    qDebug() << this->_reply->readAll();
}

void SyTestSuite::done()
{

}
