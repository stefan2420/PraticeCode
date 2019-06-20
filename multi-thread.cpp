// 18-05-2019 Matthijs Reyers
// 
// Mingw64 compiler args:
// -std=gnu++11
// 
// g++ .\multi-thread.cpp -std=gnu++11 -o .\multi-thread.exe

#include <iostream>
#include <thread>

void hello_world()
{
    std::cout << "Hello from thread!\n";
}

int main()
{
    std::thread threadobj1(hello_world);
    std::thread threadobj2(hello_world);
    threadobj1.join();
    threadobj2.join();
    return 0;
}
