//*****************************************************************//
//** Description:   OS Layer classes, AmigaOS/68K version        **//
//** First Started: 2001-03-08                                   **//
//** Last Updated:  2001-21-08                                   **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2001, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#include <xSystem/GraphicsLibOld.hpp>

#include <math.h>
#include <stdio.h>

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Class xDRAW
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LIBRARY				*DiskfontBase = 0;

TextAttr			xDRAW::fontInfo[] = {
	{"XCourier.font",		13, 0, 0},
	{"XHelvetica.font",	13, 0, FPF_PROPORTIONAL},
	{"XHelvetica.font",	13, 0, FPF_PROPORTIONAL},
	{"times.font",			13, 0, FPF_PROPORTIONAL}
};

TextFont*			xDRAW::fontData[] = {0,0,0,0};

uint32				xDRAW::flags			= 0;
uint32				xDRAW::flushCnt		= 0;
sysVERTEX*		xDRAW::vArray			= 0;
sysVERTEX*		xDRAW::vBuffer		= 0;
uint32				xDRAW::fault			= 0;
sint32				xDRAW::vBufPos		= 0;
uint32				xDRAW::vArraySize	= 0;
float64				xDRAW::zDepth			= 1.0;
sint32				xDRAW::maxVBufPos = 0;
uint32				xDRAW::currentCol = 0xFF000000;

// 64 bit aligned data

uint32 xDRAW::cTab[256] = {
	0x00000000, 0x3b800000, 0x3c000000, 0x3c400000, 0x3c800000, 0x3ca00000, 0x3cc00000, 0x3ce00000,
	0x3d000000, 0x3d100000, 0x3d200000, 0x3d300000, 0x3d400000, 0x3d500000, 0x3d600000, 0x3d700000,
	0x3d800000, 0x3d880000, 0x3d900000, 0x3d980000, 0x3da00000, 0x3da80000, 0x3db00000, 0x3db80000,
	0x3dc00000, 0x3dc80000, 0x3dd00000, 0x3dd80000, 0x3de00000, 0x3de80000, 0x3df00000, 0x3df80000,
	0x3e000000, 0x3e040000, 0x3e080000, 0x3e0c0000, 0x3e100000, 0x3e140000, 0x3e180000, 0x3e1c0000,
	0x3e200000, 0x3e240000, 0x3e280000, 0x3e2c0000, 0x3e300000, 0x3e340000, 0x3e380000, 0x3e3c0000,
	0x3e400000, 0x3e440000, 0x3e480000, 0x3e4c0000, 0x3e500000, 0x3e540000, 0x3e580000, 0x3e5c0000,
	0x3e600000, 0x3e640000, 0x3e680000, 0x3e6c0000, 0x3e700000, 0x3e740000, 0x3e780000, 0x3e7c0000,
	0x3e800000, 0x3e820000, 0x3e840000, 0x3e860000, 0x3e880000, 0x3e8a0000, 0x3e8c0000, 0x3e8e0000,
	0x3e900000, 0x3e920000, 0x3e940000, 0x3e960000, 0x3e980000, 0x3e9a0000, 0x3e9c0000, 0x3e9e0000,
	0x3ea00000, 0x3ea20000, 0x3ea40000, 0x3ea60000, 0x3ea80000, 0x3eaa0000, 0x3eac0000, 0x3eae0000,
	0x3eb00000, 0x3eb20000, 0x3eb40000, 0x3eb60000, 0x3eb80000, 0x3eba0000, 0x3ebc0000, 0x3ebe0000,
	0x3ec00000, 0x3ec20000, 0x3ec40000, 0x3ec60000, 0x3ec80000, 0x3eca0000, 0x3ecc0000, 0x3ece0000,
	0x3ed00000, 0x3ed20000, 0x3ed40000, 0x3ed60000, 0x3ed80000, 0x3eda0000, 0x3edc0000, 0x3ede0000,
	0x3ee00000, 0x3ee20000, 0x3ee40000, 0x3ee60000, 0x3ee80000, 0x3eea0000, 0x3eec0000, 0x3eee0000,
	0x3ef00000, 0x3ef20000, 0x3ef40000, 0x3ef60000, 0x3ef80000, 0x3efa0000, 0x3efc0000, 0x3efe0000,
	0x3f000000, 0x3f010000, 0x3f020000, 0x3f030000, 0x3f040000, 0x3f050000, 0x3f060000, 0x3f070000,
	0x3f080000, 0x3f090000, 0x3f0a0000, 0x3f0b0000, 0x3f0c0000, 0x3f0d0000, 0x3f0e0000, 0x3f0f0000,
	0x3f100000, 0x3f110000, 0x3f120000, 0x3f130000, 0x3f140000, 0x3f150000, 0x3f160000, 0x3f170000,
	0x3f180000, 0x3f190000, 0x3f1a0000, 0x3f1b0000, 0x3f1c0000, 0x3f1d0000, 0x3f1e0000, 0x3f1f0000,
	0x3f200000, 0x3f210000, 0x3f220000, 0x3f230000, 0x3f240000, 0x3f250000, 0x3f260000, 0x3f270000,
	0x3f280000, 0x3f290000, 0x3f2a0000, 0x3f2b0000, 0x3f2c0000, 0x3f2d0000, 0x3f2e0000, 0x3f2f0000,
	0x3f300000, 0x3f310000, 0x3f320000, 0x3f330000, 0x3f340000, 0x3f350000, 0x3f360000, 0x3f370000,
	0x3f380000, 0x3f390000, 0x3f3a0000, 0x3f3b0000, 0x3f3c0000, 0x3f3d0000, 0x3f3e0000, 0x3f3f0000,
	0x3f400000, 0x3f410000, 0x3f420000, 0x3f430000, 0x3f440000, 0x3f450000, 0x3f460000, 0x3f470000,
	0x3f480000, 0x3f490000, 0x3f4a0000, 0x3f4b0000, 0x3f4c0000, 0x3f4d0000, 0x3f4e0000, 0x3f4f0000,
	0x3f500000, 0x3f510000, 0x3f520000, 0x3f530000, 0x3f540000, 0x3f550000, 0x3f560000, 0x3f570000,
	0x3f580000, 0x3f590000, 0x3f5a0000, 0x3f5b0000, 0x3f5c0000, 0x3f5d0000, 0x3f5e0000, 0x3f5f0000,
	0x3f600000, 0x3f610000, 0x3f620000, 0x3f630000, 0x3f640000, 0x3f650000, 0x3f660000, 0x3f670000,
	0x3f680000, 0x3f690000, 0x3f6a0000, 0x3f6b0000, 0x3f6c0000, 0x3f6d0000, 0x3f6e0000, 0x3f6f0000,
	0x3f700000, 0x3f710000, 0x3f720000, 0x3f730000, 0x3f740000, 0x3f750000, 0x3f760000, 0x3f770000,
	0x3f780000, 0x3f790000, 0x3f7a0000, 0x3f7b0000, 0x3f7c0000, 0x3f7d0000, 0x3f7e0000, 0x3f7f0000
};

