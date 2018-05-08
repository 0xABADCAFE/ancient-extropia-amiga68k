/*

	Extropia System Library test code by Karlos, eXtropia Studios

*/

#include "xDac.hpp"
#include "SoundFormats.hpp"
#include <stdlib.h>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

char* GetCLIParm(int argc, char** argv, const char* arg);
bool GetCLISwitch(int argc, char** argv, const char* arg);

int main(int argc, char* argv[])
{
	if (xBASELIB::Init()!=OK)
	{
		puts("Fatal error initialising");
		return 10;
	}

	char*		aiffName	= GetCLIParm(argc, argv, "-snd");
	char*		fsize			= GetCLIParm(argc, argv, "-fsize");
	char*		brate			= GetCLIParm(argc, argv, "-brate");
	char*		xDacName	= GetCLIParm(argc, argv, "-xdac");
	bool		encode		= GetCLISwitch(argc, argv, "-encode");

	sint32 frameSize = (fsize) ? Clamp(atoi(fsize), 64, 1024) : 256;
	sint32 bitRate = (brate) ? Clamp(atoi(brate), 2, 5) : 4;

	if (!aiffName || ! xDacName)
		puts("Usage : codec -xdac <name> -snd <name> [-encode [-fsize <frame size>] [-brate <bit rate>]]");
	else
	{
		AIFF			wave;
		XDACCODEC	xdac;
		if (encode)
		{
			puts("Encode PCM to xDAC");
			if (wave.Load(aiffName)==OK)
			{
				if (xdac.Set(wave, frameSize, bitRate)==OK)
				{
					if (xdac.Encode(xDacName, wave)==OK)
						puts("Encode complete");
					else
						puts("Error encoding");
				}
				else
					puts("Unable to initialise frame");
			}
			else
				puts("Unable to load source pcm file");
		}
		else
		{
			puts("Decode xDAC to PCM");
			if (xdac.Decode(xDacName, wave)==OK)
			{
				printf("Decode complete\nWriting AIFF...");
				wave.Save(aiffName);
				puts("done");
			}
			else
				puts("Error decoding");
		}
		wave.Delete();
		xdac.Delete();
	}

	xBASELIB::Done();
	return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////

char* GetCLIParm(int argc, char** argv, const char* arg)
{
	for (int i=0; i<argc; i++)
	{
		if (0 == stricmp(argv[i], arg))
			if (++i<argc)
				return argv[i];
	}
	return 0;
}

bool GetCLISwitch(int argc, char** argv, const char* arg)
{
	for (int i=0; i<argc; i++)
	{
		if (0 == stricmp(argv[i], arg))
			return true;
	}
	return false;
}