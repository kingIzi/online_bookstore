#pragma once
#include <memory>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <gtest/gtest.h>

class SyTestSuite : public QObject
{
    Q_OBJECT
public:
    explicit SyTestSuite(QObject * parent = nullptr);
    ~SyTestSuite();
    void foo();
    QNetworkReply * _reply;
    QNetworkAccessManager * _manager = nullptr;
public slots:
    void done();
private:
};

