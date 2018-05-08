//*****************************************************************//
//** Description:   xUtility library : numeric classes           **//
//** First Started: 2001-06-02                                   **//
//** Last Updated:  2001-06-02                                   **//
//** Author         Karl Churchill                               **//
//** Copyright:     (C)1998-2000, eXtropia Studios               **//
//**                Serkan YAZICI, Karl Churchill                **//
//**                All Rights Reserved.                         **//
//*****************************************************************//

#ifndef _XUTILITY_NUMERIC_HPP
#define _XUTILITY_NUMERIC_HPP

#include <xBase.hpp>

extern "C" {
	#include <math.h>
	#include <limits.h>
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// xNUM class
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//#define XNUM_GENSOURCE

#ifndef SMALL_DATA_A4
#define XNUM_HAND_OPTIMIZED // use hand coded funcs for large data model
#endif

#define XNUM_TABLE_SOURCE "EXTROPIALIB:lib/Common/xUtility/Numeric_Data.cpp"
#define XNUM_SIZE 10 									// Change this only.
#define XNUM_DATASIZE (1<<XNUM_SIZE)
#define E_MIN_INT (-88)								// exp(E_MIN_INT)         > minimum float32 (here 10^-38)
#define E_RANGE 	(176)								// exp(E_NIN_INT+E_RANGE) < maximum float32 (here 10^+38)
#define DBL_PI 3.1415926536						// double PI

class xNUM {
	private:
		// All high resolution tables have 1 extra entry to cover full range from v1 to v2 inclusive
		// Also, high resolution tables have 1 extra entry that remove need to check 'index 1 over' errors at runtime
		static float32	data[XNUM_DATASIZE+2];				// Holds XNUM_DATASIZE+2 points for sin(x)  : x = 0.0...PI/2
		static float32	arcData[XNUM_DATASIZE+2];			// Holds XNUM_DATASIZE+2 points for asin(x) : x = 0.0...1.0
		static float32	eFrac[XNUM_DATASIZE+2];				// Holds XNUM_DATASIZE+2 points for exp(x)  : x = -1.0...0
		static float32	eInt[E_RANGE];

	public:

		// TRIG METHODS

		// AngleModulus : any angle conversion to ranged (0-2PI)
		static float32	AngleMod(rfloat32 x) { if (x<0) return (2*PI)+fmod(x, 2*PI); else if (x<2*PI) return x; else return fmod(x, 2*PI); }
		static sint32		AngleModI(rsint32 i) { if (i<0) return (4*XNUM_DATASIZE)+(i% (4*XNUM_DATASIZE)); else if (i<(4*XNUM_DATASIZE)) return i; else return i%(4*XNUM_DATASIZE); }

		// Normal trig methods, perform linear interpolation of two nearest indexed values

	#ifdef XNUM_HAND_OPTIMIZED
		static float32	Sin(REGF(0) float32 x);
		static float32	Cos(REGF(0) float32 x);
		static float32	Tan(REGF(0) float32 x);
		static float32	Sin(REGF(0) float32 x);
		static float32	ASin(REGF(0) float32 x);
		static float32	ACos(REGF(0) float32 x);
		static float32	ATan(REGF(0) float32 x);
		static float32	Exp(REGF(0) float32 x);
	#else
		static float32	Sin(rfloat32 x);
		static float32	Cos(rfloat32 x);
		static float32	Tan(rfloat32 x);
		static float32	ASin(rfloat32 x);
		static float32	ACos(rfloat32 x);
		static float32	ATan(rfloat32 x);
		static float32	Exp(rfloat32 x);
	#endif

		// Quicker versions, inlined, choose closest indexed value
		static float32	SinQ(rfloat32 x);
		static float32	CosQ(rfloat32 x);
		static float32	TanQ(rfloat32 x);
		static float32	ASinQ(rfloat32 x);
		static float32	ACosQ(rfloat32 x);
		static float32	ATanQ(rfloat32 x);

		// Fastest versions, choose indexed value directly
		static float32	CosI(ruint32 i);
		static float32	TanI(ruint32 i);
		static float32	SinI(ruint32 i);


		// POWER METHODS
		static float32 ExpI(rsint32 i) { return (i<E_MIN_INT) ? 0 : ( (i>(E_MIN_INT+E_RANGE)) ? HUGE_VAL : eInt[i-E_MIN_INT]); }


		static void			Init();
		static void			Done();
		#ifdef XNUM_GENSOURCE
		static sint32		GenTables(char* fileName = XNUM_TABLE_SOURCE);
		static void			Test(ostream& out);
		#endif
};


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// xNUM INLINES
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inline	float32 xNUM::SinI(ruint32 i)
{
	if (i<XNUM_DATASIZE)
		return data[i];										// sin(0...PI/2)
	else if (i<(2*XNUM_DATASIZE))
		return data[(2*XNUM_DATASIZE)-i];	// sin(PI/2...PI)    : y axis reflection symmetrical to sin(0...PI/2)
	else if (i<(3*XNUM_DATASIZE))
		return -data[i-(2*XNUM_DATASIZE)];// sin(PI...3PI/2)   : x axis reflection symmetrical to sin(0...PI/2)
	else if (i<(4*XNUM_DATASIZE))
		return -data[(4*XNUM_DATASIZE)-i];// sin(3PI/2...2PI)  : x/y axis reflection symmetrical to sin(0...PI/2)
	else
		return data[i-4*XNUM_DATASIZE];		// to allow interpolator to wrap to first quater
}

inline	float32 xNUM::CosI(ruint32 i)
{
	if (i<XNUM_DATASIZE)
		return data[XNUM_DATASIZE-i];			// cos(0...PI/2) 	  : y axis reflection symmetrical to sin(0...PI/2)
	else if (i<(2*XNUM_DATASIZE))
		return -data[i-XNUM_DATASIZE];		// cos(PI/2...PI)   : x axis reflection symmetrical to sin(0...PI/2)
	else if (i<(3*XNUM_DATASIZE))
		return -data[(3*XNUM_DATASIZE)-i];// cos(PI...3PI/2)  : x/y axis reflection symmetrical to sin(0...PI/2)
	else if (i<(4*XNUM_DATASIZE))
		return data[i-(3*XNUM_DATASIZE)];	// cos(3PI/2...2PI) : congruent with sin(0...PI/2)
	else
		return data[5*XNUM_DATASIZE-i];		// to allow interpolator to wrap to first quater
}

inline	float32 xNUM::TanI(ruint32 i)
{
	if (i<XNUM_DATASIZE)
		return data[i]/data[XNUM_DATASIZE-i];
	else if (i<(2*XNUM_DATASIZE))
		return -data[(2*XNUM_DATASIZE)-i]/data[i-XNUM_DATASIZE];
	else if (i<(3*XNUM_DATASIZE))
		return data[i-(2*XNUM_DATASIZE)]/data[(3*XNUM_DATASIZE)-i];
	else if (i<(4*XNUM_DATASIZE))
		return -data[(4*XNUM_DATASIZE)-i]/data[i-(3*XNUM_DATASIZE)];
	else
		return data[i-4*XNUM_DATASIZE]/data[5*XNUM_DATASIZE-i];
}

inline float32 xNUM::SinQ(rfloat32 x)	{ return SinI((uint32)(0.5F+(2*XNUM_DATASIZE/PI)*x)); } // 0.5+ forces rounding for float to int conversion
inline float32 xNUM::CosQ(rfloat32 x) { return CosI((uint32)(0.5F+(2*XNUM_DATASIZE/PI)*x)); }
inline float32 xNUM::TanQ(rfloat32 x) { return TanI((uint32)(0.5F+(2*XNUM_DATASIZE/PI)*x)); } // TanQ is quite innacurate close to asymptote !
inline float32 xNUM::ASinQ(rfloat32 x) { x*=XNUM_DATASIZE; return (x<0F) ? -arcData[(uint32)(-0.5F-x)] : arcData[(uint32)(0.5F+x)];}
inline float32 xNUM::ACosQ(rfloat32 x) { x*=XNUM_DATASIZE; return (x<0F) ? (PI/2)+arcData[(uint32)(-0.5F-x)] : (PI/2)-arcData[(uint32)(0.5F+x)];}

#endif // _XUTILITY_NUMERIC_HPP
