//*****************************************************************//
//*****************************************************************//

#include "SoundDevice.hpp"

#include <math.h>

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

MIXER::MIXER(size_t bs, uint32 f, uint8 ch) : THREAD(), flags(0)
{
  bufferSize = ((bs>>8) + (bs&0x000000FF ? 1:0))<<8;
  mix = (sint32*)MEM::Alloc(bufferSize*2*sizeof(sint32), true, false);
  out = (sint16*)MEM::Alloc(bufferSize*2*sizeof(sint16), true, false);
  freq = Clamp(f, 4800, 48000);
  maxCh = Clamp(ch, 1, 16);

  static char fName[128];
  sprintf(fName,"CON:64/64/320/128/%s/INACTIVE/PLAIN/CLOSE/WAIT/AUTO", Name());
  debugOut = fopen(fName, "w");
  if (!debugOut)
    return;
  fprintf(debugOut, "MIXER : %hu Hz, %hu chan, %lu samp\n", freq, maxCh, bufferSize);
  fflush(debugOut);

  float64 x = (256.0*PI) / (float64)(bufferSize<<1);
  float64 p = (2.0*PI) / (float64)(bufferSize<<1);
  for (sint32 i = 0; i < (bufferSize<<1); i+=2)
  {
    out[i] = (sint16)(8192.0 * (sin(x*(float64)i)*(1.0+sin(p*(float64)i))));
    out[i+1] = (sint16)(8192.0 * (cos(x*(float64)i)*(1.0-sin(p*(float64)i))));
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

MIXER::~MIXER()
{
  Stop();
  if (mix)
    MEM::Free(mix);
  if (out)
    MEM::Free(out);
  if (debugOut)
  {
    fclose(debugOut);
    debugOut = 0;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
    MsgPort*    soundPort;
    union {
      IORequest*      soundIO;
      AHIRequest*     soundReq;
    };
    sysSIGNAL         soundSignal;
*/
bool MIXER::OpenHardware()
{
  flags = 0;
  if (!(soundPort = ::CreateMsgPort()))
  {
    flags |= PORT_FAIL;
    goto Error;
  }
  soundSignal = 1<<soundPort->mp_SigBit;
  if (!(soundIO[0].ahi = (AHIRequest*)::CreateIORequest(soundPort, sizeof(AHIRequest))))
  {
    flags |= IORQ_FAIL;
    goto Error;
  }
  soundIO[0].ahi->ahir_Version = 4;
  if (::OpenDevice(AHINAME, AHI_DEFAULT_UNIT, soundIO[0].io, 0)!=0)
  {
    flags |= OPDV_FAIL;
    goto Error;
  }
/*
  soundIO[1].ahi = (AHIRequest*)MEM::Alloc(sizeof(AHIRequest),false,false);
  if (!soundIO[1].ahi)
  {
    goto Error;
  }
  MEM::Copy(soundIO[0].ahi, soundIO[1].ahi, sizeof(AHIRequest));
*/
  if (debugOut);
  {
    fprintf(debugOut, "Sound hardware opened\n");
    fflush(debugOut);
  }
  return TRUE;

Error:
  if (debugOut);
  {
    fprintf(debugOut, "Couldn't open sound hardware\n");
    fflush(debugOut);
  }
  CloseHardware();
  return FALSE;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void MIXER::CloseHardware()
{
  if (soundIO[0].io)
  {
    if (flags & IORQ_USED)
    {
      ::AbortIO(soundIO[0].io);
      ::WaitIO(soundIO[0].io);
      ::SetSignal(0, soundSignal);
    }
    ::CloseDevice(soundIO[0].io);
    ::DeleteIORequest(soundIO[0].io);
    soundIO[0].io = 0;
  }
  if (soundPort)
  {
    ::DeleteMsgPort(soundPort);
    soundPort = 0;
  }
  soundSignal = 0;
/*
  if (soundIO[1].io)
  {
    MEM::Free(soundIO[1].io);
    soundIO[1].io = 0;
  }
*/
  if (debugOut);
  {
    fprintf(debugOut, "Sound hardware closed\n");
    fflush(debugOut);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 MIXER::Run()
{
  if (!OpenHardware())
  {
    return -1;
  }
  sint32 i=0;

  while (!ShutDown())
  {
    soundIO[0].std->io_Command                = CMD_WRITE;
    soundIO[0].std->io_Message.mn_Node.ln_Pri = 0;
    soundIO[0].std->io_Length                 = bufferSize*2*sizeof(sint16);
    soundIO[0].std->io_Data                   = out;
    soundIO[0].ahi->ahir_Type                 = AHIST_S16S;
    soundIO[0].ahi->ahir_Frequency            = freq;
    soundIO[0].ahi->ahir_Link                 = 0;
    soundIO[0].ahi->ahir_Volume               = 0x00010000;
    soundIO[0].ahi->ahir_Position             = 0x00008000;
    ::SendIO(soundIO[0].io);
/*
    flags |= IORQ_USED;
    if (debugOut)
    {
      fprintf(debugOut, "\rSent packet %ld", i);
      fflush(debugOut);
    }
*/
    ::WaitIO(soundIO[0].io);
    ++i;
  }
  if (debugOut)
  {
    fprintf(debugOut, "\n\nWrote %ld packets\n", i);
    fflush(debugOut);
  }
  CloseHardware();
  return i;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void MIXER::Mix()
{
/*
  soundIO[currBuf].std->io_Command                  = CMD_WRITE;
  soundIO[currBuf].std->io_Message.mn_Node.ln_Pri = 0;
  soundIO[currBuf].std->io_Length                 = bufferSize*2*sizeof(sint16);
  soundIO[currBuf].std->io_Data                   = out;
  soundIO[currBuf].ahi->ahir_Type                 = AHIST_S16S;
  soundIO[currBuf].ahi->ahir_Frequency              = freq;
  soundIO[currBuf].ahi->ahir_Link                 = 0;
  soundIO[currBuf].ahi->ahir_Volume               = 0x00010000;
  soundIO[currBuf].ahi->ahir_Position             = 0x00008000;
  ::SendIO(soundIO[currBuf].io);
  flags |= IORQ_USED;
  if (debugOut)
  {
    fprintf(debugOut, "Sent packet\n");
    fflush(debugOut);
  }
  ::WaitIO(soundIO[currBuf].io);
*/
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void MIXER::Play(DUMMYSOUND* s)
{

}

size_t MIXER::GetDMAPos()
{
  if (Started())
    return ((soundIO[0].std->io_Actual)>>1)&0xFFFFFFFE;
  return 0;
}

/*
void Test()
{
  // create some sounds
  DUMMYSOUND* sounds[NUMSOUNDS];
  {
    for (sint32 i=0; i<NUMSOUNDS; i++)
    {
      if(!(sounds[i] = NewSound(1024)))
        goto QuickExit;
      sounds[i]->vol = (256*rand())/RAND_MAX;
    }
  }

  {
    // create output buffer
    sint32 *mix = new sint32[MIXBUFLEN];
    sint16 *out = new sint16[MIXBUFLEN];
    if (mix && out)
    {
      printf("Mixing : %ld sounds, buffer size %lu\n", NUMSOUNDS, MIXBUFLEN);
      MILLICLOCK timer;
      uint32 millis = 0;
      for (sint32 i=0; i<MIXREPEAT; i++)
      {
        timer.Set();
        // clear the mix buffer
        MEM::Zero32((uint32*)mix, MIXBUFLEN);
        // mix a packet from each sound
        for (sint32 s=0; s<NUMSOUNDS; s++)
        {
          rsint16*  from = &(sounds[s]->data[sounds[s]->pos]);
          rsint16   vol = sounds[s]->vol;
          if (sounds[s]->pos < (sounds[s]->len + MIXBUFLEN))
            sounds[s]->pos += MIXBUFLEN;
          else
            sounds[s]->pos = 0;
          rsint32* to = mix;
          for (rsint32 p=0; p<MIXBUFLEN; p+=16)
          {
            *(to++) += ((*from++)*vol);
            *(to++) += ((*from++)*vol);
            *(to++) += ((*from++)*vol);
            *(to++) += ((*from++)*vol);
            *(to++) += ((*from++)*vol);
            *(to++) += ((*from++)*vol);
            *(to++) += ((*from++)*vol);
            *(to++) += ((*from++)*vol);
            *(to++) += ((*from++)*vol);
            *(to++) += ((*from++)*vol);
            *(to++) += ((*from++)*vol);
            *(to++) += ((*from++)*vol);
            *(to++) += ((*from++)*vol);
            *(to++) += ((*from++)*vol);
            *(to++) += ((*from++)*vol);
            *(to++) += ((*from++)*vol);
          }
        }
        // copy mix buffer to out buffer

        for (sint32 p=0; p<MIXBUFLEN; p++)
        {
          out[p] = mix[p]>>SCALELEV;
        }
        millis += timer.Elapsed();
      }
      printf("Took %lf milliseconds\n", (double)millis/(double)MIXREPEAT);
    }
    if (mix)
      delete[] mix;
    if (out)
      delete[] out;
  }
  // free sounds
  QuickExit:
  {
    for (sint32 i=0; i<NUMSOUNDS; i++)
    {
      DelSound(sounds[i]);
      sounds[i]=0;
    }
  }
}
*/
