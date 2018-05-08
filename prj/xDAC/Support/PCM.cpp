/*

  Extropia System Library test code by Karlos, eXtropia Studios

*/

#include "PCM.hpp"
#include "APP.hpp"
#include <stdlib.h>

char* PCM::rawSig = "Raw16Bit";

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PCM::Free()
{
  if (data)
  {
    MEM::Free(data);
    data = NOTSET;
    biggest = 0;
    //cout << "PCM::Free() : Deallocated OK\n";
  }
  else
    //cout << "PCM::Free() : No data to free\n";
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PCM::New(sint32 size, sint32 chn, sint32 frq)
{
  // System actually only allocates memory when we first request a handle through Data().
  // Delete() leaves the memory allocated, such that subsequent calls to New() just use
  // the same memory over, unless the new size is either bigger or less than half the
  // current largest allocation. This is to help avoid fragmentation. Of course, destroying
  // the object always frees the memory.

  Channels(chn);
  Frequency(frq);
  size*=chn;
  if (size <= 0)
  {
    //cout << "PCM::New(sint32 size) : illegal size\n";
    return ERR_VALUE_MIN;
  }
  if (size > (biggest>>1) && size <= biggest)
  {
    //cout << "PCM::New(sint32 size) : size within biggest/2 - biggest\n";
    numData = size;
    return OK;
  }
  else
  {
    //cout << "PCM::New(sint32 size) : size outside biggest/2 - biggest\n";
    if (data)
      Free();
    numData = size;
    return OK;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PCM::Delete(bool f)
{
  if (f)
    Free();
  numData = 0;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint16* PCM::Data()
{
  // Allocates memory on first call.
  if (numData == 0)
    return NOTSET;
  if (data == NOTSET)
  {
    data = (sint16*)MEM::Alloc(numData*sizeof(sint16));
    if (data)
    {
      //cout << "PCM::Data() : Allocated " << numData <<" samples\n";
      biggest = numData;
    }
    else
    {
      //cout << "PCM::Data() : Allocation failed\n";
      biggest = 0;
    }
  }
  return data;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PCM::LoadRaw16(const char* filename, uint16 freq, sint16 chan)
{
  // Will replace existing buffer if loading sucessfull
  xFILEIO src(filename, xFILEIO::READ);
  if (!src.Valid())
  {
    //cout << "PCM::LoadRaw16() unable to open '" << filename << "'\n";
    return ERR_FILE_OPEN;
  }
  sint32 fileSize = src.Size();
  //cout << "PCM::LoadRaw16() File '" << filename << "' " << fileSize << "bytes\n";

  char sig[10] = {0};

  if (src.Read(sig,1,8)<8)
  {
    //cout << "PCM::LoadRaw16() unable to read '" << filename << "'\n";
    return ERR_FILE_OPEN;
  }
  if (strncmp(sig,rawSig,8))
  {
    //cout << "PCM::LoadRaw16() File '" << filename << "' has bad signature\n";
    return ERR_FILE_OPEN;
  }
  Delete();
  New((fileSize-8)/2);

  void* buf = Data();
  if (!buf)
  {
    //cout << "PCM::LoadRaw16() unable to load '" << filename << "', insufficient memory\n";
    return ERR_NO_FREE_STORE;
  }
  sint32 len = src.Read16(Data(), numData);
  src.Close();

  if (len < numData)
    numData = len;

  Frequency(freq);
  Channels(chan);

  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PCM::SaveRaw16(const char* filename)
{
  xFILEIO dst(filename, xFILEIO::WRITE);
  if (!dst.Valid())
    return ERR_FILE_CREATE;

  if (dst.Write(rawSig,1,8)!=8)
    return ERR_FILE_WRITE;
  void* buf = Data();
  if (dst.Write16(buf, numData)==numData)
    return OK;
  return ERR_FILE_WRITE;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PCM::DeBias()
{
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 PCM::Normalize(float32 level)
{
  return OK;
}




/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
