#include <gtest/gtest.h>
#include <gmock/gmock-matchers.h>
#include <QFuture>
#include <QFutureWatcher>
#include <QtConcurrent>
#include <QDebug>
#include <QSignalSpy>
#include "SyTestSuite.h"

using namespace testing;

TEST(authentication, authentication)
{
    SyTestSuite suite;
    QFutureWatcher<int> watcher;
    suite._reply = suite._manager->get(QNetworkRequest(QUrl("https://randomuser.me/api/")));
    auto future = QtFuture::connect(suite._reply,&QNetworkReply::readyRead).then([]{
        return 42;
    });
    watcher.setFuture(future);
    qDebug() << "DATA" << watcher.result();
}

