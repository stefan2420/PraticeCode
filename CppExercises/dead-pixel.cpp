// 08-05-2019 Matthijs Reyers
// 
// https://docs.microsoft.com/en-us/windows/desktop/api/wingdi/nf-wingdi-rgb
// https://docs.microsoft.com/en-us/windows/desktop/api/wingdi/nf-wingdi-setpixel
//
// Mingw64 compiler args:
// -lgdi32 -mwindows
// 
// g++ .\dead-pixel.cpp -o .\DeadPixel.exe -lgdi32 -mwindows

#include <Windows.h>
#include <cstdlib>
#include <cstdio>

void SpawnPix(COLORREF colour)
{
    int x = rand() % 1920;
    int y = rand() % 1080;
    SetPixel(GetDC(NULL),x,y,colour);
}

int main(int argc, char* argv[])
{
    COLORREF red = RGB(255,0,0);
    
    while (true)
    {
        SpawnPix(red);
        Sleep(350);
    }
    return 1;
}