float32 xDRAW::sTab[XDRAW_TRIGSIZE+2] = { 0 };
sint32	xDRAW::nestCount = 0;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xDRAW::Init(uint32 vSize)
{
	if (!DiskfontBase)
	{
		if (!(DiskfontBase = OpenLibrary("diskfont.library", 39)))
		{
			#ifdef X_VERBOSE
			sysBASELIB::MessageBox("Debug Info", "Proceed", "xDRAW::Init()\nFailed to open diskfont.library");
			#endif
			return ERR_RSC_UNAVAILABLE;
		}
	}

	{
		fontData[0] = OpenDiskFont(fontInfo);
		fontData[1] = OpenDiskFont(fontInfo+1);
		fontData[2] = OpenDiskFont(fontInfo+2);
		fontData[3] = OpenDiskFont(fontInfo+3);
	}

	vArraySize = ClipInt(vSize, 1024, 65536);
	// Generate sine table for quadrics.
	// This is taken straight from xNUM, we have XDRAW_TRIGSIZE+2 data points covering range 0 - PI/4 inclusive [0 - XDRAW_TRIGSIZE]
	// plus one extra point for interpolation wrap around [XDRAW_DATASIZE+1]
	for (sint32 i = 0; i < XDRAW_TRIGSIZE; i++)
		sTab[i] = sin(((float64)i*3.1415926536)/(2*XDRAW_TRIGSIZE));
	sTab[XDRAW_TRIGSIZE]		= 1.0;
	sTab[XDRAW_TRIGSIZE+1]	= sTab[XDRAW_TRIGSIZE-1];

	vBuffer = New(vBuffer, vArraySize);
	if (vBuffer==0)
		return ERR_NO_FREE_STORE;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xDRAW::Done()
{
	// change to release all the dynamically allocated crap
	FreeContext();

	if (vBuffer)
		Delete(vBuffer);
	vBuffer = 0;
	if (DiskfontBase)
	{
		for (sint32 i=0; i < 4; i++)
			if (fontData[i]) CloseFont(fontData[i]);
		CloseLibrary(DiskfontBase);
		DiskfontBase = 0;
	}
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xDRAW::AllocDepthBuffer()
{
	if (flags & ZBUFFER)
		return OK;
	if (x3D::Context())
	{
		uint32 r = W3D_AllocZBuffer(x3D::Context());
		switch(r)
		{
			case W3D_SUCCESS:		flags |= ZBUFFER; return OK; break;
			case W3D_NOGFXMEM:	return ERR_NO_FREE_STORE; break;
			case W3D_NOZBUFFER:	return ERR_RSC_UNAVAILABLE; break;
			default:						return ERR_RSC_INVALID; break;
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xDRAW::FreeDepthBuffer()
{
	if (flags & ZBUFFER)
	{
		flags &= ~ZBUFFER;
		if (x3D::Context())
		{
			uint32 r = W3D_FreeZBuffer(x3D::Context());
			switch(r)
			{
				case W3D_SUCCESS:		return OK; break;
				case W3D_NOZBUFFER:	return ERR_RSC_UNAVAILABLE; break;
				default:						return ERR_RSC_INVALID; break;
			}
		}
	}
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xDRAW::Bind(xSURFACE* s)
{
	if (x3D::Context())
	{
		if (!x3D::DrawSurface() || x3D::DrawSurface()->Format()==s->Format())
		{	// quickly switch from surface of same pixel type
			W3D_Flush(x3D::Context());
			x3D::SetDrawArea(s, 0, 0, s->Width(), s->Height());
			return OK;
		}
		else
		{ // free this context and attempt to build new one (slow)
			FreeContext();
			if (BuildContext(s,true)==OK)
				return OK;
			else
				return ERR_RSC_UNAVAILABLE;
		}
	}
	else
	{ // create context from scratch
		if (BuildContext(s, true)==OK)
			return OK;
		else
			return ERR_RSC_UNAVAILABLE;
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sint32 xDRAW::Release()
{
	if (x3D::Context())
	{
		if (x3D::DrawSurface())
			W3D_Flush(x3D::Context());
		W3D_FreeAllTexObj(x3D::Context());
		x3D::FreeDrawArea();
	}
	#ifdef X_VERBOSE
	sysBASELIB::MessageBox("Debug Info","Proceed","xDRAW::Release()\nPeak vertex count %d\nVertex buffer flushed %d times", maxVBufPos, flushCnt);
	#endif
	flushCnt = maxVBufPos = 0;
	return OK;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#ifdef X_VERBOSE
void xDRAW::Dump(ostream& out, sint32 s, sint32 r)
{
	for (sint32 i = s; i < s+r; i++)
	{
		out << "vBuffer[" << i << "] : X,Y,Z = " << vBuffer[i].x << ", " << vBuffer[i].y << ", " << vBuffer[i].z	\
				 << ", R,G,B,A = " << vBuffer[i].color.r << ", " << vBuffer[i].color.g << ", "<< vBuffer[i].color.b 	\
				 << ", " << vBuffer[i].color.a << "\n";
	}
}
#endif
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void xDRAW::SimpleText(ICOORD2D c, uint32 font, char* text,...)
{
	static char textBuffer[256];
	if (!x3D::DrawSurface() || !x3D::DrawSurface()->rPort || !text)
		return;
	va_list arglist;
	va_start(arglist,text);
	sint32 n = vsprintf(textBuffer,text,arglist);
	va_end(arglist);

	if (n<0)
		return;
	::SetFont(x3D::DrawSurface()->rPort, fontData[font]);
	::Move(x3D::DrawSurface()->rPort, CoordX(c), CoordY(c));
	::Text(x3D::DrawSurface()->rPort, textBuffer, n);
}
