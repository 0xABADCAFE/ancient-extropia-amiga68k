//****************************************************************************//
//** File:         xNumericOptimize.cpp ($NAME=xNumericOptimize.cpp)        **//
//** Description:  eXtropia Library Base API Source                         **//
//** Comment(s):   Skeleton to generate XNUM_HAND_OPTIMIZED code            **//
//** Library:      xUtility                                                 **//
//** Created:      2001-02-20                                               **//
//** Updated:      2001-02-26                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2001, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//****************************************************************************//


// Compile this file normally then hand optimize the assembly output
//
// Optimization guidelines
//
// 1) return result in same register used to pass arg (fp0)
// 2) use only volatile registers to avoid main stack (d0/d1/a0/a1/fp0/fp1)
// 3) Remove all local stack frame code where possible (eliminate link/ulnk a5)
// 4) Avoid all Motorola fpsp operations, use only machine supported instructions
//    which limits us to the subset supported on the 68040/68060

#include <xUtility/xNumeric.hpp>

float32 xNUM::Sin(REGF(0) float32 x)
{
	x *= (2*XNUM_DATASIZE/PI);
	ruint32 i = (uint32)x;
	x -= i;
	return (1.0F-x)*SinI(i) + x*SinI(i+1);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

float32 xNUM::Cos(REGF(0) float32 x)
{
	x *= (2*XNUM_DATASIZE/PI);
	ruint32 i = (uint32)x;
	x -= i;
	return (1.0F-x)*CosI(i) + x*CosI(i+1);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

float32 xNUM::Tan(REGF(0) float32 x)
{
	x *= (2*XNUM_DATASIZE/PI);
	ruint32 i = (uint32)x;
	x -= i;

	// Below is optimized to get each sin / cosine pair read together, which increases chance of cache hit. i2 holds cosine index

	if (i<XNUM_DATASIZE)
	{
		ruint32 i2 = XNUM_DATASIZE-i;
		return ( (1.0F-x)*data[i] + x*data[i+1] ) / ( (1.0F-x)*data[i2] + x*data[i2+1] );
	}
	else if (i<(2*XNUM_DATASIZE))
	{
		ruint32 i2 = i-XNUM_DATASIZE; i = (2*XNUM_DATASIZE)-i;
		return ( -(1.0F-x)*data[i] - x*data[i+1] ) / ( (1.0F-x)*data[i2] + x*data[i2+1] );
	}
	else if (i<(3*XNUM_DATASIZE))
	{
		ruint32 i2 = (3*XNUM_DATASIZE)-i; i -= (2*XNUM_DATASIZE);
		return ( (1.0F-x)*data[i] + x*data[i+1]) / ( (1.0F-x)*data[i2] + x*data[i2+1] );
	}
	else if (i<(4*XNUM_DATASIZE))
	{
		ruint32 i2 = i-(3*XNUM_DATASIZE); i = (4*XNUM_DATASIZE)-i;
		return ( -(1.0F-x)*data[i] - x*data[i+1]) / ( (1.0F-x)*data[i2] + x*data[i2+1] );
	}
	else
	{
		ruint32 i2 = (5*XNUM_DATASIZE)-i; i -= (4*XNUM_DATASIZE);
		return ( (1.0F-x)*data[i] + x*data[i+1]) / ( (1.0F-x)*data[i2] + x*data[i2+1] );
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

float32 xNUM::ASin(REGF(0) float32 x)
{
	x *= XNUM_DATASIZE;
	if (x<0F)
	{
		x = -x;
		ruint32 i = (x - 0.5F);
		x -= i;
		return -(1.0F-x)*arcData[i] - x*arcData[i+1];
	}
	else
	{
		ruint32 i = (x - 0.5F);
		x	-= i;
		return (1.0F-x)*arcData[i] + x*arcData[i+1];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

float32 xNUM::ACos(REGF(0) float32 x)
{
	x *= XNUM_DATASIZE;
	if (x<0F)
	{
		x = -x;
		ruint32 i = (x - 0.5F);
		x -= i;
		return (PI/2) + (1.0F-x)*arcData[i] + x*arcData[i+1];
	}
	else
	{
		ruint32 i = (x - 0.5F);
		x	-= i;
		return (PI/2) - (1.0F-x)*arcData[i] - x*arcData[i+1];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

float32 xNUM::Exp(REGF(0) float32 x)
{
	rsint32 i = (x+0.5F);
	x -= (i-1);
	x *= XNUM_DATASIZE;
	ruint32 i2 = (x-0.5F);	x -= i2;
	return eInt[i+(-E_MIN_INT)]*( (1.0F-x)*eFrac[i2] + x*eFrac[i2+1]);
}
