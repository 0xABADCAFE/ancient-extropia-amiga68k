//*****************************************************************//
//** Description:   OS Layer classes, AmigaOS/68K version        **//
//** First Started: 2001-03-08                                   **//
//** Last Updated:  2001-21-08                                   **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include <xSystem/xAudio.hpp>

#define XAUDIO_UNIT 0 // Lame lame lame!

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LIBRARY     *AHIBase = 0; // Sound Card extensions

MsgPort*    xAUDIO::AHIport = 0;
AHIRequest* xAUDIO::AHImain = 0;
uint32      xAUDIO::flags   = 0;

sint32 xAUDIO::Init()
{
  if (!(AHIport = CreateMsgPort()))
  {
    flags |= PORT_ERR;
    Done();
    return ERR_RSC_UNAVAILABLE;
  }

  if (!(AHImain = (AHIRequest*)CreateIORequest(AHIport, sizeof(AHIRequest))))
  {
    flags |= IOREQ_ERR;
    Done();
    return ERR_RSC_UNAVAILABLE;
  }

  AHImain->ahir_Version = 4;

  if (OpenDevice(AHINAME, AHI_NO_UNIT, (IORequest*)AHImain, 0)!=OK)
  {
    flags |= DEVICE_ERR;
    Done();
    return ERR_RSC_UNAVAILABLE;
  }
  AHIBase = (LIBRARY*) AHImain->ahir_Std.io_Device;
  //cout << "xAUDIO opened OK\n";
  #ifdef X_VERBOSE
  cerr << "xAUDIO Debug build : " __DATE__ " at " __TIME__ "\n";
  #endif
  return OK;
}

sint32 xAUDIO::Done()
{
  if (flags & AUDIO_ERR)
  {
    #ifdef X_VERBOSE
    cerr << "xAUDIO initialisation failed - ";
    #endif
  }
  else
  {
/*
    cout << "xAUDIO shutting down sound system - ";
    if (!CheckIO((IORequest*)AHImain))
    {
      AbortIO((IORequest*)AHImain);
    }
    WaitIO((IORequest*)AHImain);

    cout << "done\n";
*/
  }

  if (flags & DEVICE_ERR)
  {
    flags &= ~DEVICE_ERR;
    #ifdef X_VERBOSE
    cerr << "AHI device not opened\n";
    #endif
  }
  else
    CloseDevice((IORequest*)AHImain);

  if (flags & IOREQ_ERR)
  {
    flags &= ~IOREQ_ERR;
    #ifdef X_VERBOSE
    cerr << "AHI primary IO request failed\n";
    #endif
  }
  else
  {
    DeleteIORequest((IORequest*)AHImain);
    AHImain = 0;
  }

  if (flags & PORT_ERR)
  {
    flags &= ~PORT_ERR;
    #ifdef X_VERBOSE
    cerr << "message port not opened\n";
    #endif
  }
  else
  {
    DeleteMsgPort(AHIport);
    AHIport = 0;
  }
  //cout << "xAUDIO closed OK\n";
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
