// 08-05-2019 Matthijs Reyers
// 
// https://docs.microsoft.com/en-us/windows/desktop/api/wingdi/nf-wingdi-rgb
// https://docs.microsoft.com/en-us/windows/desktop/api/wingdi/nf-wingdi-setpixel
//
// GCC compiler args:
// -lgdi32 -mwindows
// 
// gcc .\DeadPixel.cpp -o .\DeadPixel.exe -lgdi32 -mwindows

#include <Windows.h>
#include <cstdlib>
#include <cstdio>

void SpawnPix(COLORREF colour)
{
    int x = rand() % 1920;
    int y = rand() % 1080;
    SetPixel(GetDC(NULL),x,y,colour);
    Sleep(350);
}

int main(int argc, char* argv[])
{
    COLORREF pink = RGB(255,165,210);
    COLORREF red = RGB(255,0,0);
    COLORREF blue = RGB(0,255,0);
    COLORREF green = RGB(0,0,255);
    COLORREF white = RGB(255,255,255);
    COLORREF black = RGB(0,0,0);
    while (true)
    {
        SpawnPix(red);
        SpawnPix(blue);
        SpawnPix(green);
        SpawnPix(white);
        SpawnPix(black);
    }
    return 1;
}
