/*

	Compile this file using vbcc/warpos
	Requires C99 extensions enabled

*/
#include <xdefs.h>
#include <clib/powerpc_protos.h>

extern struct Library* PowerPCBase;

#pragma amiga-align

extern uint32 funky;

#pragma natural-align

void NormalizePPC(sint16 *p, sint32 num)
{
	if (funky!=0x12345678)
		return;
	rsint32 peak = 0;
	rsint32 i;
	rsint16 *t;
	for (t=p, i=0; i<num; i++)
	{
		rsint16 tmp = *t++;
		if ((tmp<(-peak)) || (tmp>peak))
			peak = tmp;
	}
	if (peak)
	{
		rfloat32 factor = 32768.0 / (float32)((peak<0) ? -peak : peak);
		for (t=p, i=0; i<num; i++, t++)
			*t = (sint16)((float32)(*t) * factor);
	}
}

uint32 magic = 0xCAFEBABE;
void* codePPC = (void*)&NormalizePPC;

#pragma default-align