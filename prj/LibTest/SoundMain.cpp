//*****************************************************************//
//*****************************************************************//

#include "SoundDevice.hpp"

int main(int argc, char** argv)
{
  if (xBASELIB::Init()!=OK)
  {
    puts("Error initialising base library");
    return 10;
  }

  MIXER *myMixer = new MIXER(16384, 44100, 8);

  if (myMixer)
  {
    puts("Chose method\n1 Start()\n2 Stop()\n3 GetDMAPos()\n4 Quit");

    bool quit = false;
    while (!quit)
    {
      switch (getchar())
      {
        case '1':
          if (myMixer->Start()!=OK)
            puts("Couldn't Start()");
          break;

        case '2':
          if (myMixer->Stop()!=OK)
            puts("Couldn't Stop()");
          break;

        case '3':
          printf("pos = %lu\n", myMixer->GetDMAPos());
          break;

        case '4':
          quit = true;
          break;
        default:
          break;
      }
    }
    delete myMixer;
  }

  xBASELIB::Done();
  return 0;
}