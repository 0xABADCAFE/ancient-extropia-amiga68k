/*

*/

#include <xBase.hpp>
#include <xSystem/ServiceLib.hpp>

extern "C" void Normalize(REGI(0) sint16* v, REGI(1) sint32 num);

uint32 funky = 0x12345678;

void Normalize68K(sint16 *p, sint32 num);
/*
class DUMMY {
	protected:
		sint16 w, h, d, f;
	public:
		virtual sint16 Width()	{ return w; }
		virtual sint16 Height() { return h; }
		virtual sint16 Depth()	{ return d; }
		virtual sint16 Format() { return f; }
		DUMMY() : w(0), h(0), d(0), f(0) {}
		DUMMY(sint16 nw, sint16 nh, sint16 nd, sint16 nf) : w(nw), h(nh), d(nd), f(nf) {}
		virtual ~DUMMY() {}
};

class DUMMYKID : public DUMMY {

	private:
		sint32 x;
		virtual sint16 Width()	{ return x*w; }
		virtual sint16 Height() { return x*h; }
		virtual sint16 Depth()	{ return x*d; }
		virtual sint16 Format() { return x*f; }
	public:
		DUMMYKID() : DUMMY(), x(0) {}
		~DUMMYKID() {}
};
*/
int main()
{
	if (xBASELIB::Init()!=OK)
	{
		puts("Base Library initialization failed");
		return 10;
	}

	if (!sysBASELIB::PPCAvailable())
	{
		puts("PowerPC not available");
		xBASELIB::Done();
		return 10;
	}
	sint16* p = (sint16*)MEM::Alloc(1024*1024*sizeof(sint16), false, true);

	if (p)
	{
		MILLICLOCK t;
		sint32 time68k, timePPC;
		printf("Testing 68K...\n");
		t.Set();
		Normalize68K(p,1024*1024);
		time68k = t.Elapsed();
		printf("Took %ld ms\nTesting PPC...\n", time68k);
		t.Set();
		Normalize(p,1024*1024);
		timePPC = t.Elapsed();
		printf("Took %ld ms, gain %5.2lf\n", timePPC, (float64)time68k/(float64)timePPC);
		MEM::Free(p);
	}
	else
		puts("Allocation failed");

	xBASELIB::Done();
	return 0;
}

void Normalize68K(sint16 *p, sint32 num)
{
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
