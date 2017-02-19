#include "calikocat/dummy.hpp"

void Dummy::speak()
{
    pawlib::ioc << "Hello, world!" << pawlib::io_end;
}
