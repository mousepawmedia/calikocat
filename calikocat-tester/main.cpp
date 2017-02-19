#include <calikocat/dummy.hpp>
#include <pawlib/iochannel.hpp>

int main()
{
    //pawlib::ioc << "Hello, world!" << pawlib::io_end;
    Dummy::speak();

    return 0;
}
