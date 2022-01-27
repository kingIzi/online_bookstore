#include <gtest/gtest.h>
#include <QGuiApplication>
#include "SyApp.h"

int main(int argc, char *argv[])
{
    SyApp app(argc,argv);
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
