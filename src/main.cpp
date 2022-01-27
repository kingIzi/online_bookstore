#include "SyApp.h"

int main(int argc,char* argv[])
{
    SyApp app(argc,argv);
    app.init();
    return app.exec();
}
