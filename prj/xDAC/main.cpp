/*

  Extropia System Library test code by Karlos, eXtropia Studios

*/

#include <xBase.hpp>
#include "APP.hpp"

#include <stdlib.h>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

char* GetCLIParm(int argc, char** argv, const char* arg);
bool GetCLISwitch(int argc, char** argv, const char* arg);

int main(int argc, char* argv[])
{
  if (xBASELIB::Init()!=OK)
    return 10;

  char*   aiffName = GetCLIParm(argc, argv, "-snd");
  char*   xDacName  = GetCLIParm(argc, argv, "-xdac");
  char*   fsize = GetCLIParm(argc, argv, "-fsize");
  char*   brate = GetCLIParm(argc, argv, "-brate");
  bool    fast  = GetCLISwitch(argc, argv, "-fast");

  sint32 frameSize = (fsize) ? Clamp(atoi(fsize), 64, 1024) : 256;
  sint32 bitRate = (brate) ? Clamp(atoi(brate), 2, 5) : 4;

  if (!aiffName)
    sysBASELIB::MessageBox("Message", "OK", "No file specified\n use xDAC -snd <name> -xdac <name> -fsize <frame size> -brate <bit rate> [-fast]");
  else
  {
    if (APP::Init(aiffName, xDacName, frameSize, bitRate, fast)==OK)
    {
      while (APP::viewWindow.IsRunning())
      {
        while (APP::viewWindow.InputQueued())
          APP::viewWindow.Refresh();
        APP::viewWindow.Idle();
      }
      sysBASELIB::MessageBox("Message", "OK", "Finished");
      APP::Done();
    }
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
      return TRUE;
  }
  return FALSE;
}